//
//  PhotoFeedAPI.swift
//  PhotoFeed
//
//  Created by Pablo Ezequiel Romero Giovannoni on 01/03/2021.
//

import Foundation

enum API {

  struct FetchPhotos: APIEndpoint {
    typealias ResultType = FetchPhotosResponse
    let path = "/photos"
  }

}

struct FetchPhotosResponse: APIResponseBase {
  let items: [PhotoItem]

  init(urlRequest: URLRequest, dataResponse: Data) throws {
    let decoder = JSONDecoder()
    self.items = try decoder.decode([PhotoItem].self, from: dataResponse)
  }

}
