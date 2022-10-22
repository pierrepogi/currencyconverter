//
//  ConverterModel.swift
//  Converter
//
//  Created by Pierre David on 10/22/22.
//

import Foundation
import SwiftyJSON

struct ConverterModel {
    var amount: Double = 0.0
    var currency: String = ""
    
    init?(json: JSON) {
        amount = json["amount"].doubleValue
        currency = json["currency"].stringValue
    }
    
    init(amount dobAmount: Double, currency strCurrency: String) {
        amount = dobAmount
        currency = strCurrency
    }
    
    enum type: String {
        case commission = "COMMISSION"
        case half = "HALF"
        case free = "free"
    }
}
