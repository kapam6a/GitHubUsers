//
//  UserInteractor.swift
//  GitHubUsers
//
//  Created by Kapam6a on 15.04.17.
//  Copyright © 2017 NoNameOrganization. All rights reserved.
//

import Foundation

protocol UserInteractorInput {
    func getUser(with id: Int)
}

protocol UserInteractorOutput: class {
    func didGetUserWithSuccess(_ user: FullUser)
    func didGetUsersWithFailure(_ error: Error)
}

class UserInteractor: UserInteractorInput {
    weak var output: UserInteractorOutput!
    
    private let userService : UserService
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    //MARK : UserInteractorInput
    
    func getUser(with id: Int) {
        userService.getUser(with: id, success: { [weak self] user in
            guard let strongSelf = self else { return }
            strongSelf.output.didGetUserWithSuccess(user)
        }) { [weak self] error in
            guard let strongSelf = self else { return }
            strongSelf.output.didGetUsersWithFailure(error)
        }
    }
}
