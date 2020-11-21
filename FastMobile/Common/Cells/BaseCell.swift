//
//  BaseCell.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 9/23/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation
import UIKit

class BaseCell: UICollectionViewCell {
    var dataSource: DataSource?
    var indexPath: IndexPath = IndexPath(item: 0, section: 0)
    weak var actionHandler: CellActionProtocol?
    
    func setup(with dataSource: DataSource? = nil,
               index: IndexPath = IndexPath(item: 0, section: 0),
               actionHandler: CellActionProtocol? = nil) {

        self.dataSource = dataSource
        self.indexPath = index
        self.actionHandler = actionHandler
    }
}
