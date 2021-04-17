//
//  Double+Extension.swift
//  CurrencyRates
//
//  Created by Ahmed Nour on 4/17/21.
//

import Foundation
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
