//
//  AppDiContainer.swift
//  CurrencyRates
//
//  Created by Ahmed Nour on 4/18/21.
//

import Foundation

final class AppDIContainer {

    lazy var appConfiguration = AppConfiguration()

    // MARK: - DIContainers of scenes
    func makeCurrencyListSceneDIContainer() -> CurrencySceneDiContainer {
        let dependencies = CurrencySceneDiContainer.Dependencies(apiBaseUrl: appConfiguration.apiBaseURL, apiKey: appConfiguration.apiKey)
        return CurrencySceneDiContainer(dependencies: dependencies)
    }
}
