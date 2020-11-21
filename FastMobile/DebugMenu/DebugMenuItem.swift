//
//  DebugMenuItem.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 11/4/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import UIKit

#if DEBUG

struct DebugMenuSection {
    let name: String
    let items: [DebugMenuItem]
}

enum DebugMenuItemType {
    case `switch`
    case textField
    case selection
    case tapAction
}

struct DebugMenuItem {
    let type: DebugMenuItemType
    let name: String
    let value: String?
    let options: [String]?
    let action: ((String) -> Void)?
}

#endif
