//
//  UserPhotoCell.swift
//  GitHubUsers
//
//  Created by Kapam6a on 15.04.17.
//  Copyright © 2017 NoNameOrganization. All rights reserved.
//

import UIKit

struct UserAvatarCellObject: CellObject {
    var cellClass: AnyClass {
        return UserAvatarCell.self
    }
    var identifier: String {
        return "UserAvatarCell"
    }
    var didSelect: (() -> Void)?
    let avatarURL: String
}

class UserAvatarCell: UITableViewCell, Cell {
    private let avatar: UIImageView
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        avatar = UIImageView(frame: .zero)
        
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        avatar.layer.borderColor = UIColor.gray.cgColor
        avatar.layer.borderWidth = 1
        avatar.layer.cornerRadius = 4
        avatar.clipsToBounds = true
        contentView.addSubview(avatar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = Layout(bounds: contentView.bounds)
        avatar.frame = layout.avatarFrame()
    }
    
    //MARK : Cell
    
    func configure(with cellObject: CellObject) {
        let userAvatarCellObject = cellObject as! UserAvatarCellObject
        avatar.image(with: userAvatarCellObject.avatarURL)
    }
    
    static func height() -> CGFloat {
        return 88
    }
}

fileprivate struct Layout {
    let bounds: CGRect
    
    private let offset: CGFloat = 4
    
    func avatarFrame() -> CGRect {
        return CGRect(x: 15,
                      y: offset,
                      width: bounds.height - 2 * offset,
                      height: bounds.height - 2 * offset)
    }
}
