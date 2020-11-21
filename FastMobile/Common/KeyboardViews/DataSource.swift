//
//  DataSource.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 9/23/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation
import UIKit

struct DataSource {
    let type: Section
    let isHorizontal: Bool
    var items: [Any?]?
    
    init(type: Section, isHorizontal: Bool = false, items: [Any?]? = nil) {
        self.type = type
        self.isHorizontal = isHorizontal
        self.items = items
    }
    
    mutating func appendItems(_ data: [Any], isRefresh: Bool = false) {
        var list = items ?? []
        if isRefresh {
            list.removeAll()
        }
        list.append(contentsOf: data)
        items = list
    }
    
    mutating func resetItems() {
        items?.removeAll()
    }
}
