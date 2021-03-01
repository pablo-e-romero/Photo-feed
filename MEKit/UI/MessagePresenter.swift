//
//  MessagePresenter.swift
//  PhotoFeed
//
//  Created by Pablo Ezequiel Romero Giovannoni on 01/03/2021.
//

import Foundation
import UIKit

protocol MessagePresenter {
  func presentAlert(withError error: Error)
  func presentAlert(withMessage message: String)
}

extension MessagePresenter where Self: UIViewController {

  func presentAlert(withError error: Error) {
    presentAlert(withMessage: error.localizedDescription)
  }

  func presentAlert(withMessage message: String) {
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
