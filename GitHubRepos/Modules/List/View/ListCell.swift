//
//  ListCell.swift
//  GitHubUsers
//
//  Created by Kapam6a on 15.04.17.
//  Copyright © 2017 NoNameOrganization. All rights reserved.
//

import UIKit

struct ListCellObject: CellObject {
    var cellClass: AnyClass {
        return ListCell.self
    }
    var identifier: String {
        return "ListCell"
    }
    var didSelect: (() -> Void)?
    let login: String
}

class ListCell: UITableViewCell, Cell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        
        textLabel?.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK : Cell
    
    func configure(with cellObject: CellObject) {
        let listCellObject = cellObject as! ListCellObject
        textLabel?.text = listCellObject.login
    }
}
