//
//  MockAPIService.swift
//  PhotoFeedTests
//
//  Created by Pablo Ezequiel Romero Giovannoni on 01/03/2021.
//

import Foundation
@testable import PhotoFeed

class MockRequest: APIRequestProtocol {
  func cancel() { }
}

class MockAPIService: APIServiceProtocol {

  enum APIError: Error {
    case noMatch
    case resourceNotFound
    case decodingFailed
  }

  struct Mapper {
    let remoteURLPath: String
    let resourceName: String
  }

  private let mappers: [Mapper]

  init(mappers: [Mapper]) {
    self.mappers = mappers
  }

  func load<E: APIEndpoint>(
    endpoint: E,
    completion: @escaping (Result<E.ResultType, Error>) -> ()
  ) -> APIRequestProtocol {
    let urlRequest = endpoint.createURLRequest(baseURL: URL(string: "http://placeholder")!)
    let urlString = urlRequest.url?.path

    guard
      let mapper = mappers.first(
        where: { $0.remoteURLPath == urlString }
      )
    else {
      completion(.failure(APIError.noMatch))
      return MockRequest()
    }

    guard
      let localPath = Bundle(for: type(of: self)).path(
        forResource: mapper.resourceName,
        ofType: "json"
      )
    else {
      completion(.failure(APIError.resourceNotFound))
      return MockRequest()
    }

    do {
      let data = try Data(contentsOf: URL(fileURLWithPath: localPath))
      let response = try E.ResultType.init(
        urlRequest: urlRequest,
        dataResponse: data
      )
      completion(.success(response))
    } catch {
      completion(.failure(APIError.decodingFailed))
    }

    return MockRequest()
  }

}
