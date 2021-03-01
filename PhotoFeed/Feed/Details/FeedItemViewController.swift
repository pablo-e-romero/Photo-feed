//
//  FeedItemViewController.swift
//  PhotoFeed
//
//  Created by Pablo Ezequiel Romero Giovannoni on 01/03/2021.
//

import UIKit

class FeedItemViewController: UIViewController {

  private enum Sizes {
    static let padding: UIEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
    static let verticalSpacing: CGFloat = 5
  }

  private let item: FeedItemViewModel

  private let imageView: UIImageView = {
    let imageView = UIImageView(frame: .zero)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private let titleLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 17)
    label.textColor = .darkGray
    label.textAlignment = .center
    label.numberOfLines = 0
    return label
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

    view.backgroundColor = .lightGray

    setupHierarchy()
    setupContent()
  }

  private func setupHierarchy() {
    view.addSubview(imageView)
    view.addSubview(titleLabel)

    titleLabel.edgesToSuperviewMarings(includingEdges: [.leading, .bottom, .trailing])
    titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)

    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Sizes.padding.top),
      imageView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: Sizes.padding.left),
      imageView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: Sizes.padding.right),
      imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: Sizes.verticalSpacing),
      imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1)
    ])
  }

  private func setupContent() {
    imageView.setImageURL(item.imageURL)
    titleLabel.text = item.title
  }

}
