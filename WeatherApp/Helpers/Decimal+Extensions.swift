//
//  Double+Extensions.swift
//  WeatherApp
//
//  Created by Felipe Andrade on 16/09/22.
//

import Foundation

extension Decimal {
    func toNearestInt() -> Int {
        let value = NSDecimalNumber(decimal: self).rounding(accordingToBehavior: nil).int32Value
        return Int(value)
    }
    
    func toIntAsString() -> String {
        return "\(self.toNearestInt())"
    }
}
