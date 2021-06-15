//
//  ErrorDTO+Mapping.swift
//  CurrencyRates
//
//  Created by Ahmed Nour on 4/18/21.
//

import Foundation

struct ErrorDTO: Codable {
    var code: Int
    var type: String
}
