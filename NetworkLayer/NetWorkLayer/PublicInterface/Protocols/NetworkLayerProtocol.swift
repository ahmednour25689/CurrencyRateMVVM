//
//  NetworkLayerProtocol.swift
//  NetworkLayer
//
//  Created by Ahmed Nour on 6/18/20.
//  Copyright © 2020 Ahmed Nour. All rights reserved.
//

import Foundation

protocol NetworkLayerProtocol {
    associatedtype T: Codable
    static func createNetworkMangerInstance(baseUrl: String, path: String, params: [String: String]) -> NetworkManager<T>
}
