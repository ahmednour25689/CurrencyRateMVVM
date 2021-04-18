//
//  CurrencyRatesUseCase.swift
//  CurrencyRates
//
//  Created by Ahmed Nour on 4/18/21.
//

import Foundation
protocol CurrencyRatesUseCase {
  func excute(currencyRequestDTO: CurrencyRequestDTO,completion: @escaping ([CurrencyListItemViewModel]?,Error?) -> Void)
}
final class DefaultCurrencyRatesUseCase: CurrencyRatesUseCase {
  private let currencyRepository: CurrencyRepository
  init(currencyRepository: CurrencyRepository) {
    self.currencyRepository = currencyRepository
  }

  func excute(currencyRequestDTO: CurrencyRequestDTO,completion: @escaping ([CurrencyListItemViewModel]?,Error?) -> Void) {
    currencyRepository.getCurrencyRates(with: currencyRequestDTO, completion: {
      response , error in
      completion(response,error)
    })

  }
}


