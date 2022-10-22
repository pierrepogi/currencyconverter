//
//  String.swift
//  Converter
//
//  Created by Pierre David on 10/22/22.
//

import Foundation

extension String {

    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }

}


extension Double {
 
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
