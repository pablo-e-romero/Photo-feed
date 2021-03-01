//
//  FeedViewController.swift
//  PhotoFeed
//
//  Created by Pablo Ezequiel Romero Giovannoni on 01/03/2021.
//

import UIKit

protocol FeedViewControllerDelegate: AnyObject {
  func selectFeedItem(vc: FeedViewController, item: FeedItemViewModel)
}

class FeedViewController: UIViewController, MessagePresenter {

  private let viewModel: FeedViewModel
  weak var delegate: FeedViewControllerDelegate?

  private lazy var collectionView: UICollectionView = {
    let layout = ConfigurableFlowLayout()
    layout.itemSizeType = .init(
      width: .minColumnWidth(value: 200),
      height: .ratio(value: 1)
    )

    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: layout
    )

    collectionView.translatesAutoresizingMaskIntoConstraints = false

    collectionView.delegate = self
    collectionView.dataSource = self

    collectionView.registerCell(FeedItemCell.self)

    return collectionView
  }()

  init(viewModel: FeedViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    self.title = "Photos Feed"
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white

    view.addSubview(collectionView)
    collectionView.edgesToSuperviewSafeArea()

    fetch()
  }

  private func fetch() {
    viewModel.fetch { [weak self] error in
      guard let self = self else { return }
      self.collectionView.refreshControl?.endRefreshing()
      if let error = error {
        self.presentAlert(with: error)
      } else {
        self.collectionView.reloadData()
      }
    }
  }

  private func configureRefreshControl() {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: .valueChanged)

    collectionView.refreshControl = refreshControl
    collectionView.sendSubviewToBack(refreshControl)
  }

  @objc func refreshControlAction(_ sender: AnyObject) {
    fetch()
  }

}


// MARK: -

extension FeedViewController: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.items.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let item = viewModel.items[indexPath.row]
    let cell: FeedItemCell = collectionView.dequeueReusableCell(for: indexPath)

    cell.configure(with: item)

    return cell
  }

}

// MARK: -

extension FeedViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let item = viewModel.items[indexPath.row]
    self.delegate?.selectFeedItem(vc: self, item: item)
  }

}
