//
//  ConverterViewController.swift
//  Converter
//
//  Created by Pierre David on 10/22/22.
//

import UIKit
import DropDown
import Actions

class ConverterViewController: UIViewController {
    
    @IBOutlet weak var collectionBalance: UICollectionView!
    @IBOutlet weak var heightCollectionBalance: NSLayoutConstraint!
    @IBOutlet weak var lblSellCurrency: UILabel!
    @IBOutlet weak var lblReceiveCurrency: UILabel!
    @IBOutlet weak var txtSell: UITextField!
    @IBOutlet weak var txtReceive: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    var dropDown = DropDown()
    
    var strSellCurrency: String = "EUR"
    var strReceiveCurrency: String = "USD"
    var strConversionType: String = ""
    
    var dobCommission: Double = 0.0
    var dobSell: Double = 0.0
    var dobReceive: Double = 0.0
    
    var intTransactions: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(PostBalanceDisplay), name:NSNotification.Name(rawValue: "PostBalanceDisplay"), object: nil)
        
        btnSubmit.addShadow()
        
        InitializeStartingAccountBalance()
        InitiateConverter()
        InitiateDropDown()
        SetTextSellListener()
        SetupCollection()
        UpdateBalanceDisplay()
        
    }
    
    
    @objc func PostBalanceDisplay() {
        UpdateBalanceDisplay()
        UIView.animate(withDuration: 0.3, delay: 0.3, animations: {
            self.collectionBalance?.scrollToItem(at: NSIndexPath.init(row: ACCOUNT.balance.count - 1, section: 0) as IndexPath, at: UICollectionView.ScrollPosition.left, animated: true)
        })
    }
    
    func InitializeStartingAccountBalance() {
        ACCOUNT.balance.removeAll()
        ACCOUNT.balance.append(CurrencyModel.init(amount: 1000, currency: "EUR"))
        ACCOUNT.balance.append(CurrencyModel.init(amount: 0, currency: "USD"))
        ACCOUNT.balance.append(CurrencyModel.init(amount: 0, currency: "JPY"))
    }
    
    func InitiateConverter() {
        dobSell = 0
        dobReceive = 0
        
        txtSell.text = ""
        txtReceive.text = ""
        lblSellCurrency.text = strSellCurrency
        lblReceiveCurrency.text = strReceiveCurrency
    }
    
    func InitiateDropDown() {
        dropDown.direction = .bottom
        dropDown.width = 60.0
        dropDown.backgroundColor = UIColor.white
        dropDown.cornerRadius = 4.0
    }
    
    func SetTextSellListener() {
        txtSell.throttle(.editingChanged, interval: 1.0) { [unowned self] (textField: UITextField) in
            CheckConversion()
        }
    }
    
    func CheckConversion() {
        txtReceive.text = ""
        if txtSell.text != "" {
            dobSell = (txtSell.text?.toDouble())!
            if dobSell != 0 {
                CallConversionAPI(isUpdate: false)
            }
        }
    }
    
    @IBAction func actionSell(_ sender: Any) {
        dropDown.anchorView = lblSellCurrency
        dropDown.dataSource = CURRENCIES.currency
        dropDown.show()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if item == strReceiveCurrency {
                lblReceiveCurrency.text = strSellCurrency
                strReceiveCurrency = strSellCurrency
            }
            lblSellCurrency.text = item
            strSellCurrency = item
            CheckConversion()
        }
    }
    
    @IBAction func actionReceive(_ sender: Any) {
        dropDown.anchorView = lblReceiveCurrency
        dropDown.dataSource = Helper.removeCurrencySetInSell(selected: strSellCurrency)
        dropDown.show()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            lblReceiveCurrency.text = item
            strReceiveCurrency = item
            CheckConversion()
        }
    }
    
    @IBAction func actionSubmit(_ sender: Any) {
        if txtSell.text == "" {
            showAlertMessage(title: "Invalid Amount", message: "Sell amount must not be blank.")
            
        } else {
            dobSell = (txtSell.text?.toDouble())!
            if dobSell == 0 {
                showAlertMessage(title: "Invalid Amount", message: "Sell amount must not be blank.")
                return
            }
            
            for res in ACCOUNT.balance {
                if res.currency == self.strSellCurrency {
                    if res.amount < self.dobSell {
                        showAlertMessage(title: "Insufficient Balance", message: "Sell amount must not be greater than your account balance.\n\nCurrent Balance: \(res.amount) \(res.currency)")
                        return
                    }
                }
            }
            
            showProgress()
            
            if intTransactions <= 5 {
                dobCommission = 0.0
                strConversionType = ConverterModel.type.free.rawValue
                
            } else if intTransactions % 10 == 0 {
                dobCommission = 0.0
                strConversionType = ConverterModel.type.free.rawValue
                
            } else if dobSell >= 200 {
                dobCommission = 0.0
                strConversionType = ConverterModel.type.free.rawValue
                
            } else {
                dobCommission = (dobSell * CURRENCIES.dobCommision)
                dobSell = dobSell - dobCommission
                strConversionType = ConverterModel.type.commission.rawValue
            }
            
            CallConversionAPI(isUpdate: true)
            
        }
    }
    
    func CallConversionAPI(isUpdate: Bool) {
        APIController.shared().getConversion(amount: dobSell, from: strSellCurrency, to: strReceiveCurrency) { (jsonMessage, converted) in
            if jsonMessage != nil {
                if isUpdate {
                    self.hideProgress()
                }
                self.showAlertMessage(title: "Converter Error", message: jsonMessage!)
                return
                
            } else {
                if isUpdate {
                    self.hideProgress()
                    
                    AccountManager.DeductBalance(amount: self.dobSell + self.dobCommission, currency: self.strSellCurrency)
                    AccountManager.AddBalance(amount: converted!.amount, currency: converted!.currency)
                    
                    switch self.strConversionType {
                    case ConverterModel.type.commission.rawValue:
                        self.showAlertMessage(title: "Currency Converted", message: "You have converted \(self.dobSell + self.dobCommission) \(self.strSellCurrency) to \(converted!.amount.round(to: 2)) \(converted!.currency).\nCommission Fee - \(self.dobCommission.round(to: 2)) \(self.strSellCurrency).")
                        
                    default:
                        self.showAlertMessage(title: "Currency Converted", message: "You have converted \(self.dobSell) \(self.strSellCurrency) to \(converted!.amount.round(to: 2)) \(converted!.currency).")
                    }
                    
                    self.InitiateConverter()
                    self.UpdateBalanceDisplay()
                    self.intTransactions += 1
                    
                } else {
                    self.txtReceive.textColor = UIColor.systemGreen
                    self.txtReceive.text = "\(converted!.amount.round(to: 2))"
                }
            }
        }
    }
    
    @IBAction func actionAddCurrency(_ sender: Any) {
        showAlertTextfield(title: "Add New Currency", message: "Enter the 3 letter code of the currency you want to add.", mode: CurrencyManager.mode.add)
    }
    
}


extension ConverterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func UpdateBalanceDisplay() {
        collectionBalance.delegate = self
        collectionBalance.dataSource = self
        collectionBalance.reloadData()
    }
    
    func SetupCollection() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (width / 3), height: 65)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        collectionBalance.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ACCOUNT.balance.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCurrencyCell
        let balance = ACCOUNT.balance[indexPath.row]
        cell.configure(balance: balance)
        return cell
    }
    
}
