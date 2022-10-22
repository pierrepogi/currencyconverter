//
//  CurrencyModel.swift
//  Converter
//
//  Created by Pierre David on 10/22/22.
//

import Foundation

struct CurrencyModel {
    var amount: Double = 0.0
    var currency: String = ""
    
    init(amount dobAmount: Double, currency strCurrency: String) {
        amount = dobAmount
        currency = strCurrency
    }
    
}
