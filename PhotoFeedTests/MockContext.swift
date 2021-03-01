//
//  MockContext.swift
//  PhotoFeedTests
//
//  Created by Pablo Ezequiel Romero Giovannoni on 01/03/2021.
//

import Foundation
@testable import PhotoFeed

class MockContext {
  let apiService: APIServiceProtocol

  init(apiServiceMappers: [MockAPIService.Mapper]) {
    self.apiService = MockAPIService(
      mappers: apiServiceMappers
    )
  }
}

extension MockContext: HasAPIService { }
