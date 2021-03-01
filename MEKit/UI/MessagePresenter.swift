//
//  MessagePresenter.swift
//  PhotoFeed
//
//  Created by Pablo Ezequiel Romero Giovannoni on 01/03/2021.
//

import Foundation
import UIKit

protocol MessagePresenter {
  func presentAlert(with error: Error)
  func presentAlert(with message: String)
}

extension MessagePresenter where Self: UIViewController {

  func presentAlert(with error: Error) {
    presentAlert(with: error.localizedDescription)
  }

  func presentAlert(with message: String) {
    let alertController = UIAlertController(
      title: nil,
      message: message,
      preferredStyle: .alert)

    let okButton = UIAlertAction(
      title: NSLocalizedString("Ok", comment: ""),
      style: .cancel,
      handler: nil)

    alertController.addAction(okButton)
    present(alertController, animated: true, completion: nil)
  }

}
