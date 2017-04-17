//
//  ListPresenter.swift
//  GitHubUsers
//
//  Created by Kapam6a on 14.04.17.
//  Copyright © 2017 NoNameOrganization. All rights reserved.
//

import Foundation

class ListPresenter: ListViewOutput, ListInteractorOutput {
    weak var view: ListViewInput!
    var interactor: ListInteractorInput!
    var router: ListRouter!
    
    //MARK : ListViewOutput
    
    func viewDidLoad() {
        view.setupLoadingState()
        interactor.getUsers()
    }
    
    func didSelectUser(with id: Int) {
        router.openUserModule(with: id)
    }
    
    func didAppearLastItem() {
        interactor.getUsers()
    }
    
    //MARK : ListInteractorOutput
    
    func didGetUsersWithSuccess(_ users: [User]) {
        view.setupNormalState()
        view.update(with: users)
    }
    
    func didGetUsersWithFailure(_ error: Error) {
        view.setupNormalState()
        view.setupErrorState(with: error)
    }
}
