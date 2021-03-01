//
//  UICollectionView+Extension.swift
//  PhotoFeed
//
//  Created by Pablo Ezequiel Romero Giovannoni on 01/03/2021.
//

import UIKit

extension UICollectionView {

  func registerCell<T: UICollectionViewCell>(_ type: T.Type) {
    let cellIdentifier = String(describing: type)

    self.register(
      .init(nibName: cellIdentifier, bundle: nil),
      forCellWithReuseIdentifier: cellIdentifier
    )
  }

  func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
    return self.dequeueReusableCell(
      withReuseIdentifier: String(describing: T.self),
      for: indexPath) as! T
  }

}
