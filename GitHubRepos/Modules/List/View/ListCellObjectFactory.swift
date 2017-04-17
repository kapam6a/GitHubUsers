//
//  File.swift
//  GitHubUsers
//
//  Created by Kapam6a on 14.04.17.
//  Copyright © 2017 NoNameOrganization. All rights reserved.
//

import Foundation

class ListCellObjectFactory {
    weak var output: ListViewOutput!
    
    func createCellObjects(with users: [User]) -> [CellObject] {
        var cellObjects: [CellObject] = []
        
        users.forEach { user in
            let listCellObject = ListCellObject(didSelect: { [weak self] in
                                                   guard let strongSelf = self else { return }
                                                   strongSelf.output.didSelectUser(with: user.id)
                                                },
                                                login: user.login)
            cellObjects.append(listCellObject)
        }
        return cellObjects
    }
}
