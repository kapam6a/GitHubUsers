//
//  File.swift
//  GitHubUsers
//
//  Created by Kapam6a on 13.04.17.
//  Copyright © 2017 NoNameOrganization. All rights reserved.
//

import Foundation

class UserServiceAssembly {
    func userService() -> UserService {
        let networkClient = NetworkClientImplementation()
        let mapper = UserMapperImplementation()
        let requestFactory = RequestFactoryImplementation()
        return UserServiceImplementation(networkClient: networkClient,
                                         mapper: mapper,
                                         requestFactory: requestFactory)
    }
}
