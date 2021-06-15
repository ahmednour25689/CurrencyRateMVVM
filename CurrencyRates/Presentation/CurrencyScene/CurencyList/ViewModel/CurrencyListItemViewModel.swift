//
//  CurrencyListItemViewModel.swift
//  CurrencyRates
//
//  Created by Ahmed Nour on 4/18/21.
//

import Foundation

struct CurrencyListItemViewModel {
    var currencyName: String
    var currencyRate: Double
}

extension CurrencyListItemViewModel {
    init(rate: CurrencyRate) {
        currencyName = rate.currencyName
        currencyRate = rate.currencyRate.rounded(toPlaces: 2)
    }
}
