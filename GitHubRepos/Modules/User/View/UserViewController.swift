//
//  UserViewController.swift
//  GitHubUsers
//
//  Created by Kapam6a on 15.04.17.
//  Copyright © 2017 NoNameOrganization. All rights reserved.
//

import UIKit

protocol UserViewInput: class {
    func setupLoadingState()
    func setupNormalState()
    func update(with user: FullUser)
    func setupErrorState(with error: Error)
}

protocol UserViewOutput {
    func viewDidLoad()
}

class UserViewController: UIViewController, UserViewInput {
    var output: UserViewOutput!
    
    private let activityIndicator: UIActivityIndicatorView
    private let tableView: UITableView
    private let dataDisplayManager: UserDataDisplayManager
    
    init() {
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        tableView = UITableView(frame: .zero, style: .grouped)
        dataDisplayManager = UserDataDisplayManager(tableView: tableView)
        
        super.init(nibName: nil, bundle: nil)
        
        tableView.bounces = false
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
    
    //MARK : UserViewInput
    
    func setupLoadingState() {
        activityIndicator.startAnimating()
    }
    
    func setupNormalState() {
        activityIndicator.stopAnimating()
    }
    
    func update(with user: FullUser) {
        navigationItem.title = user.login
        dataDisplayManager.updateTableView(with: user)
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
