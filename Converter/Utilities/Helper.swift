//
//  Helper.swift
//  Converter
//
//  Created by Pierre David on 10/22/22.
//

import Foundation

class Helper {
    
    static func removeCurrencySetInSell(selected: String) -> [String] {
        var temp = [String]()
        for res in CURRENCIES.currency {
            if res != selected {
                temp.append(res)
            }
        }
        return temp
    }
    
}
