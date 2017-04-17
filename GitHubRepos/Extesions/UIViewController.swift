//
//  UIViewController.swift
//  GitHubUsers
//
//  Created by Kapam6a on 15.04.17.
//  Copyright © 2017 NoNameOrganization. All rights reserved.
//

import UIKit

extension UIViewController {
    func showDefaultAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK",
                               style: .cancel,
                               handler: nil)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
