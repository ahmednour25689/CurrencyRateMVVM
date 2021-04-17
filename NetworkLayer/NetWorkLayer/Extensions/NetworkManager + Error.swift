//
//  NetworkManager + Error.swift
//  NetworkLayer
//
//  Created by Ahmed Nour on 6/14/20.
//  Copyright © 2020 Ahmed Nour. All rights reserved.
//

import Foundation
public extension NetworkManager {
    enum Error: Swift.Error {
        case unknown
        case invalidURL
        case invalidServerResponse
        case serverError(Int)
        case missingData
        case invalidJSON(Swift.Error)
    }
}
