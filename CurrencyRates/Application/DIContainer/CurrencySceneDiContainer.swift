//
//  CurrencySceneDiContainer.swift
//  CurrencyRates
//
//  Created by Ahmed Nour on 4/18/21.
//

import Foundation
import UIKit
final class CurrencySceneDiContainer {
  struct Dependencies {
      let apiBaseUrl: String
      let apiKey: String
  }
  private let dependencies: Dependencies

  // MARK: - Use Cases
  func makeCurrencyUseCase() -> CurrencyRatesUseCase {
    return DefaultCurrencyRatesUseCase(currencyRepository: makeCurrencyRepository())
  }
  init(dependencies: Dependencies) {
      self.dependencies = dependencies
  }

  // MARK: - Repositories
  func makeCurrencyRepository() -> CurrencyRepository {
    return DefaultCurrencyRepository(apiUrl: dependencies.apiBaseUrl, apiKey: dependencies.apiKey)
  }
  // MARK: - Currency rate List
  func makeCurrencyListViewController(actions: CurrencyListViewModelActions) -> CurrencyListViewController {
    return CurrencyListViewController.create(with: makeCurrencyListViewModel(actions: actions))
  }
  // MARK: - Currency conversion  view
  func makeCurrencyConverterViewController(fromCurrency: CurrencyListItemViewModel, toCurrency: CurrencyListItemViewModel) -> CurrencyConverterViewController {
    return CurrencyConverterViewController(fromCurrency: fromCurrency, toCurrency: toCurrency)
  }
  func makeCurrencyListViewModel(actions: CurrencyListViewModelActions) -> DefaultCurrencyListViewModel {
    return DefaultCurrencyListViewModel(currencyUseCase: makeCurrencyUseCase(), actions: actions)
  }
  // MARK: - Flow Coordinators
  func makeCurrecncyFlowCoordinator(navigationController: UINavigationController) -> CurrencySceneFlowCoordinator {
    return CurrencySceneFlowCoordinator(navigationController: navigationController,
                                        dependencies: self)
  }
}

extension CurrencySceneDiContainer: CurrencyRatesFlowCoordinatorDependencies {
}
