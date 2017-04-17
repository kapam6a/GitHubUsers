//
//  UIImage.swift
//  GitHubUsers
//
//  Created by Kapam6a on 15.04.17.
//  Copyright © 2017 NoNameOrganization. All rights reserved.
//

import UIKit

extension UIImageView {
    public func image(with urlString: String) {
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: { [weak self] data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        guard let strongSelf = self else { return }
                        let image = UIImage(data: data)
                        strongSelf.image = image
                    }
                }
            }).resume()
        }
    }
}
