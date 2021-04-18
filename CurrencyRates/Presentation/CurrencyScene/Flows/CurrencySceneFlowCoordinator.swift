//
//  CurrencySceneFlowCoordinator.swift
//  CurrencyRates
//
//  Created by Ahmed Nour on 4/18/21.
//

import Foundation
import UIKit
protocol CurrencyRatesFlowCoordinatorDependencies  {
  func makeCurrencyListViewController(actions: CurrencyListViewModelActions) -> CurrencyListViewController
  func makeCurrencyConverterViewController(fromCurrency : CurrencyListItemViewModel ,toCurrency : CurrencyListItemViewModel) -> CurrencyConverterViewController

}

final class CurrencySceneFlowCoordinator {

  private weak var navigationController: UINavigationController?
  private let dependencies: CurrencyRatesFlowCoordinatorDependencies


  init(navigationController: UINavigationController,
       dependencies: CurrencyRatesFlowCoordinatorDependencies) {
    self.navigationController = navigationController
    self.dependencies = dependencies
  }

  func start() {
    let vc = dependencies.makeCurrencyListViewController(actions: CurrencyListViewModelActions(showCurrencyConverterView: showCurrencyConverter))
    navigationController?.pushViewController(vc, animated: false)
  }
  func showCurrencyConverter(fromCurrency : CurrencyListItemViewModel, toCurrency : CurrencyListItemViewModel){
    let vc = dependencies.makeCurrencyConverterViewController(fromCurrency: fromCurrency, toCurrency: toCurrency)
    navigationController?.pushViewController(vc, animated: true)
  }
  private func goToConverionView(fromCurrency : CurrencyListItemViewModel ,toCurrency : CurrencyListItemViewModel) {
    let vc = dependencies.makeCurrencyConverterViewController(fromCurrency : fromCurrency ,toCurrency : toCurrency)
    navigationController?.pushViewController(vc, animated: true)
  }




}
