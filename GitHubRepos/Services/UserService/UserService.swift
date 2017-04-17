//
//  UserService.swift
//  GitHubUsers
//
//  Created by Kapam6a on 13.04.17.
//  Copyright © 2017 NoNameOrganization. All rights reserved.
//

import Foundation

struct User {
    let login: String
    let id: Int
}

struct FullUser {
    let avatarURL: String
    let login: String
    let id: Int
    let url: String
    let name: String?
    let company: String?
    let location: String?
    let email: String?
    let repos: Int
    let followers: Int
}

protocol UserService {
    func getUsers(since userNumber: Int, success: @escaping ([User]) -> Void, failure: @escaping (Error) -> Void)
    func getUser(with id: Int, success: @escaping (FullUser) -> Void, failure: @escaping (Error) -> Void)
}

class UserServiceImplementation: UserService {
    private let networkClient: NetworkClient
    private let mapper: UserMapper
    private let requestFactory: RequestFactory
    
    init(networkClient: NetworkClient, mapper: UserMapper, requestFactory: RequestFactory) {
        self.networkClient = networkClient
        self.mapper = mapper
        self.requestFactory = requestFactory
    }
    
    //MARK : UserService
    
    func getUsers(since userNumber: Int, success: @escaping ([User]) -> Void, failure: @escaping (Error) -> Void) {
        networkClient.send(request: requestFactory.getUsersRequest(since: userNumber),
                           success: { [weak self] data in
                            guard let strongSelf = self else { return }
                            let users = strongSelf.mapper.mapUsers(data)
                            success(users)
                            
        }) { error in
            failure(error)
        }
    }
    
    func getUser(with id: Int, success: @escaping (FullUser) -> Void, failure: @escaping (Error) -> Void) {
        networkClient.send(request: requestFactory.getUserRequest(with: id),
                           success: { [weak self] data in
                            guard let strongSelf = self else { return }
                            let user = strongSelf.mapper.mapUser(data)
                            success(user)
        }) { error in
            failure(error)
        }
    }

}
