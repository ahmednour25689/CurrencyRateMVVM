//
//  NetworkManager.swift
//  NetworkLayer
//
//  Created by Ahmed Nour on 6/14/20.
//  Copyright © 2020 Ahmed Nour. All rights reserved.
//

import Foundation
public final class NetworkManager<T: Codable> {
    /// Each network request returns a Result which contains either a decoded json or an `NetworkManager.Error`.
    public typealias NetworkResult = NetworkManager.Result<T, NetworkManager.Error>
    public typealias ResponseHandler = (NetworkResult) -> Void

    // MARK: - Properties

    /// Indicates whether debug mode is enabled or not.
    public var isDebug = false

    private let base: String
    private let path: String
    private let params: [String: String]
    private let session: URLSession

    // MARK: - Init

    ///
    /// - Parameters:
    ///   - session: A session which is used for downloading content. The default value is `URLSession.shared`.
    ///   - debug: Indicates if debug mode is enabled or not. In debug mode there will be an additional console output about the requested urls.
    internal init(session _: URLSession = URLSession.shared, baseUrl: String, path: String, params: [String: String], debug: Bool = false) {
        self.params = params
        base = baseUrl
        self.path = path
        session = URLSession(configuration: URLSessionConfiguration.default)
        isDebug = debug
    }

    // MARK: - getData Function

    ///
    /// - Parameters:
    ///   - completion: The completion handler which return the result of the API request.
    /// - Returns: The new session data task.
    @discardableResult
    public func getData(completion: @escaping ResponseHandler) -> URLSessionTask? {
        // build parameter dictionary
        guard let url = url(withPath: path, parameters: params) else {
            completion(.failure(.invalidURL))
            return nil
        }

        // print request for debug purposes
        if isDebug {
            print("Request url: \(url)")
        }

        // create data task
        let task = buildTask(withURL: url, completion: completion)

        // start task
        task.resume()

        return task
    }

    // MARK: - Helper

    private func buildTask(withURL url: URL, completion: @escaping ResponseHandler) -> URLSessionDataTask {
        return session.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidServerResponse))
                return
            }
            // check for successful status code
            guard 200 ... 299 ~= httpResponse.statusCode else {
                completion(.failure(.serverError(httpResponse.statusCode)))
                return
            }
            // check for valid data
            guard let data = data else {
                completion(.failure(.missingData))
                return
            }
            // try to decode the response json
            do {
                let decoder = JSONDecoder()
                let dataDecoded = try decoder.decode(T.self, from: data)

                completion(.success(dataDecoded))
            } catch {
                completion(.failure(.invalidJSON(error)))
            }
        }
    }

    // MARK: - URL

    private func url(withPath path: String, parameters: [String: String]) -> URL? {
        var components = URLComponents()
        components.scheme = "http"
        components.host = base
        components.path = path
        components.queryItems = parameters.map {
            URLQueryItem(name: $0.0, value: $0.1)
        }
        return components.url
    }
}
