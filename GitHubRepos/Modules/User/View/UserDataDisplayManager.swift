//
//  UserDataDisplayManager.swift
//  GitHubUsers
//
//  Created by Kapam6a on 15.04.17.
//  Copyright © 2017 NoNameOrganization. All rights reserved.
//

import UIKit

class UserDataDisplayManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    private weak var tableView: UITableView!
    private let cellObjectFactory: UserCellObjectFactory
    private var cellObjects: [CellObject]
    
    init(tableView: UITableView) {
        self.tableView = tableView
        cellObjectFactory = UserCellObjectFactory()
        cellObjects = []
        
        super.init()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    //MARK : Public methods
    
    func updateTableView(with user: FullUser) {
        cellObjects = cellObjectFactory.createCellObjects(with: user)
        cellObjects.forEach { cellObject in
            tableView.register(cellObject.cellClass, forCellReuseIdentifier: cellObject.identifier)
        }
    }
    
    //MARK : UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellObjects.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellObject = cellObjects[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellObject.identifier, for: indexPath) as! Cell
        cell.configure(with: cellObject)
        return cell as! UITableViewCell
    }
    
    //MARK : UITableViewDelegate
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellObject = cellObjects[indexPath.row]
        let cellClass = cellObject.cellClass as! Cell.Type
        return cellClass.height()
    }
}
