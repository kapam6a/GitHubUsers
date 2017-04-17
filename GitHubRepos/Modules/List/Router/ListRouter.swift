//
//  ListRouter.swift
//  GitHubUsers
//
//  Created by Kapam6a on 14.04.17.
//  Copyright © 2017 NoNameOrganization. All rights reserved.
//

import UIKit

protocol ListRouterInput {
    func openUserModule(with id: Int)
}

class ListRouter: ListRouterInput {
    weak var viewController: UIViewController!
    
    //MARK : ListRouterInput
    
    func openUserModule(with id: Int) {
        let userViewController = UserAssembly().userModule(with: id)
        viewController.navigationController!.pushViewController(userViewController, animated: true)
    }
}
