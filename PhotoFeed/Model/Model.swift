//
//  Model.swift
//  PhotoFeed
//
//  Created by Pablo Ezequiel Romero Giovannoni on 01/03/2021.
//

import Foundation

struct PhotoItem: Decodable {
  let albumId: Int
  let id: Int
  let title: String
  let url: URL
  let thumbnailUrl: URL
}
