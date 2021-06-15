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
        DefaultCurrencyRatesUseCase(currencyRepository: makeCurrencyRepository())
    }

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Repositories
    func makeCurrencyRepository() -> CurrencyRepository {
        DefaultCurrencyRepository(apiUrl: dependencies.apiBaseUrl, apiKey: dependencies.apiKey)
    }

    // MARK: - Currency rate List
    func makeCurrencyListViewController(actions: CurrencyListViewModelActions) -> CurrencyListViewController {
        CurrencyListViewController.create(with: makeCurrencyListViewModel(actions: actions))
    }

    // MARK: - Currency conversion  view
    func makeCurrencyConverterViewController(fromCurrency: CurrencyListItemViewModel, toCurrency: CurrencyListItemViewModel) -> CurrencyConverterViewController {
        CurrencyConverterViewController(fromCurrency: fromCurrency, toCurrency: toCurrency)
    }

    func makeCurrencyListViewModel(actions: CurrencyListViewModelActions) -> DefaultCurrencyListViewModel {
        DefaultCurrencyListViewModel(currencyUseCase: makeCurrencyUseCase(), actions: actions)
    }

    // MARK: - Flow Coordinators
    func makeCurrencyFlowCoordinator(navigationController: UINavigationController) -> CurrencySceneFlowCoordinator {
        CurrencySceneFlowCoordinator(navigationController: navigationController,
                dependencies: self)
    }
}

extension CurrencySceneDiContainer: CurrencyRatesFlowCoordinatorDependencies {
}
