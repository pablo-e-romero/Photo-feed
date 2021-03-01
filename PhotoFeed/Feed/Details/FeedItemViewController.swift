//
//  FeedItemViewController.swift
//  PhotoFeed
//
//  Created by Pablo Ezequiel Romero Giovannoni on 01/03/2021.
//

import UIKit

class FeedItemViewController: UIViewController {

  private let item: FeedItemViewModel

  lazy var imageView: UIImageView = {
    let imageView = UIImageView(frame: .zero)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  init(item: FeedItemViewModel) {
    self.item = item
    super.init(nibName: nil, bundle: nil)
    self.title = "Photo Details"
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white

    view.addSubview(imageView)
    imageView.edgesToSuperview()

    imageView.setImageURL(item.imageURL)
  }

}
