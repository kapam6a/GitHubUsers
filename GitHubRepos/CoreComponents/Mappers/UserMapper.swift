//
//  UserMapper.swift
//  GitHubUsers
//
//  Created by Kapam6a on 13.04.17.
//  Copyright © 2017 NoNameOrganization. All rights reserved.
//

import Foundation

protocol UserMapper {
    func mapUsers(_ data: Data) -> [User]
    func mapUser(_ data: Data) -> FullUser
}

class UserMapperImplementation: UserMapper {
    
    //MARK : UserMapper
    
    func mapUsers(_ data: Data) -> [User] {
        let usersArray = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String : Any]]
        
        var users: [User] = []
        
        usersArray.forEach { userDictionary in
            let login = userDictionary["login"] as! String
            let id = userDictionary["id"] as! Int
            
            let user = User(login: login,
                            id: id)
            users.append(user)
        }
        
        return users
    }
    
    func mapUser(_ data: Data) -> FullUser {
        let user = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
        return FullUser(avatarURL: user["avatar_url"] as! String,
                              login: user["login"] as! String,
                              id: user["id"] as! Int,
                              url: user["url"] as! String,
                              name: user["name"] as? String,
                              company: user["company"] as? String,
                              location: user["location"] as? String,
                              email: user["email"] as? String,
                              repos: user["public_repos"] as! Int,
                              followers: user["followers"] as! Int)
    }
}
