//
//  ViewController.swift
//  GitHubUsers
//
//  Created by Kapam6a on 12.04.17.
//  Copyright © 2017 NoNameOrganization. All rights reserved.
//

import UIKit

protocol ListViewInput: class {
    func setupLoadingState()
    func setupNormalState()
    func update(with users: [User])
    func setupErrorState(with error: Error)
}

protocol ListViewOutput: class {
    func viewDidLoad()
    func didSelectUser(with id: Int)
    func didAppearLastItem()
}

class ListViewController: UIViewController, ListViewInput {
    var output: ListViewOutput! {
        didSet {
            dataDisplayManager.output = output
        }
    }
    
    private let activityIndicator: UIActivityIndicatorView
    private let tableView: UITableView
    private let dataDisplayManager: ListDataDisplayManager
    
    init() {
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        tableView = UITableView(frame: .zero, style: .plain)
        dataDisplayManager = ListDataDisplayManager(tableView: tableView)
        
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.title = "Users"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK : Life cycle view controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
        output.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let layout = Layout(bounds: view.bounds)
        activityIndicator.center = layout.activityIndicatorCenter()
        tableView.frame = layout.tableViewFrame()
    }
    
    //MARK : ListViewInput
    
    func setupLoadingState() {
        activityIndicator.startAnimating()
    }
    
    func setupNormalState() {
        activityIndicator.stopAnimating()
    }
    
    func update(with users: [User]) {
        dataDisplayManager.updateTableView(with: users)
        tableView.reloadData()
    }
    
    func setupErrorState(with error: Error) {
        showDefaultAlert(title: "Error",
                         message: error.localizedDescription)
    }
}

fileprivate struct Layout {
    let bounds: CGRect
    
    func tableViewFrame() -> CGRect {
        return CGRect(x: 0,
                      y: 0,
                      width: bounds.width,
                      height: bounds.height)
    }
    
    func activityIndicatorCenter() -> CGPoint {
        return CGPoint(x: bounds.width / 2,
                       y: bounds.height / 2)
    }
}

