//
//  FeedCoordinator.swift
//  PhotoFeed
//
//  Created by Pablo Ezequiel Romero Giovannoni on 01/03/2021.
//

import UIKit

class FeedCoordinator: Coordinator {

  typealias Context = FeedViewModelFactory
  private let ctx: Context
  private weak var navVC: UINavigationController?

  init(context: Context, navVC: UINavigationController) {
    self.ctx = context
    self.navVC = navVC
  }

  func start(animated: Bool) {
    guard let navVC = navVC else {
      fatalError("Invalid navVC")
    }

    let vc = FeedViewController(
      viewModel: ctx.createFeedViewModel()
    )

    owner = vc

    vc.delegate = self
    navVC.pushViewController(vc, animated: animated)
  }

  private func showFeedItemViewController(item: FeedItemViewModel, animated: Bool) {
    let vc = FeedItemViewController(item: item)
    navVC?.pushViewController(vc, animated: animated)
  }
  
}

extension FeedCoordinator: FeedViewControllerDelegate {

  func selectFeedItem(vc: FeedViewController, item: FeedItemViewModel) {
    showFeedItemViewController(item: item, animated: true)
  }

}
