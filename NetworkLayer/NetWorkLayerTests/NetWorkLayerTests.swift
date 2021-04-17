//
//  NetworkLayerTests.swift
//  NetworkLayerTests
//
//  Created by Ahmed Nour on 6/14/20.
//  Copyright © 2020 Ahmed Nour. All rights reserved.
//

@testable import NetworkLayer
import XCTest

class NetworkLayerTests: XCTestCase {
    // MARK: Url Parts

    let apiBaseUrl = "api.nytimes.com"
    let getNewsPath = "/svc/mostpopular/v2/viewed/1.json"
    let wrongApiPath = "/svc/mostpopular/v2/viewed/1."
    let parameters: [String: String] = ["api-key": "jCMYgbYCbRPGDwkDKjb9Avhj41E1MVGn"]

    // MARK: - Variables

    var networkManager: NetworkManager<Response>?
    func test_NetworkManager_WhenIntialized_NotNull() {
        createValidNetworkManagerInstance()
        XCTAssertNotNil(networkManager, "network manager not initialized")
    }

    func test_GetData_WhenInvalidUrl_RetrunsError() {
        createInValidNetworkManagerInstance()
        let expectation = XCTestExpectation(description: "get data")
        networkManager?.getData(completion: { result in
            switch result {
            case .success:
                XCTFail("response returned")
            case let .failure(error):
                XCTAssertNotNil(error, "error not generated")
                expectation.fulfill()
            }
    })
        wait(for: [expectation], timeout: 10.0)
    }

    func test_GetData_WhenValidUrl_RetrunsResponse() {
        createValidNetworkManagerInstance()
        let expectation = XCTestExpectation(description: "get data")
        networkManager?.getData(completion: { result in
            switch result {
            case let .success(response):
                XCTAssertNotNil(response, "No data was downloaded.")
                expectation.fulfill()
            case .failure:
                XCTFail("error returned")
            }
    })
        wait(for: [expectation], timeout: 10.0)
    }

    func createValidNetworkManagerInstance() {
        networkManager = NetworkMangerInterface.createNetworkMangerInstance(baseUrl: apiBaseUrl, path: getNewsPath, params: parameters)
    }

    func createInValidNetworkManagerInstance() {
        networkManager = NetworkMangerInterface.createNetworkMangerInstance(baseUrl: apiBaseUrl, path: wrongApiPath, params: parameters)
    }
}
