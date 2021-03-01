//
//  ConfigurableFlowLayout.swift
//  PhotoFeed
//
//  Created by Pablo Ezequiel Romero Giovannoni on 01/03/2021.
//

import UIKit

class ConfigurableFlowLayout: UICollectionViewFlowLayout {

  enum WidthType {
    case fixedWidth(value: CGFloat)
    case minColumnWidth(value: CGFloat)
    case availableWidth
  }

  enum HeightType {
    case fixedHeight(value: CGFloat)
    case ratio(value: CGFloat)
  }

  struct ItemSizeType {
    let width: WidthType
    let height: HeightType
  }

  var itemSizeType: ItemSizeType = ItemSizeType(width: .availableWidth, height: .ratio(value: 1)) {
    didSet {
      self.invalidateLayout()
      collectionView?.reloadData()
    }
  }

  override func prepare() {
    super.prepare()
    
    guard let cv = collectionView else { return }

    var availableWidth = cv.bounds.size.width

    switch sectionInsetReference {
    case .fromLayoutMargins:
      availableWidth -= (cv.layoutMargins.left + cv.layoutMargins.right)
    case .fromContentInset:
      availableWidth -= (cv.contentInset.left + cv.contentInset.right)
    case .fromSafeArea:
      availableWidth -= (cv.safeAreaInsets.left + cv.safeAreaInsets.right)
    @unknown default:
      fatalError()
    }

    var size = CGSize.zero

    switch itemSizeType.width {
    case .availableWidth:
      size.width = availableWidth
    case .minColumnWidth(let value):
      let maxNumColumns = CGFloat(Int(availableWidth / value))
      size.width = floor((availableWidth - (maxNumColumns - 1) * minimumInteritemSpacing) / maxNumColumns)
    case .fixedWidth(let value):
      size.width = value
    }

    switch itemSizeType.height {
    case .ratio(let value):
      size.height = size.width * value
    case .fixedHeight(let value):
      size.height = value
    }

    self.itemSize = size
  }

}
