//
//  ListInteractor.swift
//  GitHubUsers
//
//  Created by Kapam6a on 14.04.17.
//  Copyright © 2017 NoNameOrganization. All rights reserved.
//

import Foundation

protocol ListInteractorInput {
    func getUsers()
}

protocol ListInteractorOutput: class {
    func didGetUsersWithSuccess(_ users: [User])
    func didGetUsersWithFailure(_ error: Error)
}

class ListInteractor: ListInteractorInput {
    weak var output: ListInteractorOutput!
    
    private var lastId: Int
    private let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
        lastId = 0
    }
    
    //MARK : ListInteractorInput
    
    func getUsers() {
        userService.getUsers(since:lastId, success: { [weak self] users in
            guard let strongSelf = self else { return }
            strongSelf.lastId = users.last!.id
            strongSelf.output.didGetUsersWithSuccess(users)
        }) { [weak self] error in
            guard let strongSelf = self else { return }
            strongSelf.output.didGetUsersWithFailure(error)
        }
    }
}
