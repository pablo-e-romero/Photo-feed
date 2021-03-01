//
//  FileSystemHelper.swift
//  PhotoFeed
//
//  Created by Pablo Ezequiel Romero Giovannoni on 01/03/2021.
//

import UIKit

class FileSystemHelper {
  fileprivate static let fileManager: FileManager = .default

  static func existFile(at url: URL) -> Bool {
    return fileManager.fileExists(atPath: url.path)
  }

  static func removeFile(at fileURL: URL) throws {
    guard FileSystemHelper.existFile(at: fileURL) else { return }
    try fileManager.removeItem(at: fileURL)
  }
    
  static func copyFile(at initialUrl: URL, to finalURL: URL) throws {
    try removeFile(at: finalURL)
    try fileManager.copyItem(at: initialUrl, to: finalURL)
  }
    
  static func cachesUrl() -> URL {
    return fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
  }

  static func directoryURL() -> URL {
    return fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
  }

}
