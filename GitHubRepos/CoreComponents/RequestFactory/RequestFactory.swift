//
//  RequestFactory.swift
//  GitHubUsers
//
//  Created by Kapam6a on 13.04.17.
//  Copyright © 2017 NoNameOrganization. All rights reserved.
//

import Foundation

protocol RequestFactory {
    func getUsersRequest(since userNumber: Int) -> URLRequest
    func getUserRequest(with id: Int) -> URLRequest
}

class RequestFactoryImplementation: RequestFactory {
    
    //MARK : RequestFactory
    
    func getUsersRequest(since userNumber: Int) -> URLRequest {
        let url = URL(string: "https://api.github.com/users?since=\(userNumber)")!
        return URLRequest(url: url)
    }
    
    func getUserRequest(with id: Int) -> URLRequest {
        let url = URL(string: "https://api.github.com/user/\(id)")!
        return URLRequest(url: url)
    }
}
