//
//  AppFlowCoordinator.swift
//  CurrencyRates
//
//  Created by Ahmed Nour on 4/19/21.
//

import Foundation
import UIKit
final class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer

    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {

        let currencySceneDiContainer = appDIContainer.makeCurrencyListSceneDIContainer()
        let flow = currencySceneDiContainer.makeCurrecncyFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
