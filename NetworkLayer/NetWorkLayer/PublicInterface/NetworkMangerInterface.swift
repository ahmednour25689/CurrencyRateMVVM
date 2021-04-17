//
//  NetworkMangerInterface.swift
//  NetworkLayer
//
//  Created by Ahmed Nour on 6/14/20.
//  Copyright © 2020 Ahmed Nour. All rights reserved.
//

import Foundation
public final class NetworkMangerInterface<T: Codable>: NetworkLayerProtocol {
    public static func createNetworkMangerInstance(baseUrl: String, path: String, params: [String: String]) -> NetworkManager<T> {
        return NetworkManager(baseUrl: baseUrl, path: path, params: params)
    }
}
