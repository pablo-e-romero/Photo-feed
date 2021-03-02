//
//  Owned.swift
//  PhotoFeed
//
//  Created by Pablo Ezequiel Romero Giovannoni on 01/03/2021.
//

import Foundation


struct OwnedKeys {
    static var ownerKey: String = "OwnerKey"
}

protocol Owned: AnyObject {
    var owner: Any? { get set }
}

extension Owned {

  var owner: Any? {
    get {
      return objc_getAssociatedObject(self, &OwnedKeys.ownerKey)
    }

    set {
      if let currentOwner = objc_getAssociatedObject(self, &OwnedKeys.ownerKey) {
        objc_setAssociatedObject(currentOwner, &OwnedKeys.ownerKey, nil, .OBJC_ASSOCIATION_ASSIGN)
        objc_setAssociatedObject(self, &OwnedKeys.ownerKey, nil, .OBJC_ASSOCIATION_ASSIGN)
      }

      if let newValue = newValue {
        objc_setAssociatedObject(newValue, &OwnedKeys.ownerKey, self, .OBJC_ASSOCIATION_RETAIN)
        objc_setAssociatedObject(self, &OwnedKeys.ownerKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
      }
    }
  }

}
