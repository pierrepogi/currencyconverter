//
//  Constants.swift
//  Converter
//
//  Created by Pierre David on 10/22/22.
//

import Foundation



struct URLs {
    static let baseURL = "http://api.evp.lt/"
}

struct CURRENCIES {
    static var currency = ["EUR", "USD", "JPY"]
    static var dobCommision: Double = 0.007
}

struct ACCOUNT {
    // NOTE: This will be used as a temporary database for the currencies on your account.
    // Ideally the account balance details will saved on the cloud via an API.
    static var balance = [CurrencyModel]()
}


