//
//  UserPresenter.swift
//  GitHubUsers
//
//  Created by Kapam6a on 15.04.17.
//  Copyright © 2017 NoNameOrganization. All rights reserved.
//

import Foundation

class UserPresenter: UserViewOutput, UserInteractorOutput {
    weak var view: UserViewInput!
    var interactor: UserInteractorInput!
    var router: UserRouterInput!
    
    var id: Int!
    
    //MARK : UserViewOutput
    
    func viewDidLoad() {
        view.setupLoadingState()
        interactor.getUser(with: id)
    }
    
    //MARK : UserInteractorOutput
    
    func didGetUserWithSuccess(_ user: FullUser) {
        view.setupNormalState()
        view.update(with: user)
    }

    func didGetUsersWithFailure(_ error: Error) {
        view.setupNormalState()
        view.setupErrorState(with: error)
    }
}
