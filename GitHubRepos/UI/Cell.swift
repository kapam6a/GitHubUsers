//
//  Cell.swift
//  GitHubUsers
//
//  Created by Kapam6a on 15.04.17.
//  Copyright © 2017 NoNameOrganization. All rights reserved.
//

import UIKit

protocol CellObject {
    var cellClass: AnyClass { get }
    var identifier: String { get }
    var didSelect: (() -> Void)? { get set }
}

protocol Cell {
    func configure(with cellObject: CellObject)
    static func height() -> CGFloat
}

extension Cell {
    static func height() -> CGFloat {
        return 44
    }
}
