//
//  FeedViewModel.swift
//  PhotoFeed
//
//  Created by Pablo Ezequiel Romero Giovannoni on 01/03/2021.
//

import Foundation

protocol FeedViewModelFactory {
  func createFeedViewModel() -> FeedViewModel
}

extension DependencyContainer: FeedViewModelFactory {
  func createFeedViewModel() -> FeedViewModel {
    return FeedViewModel(context: self)
  }
}

struct FeedItemViewModel {
  let thumbnailURL: URL?
  let imageURL: URL?
  let title: String

  init(photoItem: PhotoItem) {
    self.thumbnailURL = photoItem.thumbnailUrl
    self.imageURL = photoItem.url
    self.title = photoItem.title
  }
}

class FeedViewModel {
  
  typealias Context = HasAPIService
  let ctx: Context

  private(set) var items: [FeedItemViewModel] = []

  init(context: Context) {
    self.ctx = context
  }

  func fetch(completion: @escaping (Error?) -> Void) {
    let endpoint = API.FetchPhotos()
    ctx.apiService.load(endpoint: endpoint) { [weak self] result in
      do {
        self?.items = try result.get().items.map(FeedItemViewModel.init)
        completion(nil)
      } catch {
        completion(error)
      }
    }
  }

}
