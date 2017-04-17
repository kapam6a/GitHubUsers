//
//  UserCellObjectsFactory.swift
//  GitHubUsers
//
//  Created by Kapam6a on 15.04.17.
//  Copyright © 2017 NoNameOrganization. All rights reserved.
//

import Foundation

class UserCellObjectFactory {
    func createCellObjects(with user: FullUser) -> [CellObject] {
        var cellObjects: [CellObject] = []
        
        let avatarCellObject = UserAvatarCellObject(didSelect: nil,
                                                    avatarURL: user.avatarURL)
        cellObjects.append(avatarCellObject)
        
        let nameCellObject = UserCellObject(didSelect: nil,
                                            title: "name",
                                            detail: user.name ?? "")
        cellObjects.append(nameCellObject)
        
        let companyCellObject = UserCellObject(didSelect: nil,
                                            title: "company",
                                            detail: user.company ?? "")
        cellObjects.append(companyCellObject)
        
        let locationCellObject = UserCellObject(didSelect: nil,
                                            title: "location",
                                            detail: user.location ?? "")
        cellObjects.append(locationCellObject)
        
        let emailCellObject = UserCellObject(didSelect: nil,
                                            title: "email",
                                            detail: user.email ?? "")
        cellObjects.append(emailCellObject)
        
        let reposCellObject = UserCellObject(didSelect: nil,
                                            title: "repos",
                                            detail: String(user.repos))
        cellObjects.append(reposCellObject)
        
        let followersCellObject = UserCellObject(didSelect: nil,
                                            title: "followers",
                                            detail: String(user.followers))
        cellObjects.append(followersCellObject)
        
        return cellObjects
    }
}
