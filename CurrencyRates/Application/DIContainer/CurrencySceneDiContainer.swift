//
//  CurrencySceneDiContainer.swift
//  CurrencyRates
//
//  Created by Ahmed Nour on 4/18/21.
//

import Foundation
import UIKit
final class CurrencySceneDiContainer {

  // MARK: - Use Cases
  func makeCurrencyUseCase() -> CurrencyRatesUseCase {
    return DefaultCurrencyRatesUseCase(currencyRepository: makeCurrencyRepository())
  }
  // MARK: - Repositories
  func makeCurrencyRepository() -> CurrencyRepository {
    return DefaultCurrencyRepository()
  }
  // MARK: - Currency rate List
  func makeCurrencyListViewController() -> CurrencyListViewController {
    return CurrencyListViewController.create(with: makeCurrencyListViewModel())
  }
  // MARK: - Currency conversion  view
  func makeCurrencyConverterViewController(fromCurrency: CurrencyListItemViewModel, toCurrency: CurrencyListItemViewModel) -> CurrencyConverterViewController {
    return CurrencyConverterViewController(fromCurrency: fromCurrency, toCurrency: toCurrency)
  }
  func makeCurrencyListViewModel() -> DefaultCurrencyListViewModel {
    return DefaultCurrencyListViewModel(currencyUseCase: makeCurrencyUseCase())
  }
  // MARK: - Flow Coordinators
  func makeCurrecncyFlowCoordinator(navigationController: UINavigationController) -> CurrencySceneFlowCoordinator {
    return CurrencySceneFlowCoordinator(navigationController: navigationController,
                                        dependencies: self)
  }
}

extension CurrencySceneDiContainer: CurrencyRatesFlowCoordinatorDependencies {
}
