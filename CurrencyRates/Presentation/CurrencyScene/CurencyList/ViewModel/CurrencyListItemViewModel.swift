//
//  CurrencyListItemViewModel.swift
//  CurrencyRates
//
//  Created by Ahmed Nour on 4/18/21.
//

import Foundation
struct CurrencyListItemViewModel {
  var currencyName : String
  var currencyRate : Double
}
extension CurrencyListItemViewModel {
  init(currancyRate : CurrencyRate) {
    self.currencyName = currancyRate.currencyName
    self.currencyRate = currancyRate.currencyRate.rounded(toPlaces: 2)
  }
}
