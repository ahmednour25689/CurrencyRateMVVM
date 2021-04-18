//
//  CurrencyRatesDTO+Mapping.swift
//  CurrencyRates
//
//  Created by Ahmed Nour on 4/17/21.
//

import Foundation

struct CurrencyRatesDTO: Codable, Serializable {
  var success: Bool
  var rates: [String: Double]?
  var error: ErrorDTO?
}
// MARK: - Mappings to Domain
extension CurrencyRatesDTO {
    func toDomain() -> [CurrencyRate]? {
      if let ratesData = rates {
        return ratesData.map({CurrencyRate(currencyName: $0, currencyRate: $1)})
      }
      return nil
    }
}
