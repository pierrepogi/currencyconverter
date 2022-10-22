//
//  AccountManager.swift
//  Converter
//
//  Created by Pierre David on 10/22/22.
//

import Foundation

class AccountManager {
    
    static func DeductBalance(amount: Double, currency: String) {
        for i in 0 ..< ACCOUNT.balance.count {
            let deduct = ACCOUNT.balance[i]
            if deduct.currency == currency {
                ACCOUNT.balance[i].amount -= amount.round(to: 2)
                print("DEDUCT: \(amount) \(currency)")
                break
            }
        }
    }

    static func AddBalance(amount: Double, currency: String) {
        for i in 0 ..< ACCOUNT.balance.count {
            let add = ACCOUNT.balance[i]
            if add.currency == currency {
                ACCOUNT.balance[i].amount += amount.round(to: 2)
                print("ADD: \(amount) \(currency)")
                break
            }
        }
    }
    
}


