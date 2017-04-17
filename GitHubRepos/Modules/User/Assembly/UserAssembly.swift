//
//  UserAssembly.swift
//  GitHubUsers
//
//  Created by Kapam6a on 15.04.17.
//  Copyright © 2017 NoNameOrganization. All rights reserved.
//

import UIKit

class UserAssembly {
    func userModule(with id: Int) -> UIViewController {
        let viewController = UserViewController()
        let presenter = UserPresenter()
        let interactor = UserInteractor(userService: UserServiceAssembly().userService())
        let router = UserRouter()
        
        viewController.output = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        presenter.id = id
        
        interactor.output = presenter
        
        router.viewController = viewController
        
        return viewController
    }
}
