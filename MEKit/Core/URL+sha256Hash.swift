//
//  URL+sha256Hash.swift
//  PhotoFeed
//
//  Created by Pablo Ezequiel Romero Giovannoni on 01/03/2021.
//

import Foundation

extension URL {

  func md5Hash() -> String {

      // Source: http://iosdeveloperzone.com/2014/10/03/using-commoncrypto-in-swift/

      let string = self.path

      let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
      var digest = Array<UInt8>(repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
      CC_MD5_Init(context)
      CC_MD5_Update(context, string, CC_LONG(string.lengthOfBytes(using: String.Encoding.utf8)))
      CC_MD5_Final(&digest, context)
      context.deallocate()
      var hexString = ""
      for byte in digest {
          hexString += String(format:"%02x", byte)
      }

      return hexString
  }
    
}
