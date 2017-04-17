//
//  ListAssembly.swift
//  GitHubUsers
//
//  Created by Kapam6a on 14.04.17.
//  Copyright © 2017 NoNameOrganization. All rights reserved.
//

import UIKit

class ListAssembly {
    func listModule() -> UIViewController {
        let viewController = ListViewController()
        let presenter = ListPresenter()
        let interactor = ListInteractor(userService: UserServiceAssembly().userService())
        let router = ListRouter()
        
        viewController.output = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        router.viewController = viewController
        
        return viewController
    }
}
