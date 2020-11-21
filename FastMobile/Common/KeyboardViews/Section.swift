//
//  Section.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 9/23/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation
import UIKit

enum Section {
    case segment
    case textField
    case dropList
    case switchItem
    
    var height: CGFloat {
        switch self {
        case .segment:
            return 32
        case .textField, .dropList:
            return 48
        case .switchItem:
            return 27
        }
    }
    
    var cellClass: BaseCell.Type {
        switch self {
        case .segment:
            return SegmentControlCell.self
        case .textField:
            return TextFieldCell.self
        case .dropList:
            return DropListCell.self
        case .switchItem:
            return SwitchCell.self
        }
    }
    
    var numberOfColumns: Int {
        switch self {
        default:
            return 1
        }
    }
}
