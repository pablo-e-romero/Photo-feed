//
//  FeedViewModelTests.swift
//  PhotoFeedTests
//
//  Created by Pablo Ezequiel Romero Giovannoni on 01/03/2021.
//

import XCTest
@testable import PhotoFeed

class FeedViewModelTests: XCTestCase {

  var viewModel: FeedViewModel!

  override func setUpWithError() throws {
    self.viewModel = FeedViewModel(
      context: MockContext(
        apiServiceMappers: [
          .init(
            remoteURLPath: "/photos",
            resourceName: "photos"
          )
        ]
      )
    )
  }

  override func tearDownWithError() throws {
    self.viewModel = nil
  }

  func testFetch() throws {
    let expectation = self.expectation(description: "Fetched")

    viewModel.fetch { _ in
      expectation.fulfill()
    }

    self.waitForExpectations(timeout: 1, handler: nil)

    XCTAssertEqual(viewModel.items.count, 2)
    XCTAssertEqual(viewModel.items.first?.title, "Item 1")
  }

}
