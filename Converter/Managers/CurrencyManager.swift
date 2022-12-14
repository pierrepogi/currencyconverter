//
//  CurrencyManager.swift
//  Converter
//
//  Created by Pierre David on 10/22/22.
//

import Foundation

class CurrencyManager {
    
    static func AddCurrency(currency: String) -> String {
        if CURRENCIES.currency.contains(currency) {
            return "\(currency) is already in your Account Wallet"
        } else {
            var isValid: Bool = false
            for res in list {
                if res.first! == currency {
                    isValid = true
                    break
                }
            }
            
            if isValid {
                CURRENCIES.currency.append(currency)
                ACCOUNT.balance.append(CurrencyModel.init(amount: 0.0, currency: currency))
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PostBalanceDisplay"), object: nil)
                return "Successfully added \(currency)"
                
            } else {
                return "\(currency) is currently not in the World Currencies"
            }
            
        }
        
    }
    
    enum mode {
      case add, remove
    }
    
    static var list = [
        ["AED", "United Arab Emirates dirham"],
        ["AFN", "Afghan afghani"],
        ["ALL", "Albanian lek"],
        ["AMD", "Armenian dram"],
        ["ANG", "Netherlands Antillean guilder"],
        ["AOA", "Angolan kwanza"],
        ["ARS", "Argentine peso"],
        ["AUD", "Australian dollar"],
        ["AWG", "Aruban florin"],
        ["AZN", "Azerbaijani manat"],
        ["BAM", "Bosnia and Herzegovina convertible mark"],
        ["BBD", "Barbados dollar"],
        ["BDT", "Bangladeshi taka"],
        ["BGN", "Bulgarian lev"],
        ["BHD", "Bahraini dinar"],
        ["BIF", "Burundian franc"],
        ["BMD", "Bermudian dollar"],
        ["BND", "Brunei dollar"],
        ["BOB", "Boliviano"],
        ["BRL", "Brazilian real"],
        ["BSD", "Bahamian dollar"],
        ["BTN", "Bhutanese ngultrum"],
        ["BWP", "Botswana pula"],
        ["BYN", "New Belarusian ruble"],
        ["BYR", "Belarusian ruble"],
        ["BZD", "Belize dollar"],
        ["CAD", "Canadian dollar"],
        ["CDF", "Congolese franc"],
        ["CHF", "Swiss franc"],
        ["CLF", "Unidad de Fomento"],
        ["CLP", "Chilean peso"],
        ["CNY", "Renminbi|Chinese yuan"],
        ["COP", "Colombian peso"],
        ["CRC", "Costa Rican colon"],
        ["CUC", "Cuban convertible peso"],
        ["CUP", "Cuban peso"],
        ["CVE", "Cape Verde escudo"],
        ["CZK", "Czech koruna"],
        ["DJF", "Djiboutian franc"],
        ["DKK", "Danish krone"],
        ["DOP", "Dominican peso"],
        ["DZD", "Algerian dinar"],
        ["EGP", "Egyptian pound"],
        ["ERN", "Eritrean nakfa"],
        ["ETB", "Ethiopian birr"],
        ["EUR", "Euro"],
        ["FJD", "Fiji dollar"],
        ["FKP", "Falkland Islands pound"],
        ["GBP", "Pound sterling"],
        ["GEL", "Georgian lari"],
        ["GHS", "Ghanaian cedi"],
        ["GIP", "Gibraltar pound"],
        ["GMD", "Gambian dalasi"],
        ["GNF", "Guinean franc"],
        ["GTQ", "Guatemalan quetzal"],
        ["GYD", "Guyanese dollar"],
        ["HKD", "Hong Kong dollar"],
        ["HNL", "Honduran lempira"],
        ["HRK", "Croatian kuna"],
        ["HTG", "Haitian gourde"],
        ["HUF", "Hungarian forint"],
        ["IDR", "Indonesian rupiah"],
        ["ILS", "Israeli new shekel"],
        ["INR", "Indian rupee"],
        ["IQD", "Iraqi dinar"],
        ["IRR", "Iranian rial"],
        ["ISK", "Icelandic kr??na"],
        ["JMD", "Jamaican dollar"],
        ["JOD", "Jordanian dinar"],
        ["JPY", "Japanese yen"],
        ["KES", "Kenyan shilling"],
        ["KGS", "Kyrgyzstani som"],
        ["KHR", "Cambodian riel"],
        ["KMF", "Comoro franc"],
        ["KPW", "North Korean won"],
        ["KRW", "South Korean won"],
        ["KWD", "Kuwaiti dinar"],
        ["KYD", "Cayman Islands dollar"],
        ["KZT", "Kazakhstani tenge"],
        ["LAK", "Lao kip"],
        ["LBP", "Lebanese pound"],
        ["LKR", "Sri Lankan rupee"],
        ["LRD", "Liberian dollar"],
        ["LSL", "Lesotho loti"],
        ["LYD", "Libyan dinar"],
        ["MAD", "Moroccan dirham"],
        ["MDL", "Moldovan leu"],
        ["MGA", "Malagasy ariary"],
        ["MKD", "Macedonian denar"],
        ["MMK", "Myanmar kyat"],
        ["MNT", "Mongolian t??gr??g"],
        ["MOP", "Macanese pataca"],
        ["MRO", "Mauritanian ouguiya"],
        ["MUR", "Mauritian rupee"],
        ["MVR", "Maldivian rufiyaa"],
        ["MWK", "Malawian kwacha"],
        ["MXN", "Mexican peso"],
        ["MXV", "Mexican Unidad de Inversion"],
        ["MYR", "Malaysian ringgit"],
        ["MZN", "Mozambican metical"],
        ["NAD", "Namibian dollar"],
        ["NGN", "Nigerian naira"],
        ["NIO", "Nicaraguan c??rdoba"],
        ["NOK", "Norwegian krone"],
        ["NPR", "Nepalese rupee"],
        ["NZD", "New Zealand dollar"],
        ["OMR", "Omani rial"],
        ["PAB", "Panamanian balboa"],
        ["PEN", "Peruvian Sol"],
        ["PGK", "Papua New Guinean kina"],
        ["PHP", "Philippine peso"],
        ["PKR", "Pakistani rupee"],
        ["PLN", "Polish z??oty"],
        ["PYG", "Paraguayan guaran??"],
        ["QAR", "Qatari riyal"],
        ["RON", "Romanian leu"],
        ["RSD", "Serbian dinar"],
        ["RUB", "Russian ruble"],
        ["RWF", "Rwandan franc"],
        ["SAR", "Saudi riyal"],
        ["SBD", "Solomon Islands dollar"],
        ["SCR", "Seychelles rupee"],
        ["SDG", "Sudanese pound"],
        ["SEK", "Swedish krona"],
        ["SGD", "Singapore dollar"],
        ["SHP", "Saint Helena pound"],
        ["SLL", "Sierra Leonean leone"],
        ["SOS", "Somali shilling"],
        ["SRD", "Surinamese dollar"],
        ["SSP", "South Sudanese pound"],
        ["STD", "S??o Tom?? and Pr??ncipe dobra"],
        ["SVC", "Salvadoran col??n"],
        ["SYP", "Syrian pound"],
        ["SZL", "Swazi lilangeni"],
        ["THB", "Thai baht"],
        ["TJS", "Tajikistani somoni"],
        ["TMT", "Turkmenistani manat"],
        ["TND", "Tunisian dinar"],
        ["TOP", "Tongan pa??anga"],
        ["TRY", "Turkish lira"],
        ["TTD", "Trinidad and Tobago dollar"],
        ["TWD", "New Taiwan dollar"],
        ["TZS", "Tanzanian shilling"],
        ["UAH", "Ukrainian hryvnia"],
        ["UGX", "Ugandan shilling"],
        ["USD", "United States dollar"],
        ["UYI", "Uruguay Peso en Unidades Indexadas"],
        ["UYU", "Uruguayan peso"],
        ["UZS", "Uzbekistan som"],
        ["VEF", "Venezuelan bol??var"],
        ["VND", "Vietnamese ?????ng"],
        ["VUV", "Vanuatu vatu"],
        ["WST", "Samoan tala"],
        ["XAF", "Central African CFA franc"],
        ["XCD", "East Caribbean dollar"],
        ["XOF", "West African CFA franc"],
        ["XPF", "CFP franc"],
        ["XXX", "No currency"],
        ["YER", "Yemeni rial"],
        ["ZAR", "South African rand"],
        ["ZMW", "Zambian kwacha"],
        ["ZWL", "Zimbabwean dollar"]
    ]
    
}
