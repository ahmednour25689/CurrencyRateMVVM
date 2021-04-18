//
//  CurrencyRepository.swift
//  CurrencyRates
//
//  Created by Ahmed Nour on 4/18/21.
//

import Foundation
protocol CurrencyRepository {
  func getCurrencyRates(with currencyRequestDTO: CurrencyRequestDTO, completion: @escaping ([CurrencyListItemViewModel]?, Error?) -> Void)
}
