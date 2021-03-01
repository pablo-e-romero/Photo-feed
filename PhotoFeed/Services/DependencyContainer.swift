//
//  DependencyContainer.swift
//  Marvel-client
//
//  Created by Pablo Ezequiel Romero Giovannoni on 05/01/2021.
//

import Foundation

class DependencyContainer {
    static let baseURL = URL(string: "http://jsonplaceholder.typicode.com")!
    lazy var apiService: APIServiceProtocol = APIService(baseURL: Self.baseURL)
}

protocol HasAPIService {
    var apiService: APIServiceProtocol { get }
}

extension DependencyContainer: HasAPIService { }
