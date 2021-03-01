//
//  FeedItemCell.swift
//  PhotoFeed
//
//  Created by Pablo Ezequiel Romero Giovannoni on 01/03/2021.
//

import UIKit

class FeedItemCell: UICollectionViewCell {

  @IBOutlet weak var thumbnailImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!

  override func awakeFromNib() {
      super.awakeFromNib()

  }

  func configure(with viewModel: FeedItemViewModel) {
    self.thumbnailImageView.setImageURL(viewModel.thumbnailURL)
    self.titleLabel.text = viewModel.title
  }

}
