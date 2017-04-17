//
//  UserCell.swift
//  GitHubUsers
//
//  Created by Kapam6a on 15.04.17.
//  Copyright © 2017 NoNameOrganization. All rights reserved.
//

import UIKit

struct UserCellObject: CellObject {
    var cellClass: AnyClass {
        return UserCell.self
    }
    var identifier: String {
        return "UserCell"
    }
    var didSelect: (() -> Void)?
    let title: String
    let detail: String
}

class UserCell: UITableViewCell, Cell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        
        textLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        detailTextLabel?.font = UIFont.italicSystemFont(ofSize: 11)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK : Cell
    
    func configure(with cellObject: CellObject) {
        let userCellObject = cellObject as! UserCellObject
        textLabel?.text = userCellObject.title
        detailTextLabel?.text = userCellObject.detail
    }
}
