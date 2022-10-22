//
//  CustomCurrencyCell.swift
//  Converter
//
//  Created by Pierre David on 10/22/22.
//

import UIKit

class CustomCurrencyCell: UICollectionViewCell {
    
    @IBOutlet weak var lblDisplay: UILabel!
    
    func configure(balance: CurrencyModel) {
        lblDisplay.text = "\(balance.amount.round(to: 2)) " + balance.currency
    }
    
}
