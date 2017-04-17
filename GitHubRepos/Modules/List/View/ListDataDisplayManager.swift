//
//  ListDataDisplayManager.swift
//  GitHubUsers
//
//  Created by Kapam6a on 12.04.17.
//  Copyright © 2017 NoNameOrganization. All rights reserved.
//

import UIKit

class ListDataDisplayManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    weak var output: ListViewOutput! {
        didSet {
            cellObjectFactory.output = output
        }
    }
    
    private weak var tableView: UITableView!
    private let cellObjectFactory: ListCellObjectFactory
    private var cellObjects: [CellObject]
    
    init(tableView: UITableView) {
        self.tableView = tableView
        cellObjectFactory = ListCellObjectFactory()
        cellObjects = []
        
        super.init()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    //MARK : Public methods
    
    func updateTableView(with users: [User]) {
        let newCellObjects = cellObjectFactory.createCellObjects(with: users)
        cellObjects.append(contentsOf: newCellObjects)
        newCellObjects.forEach { cellObject in
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellObjects[indexPath.row].didSelect?()
    }
    
    //MARK : UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y == (scrollView.contentSize.height - scrollView.bounds.height) {
            output.didAppearLastItem()
        }
    }
}
