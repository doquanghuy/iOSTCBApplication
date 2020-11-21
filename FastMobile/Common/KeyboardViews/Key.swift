//
//  Key.swift
//  CustomKeyboard
//
//  Created by Pham Thanh Hoa on 9/18/20.
//  Copyright © 2020 Pham Thanh Hoa. All rights reserved.
//

import Foundation
import UIKit

enum KeyType {
    case number
    case unit
    case delete
    case enter

    var backgroundColor: UIColor {
        switch self {
        case .enter:
            return .black
        default:
            return .grayBackground
        }
    }

    var textColor: UIColor {
        switch self {
        case .enter:
            return .white
        default:
            return .black
        }
    }

    var font: UIFont {
        switch self {
        case .enter:
            return .boldSystemFont(ofSize: 21)
        default:
            return .boldSystemFont(ofSize: 24)
        }
    }

    var icon: UIImage? {
        switch self {
        case .delete:
            return UIImage(named: "ic_delete_key")
        default:
            return nil
        }
    }

    var ratio: CGSize {
        let height = UIDevice.current.userInterfaceIdiom == .pad ? 0.3 : 0.7

        switch self {
        case .delete:
            return CGSize(width: 1.1375, height: height * 2)
        case .enter:
            return CGSize(width: 1.1375, height: height * 2)
        case .unit:
            return CGSize(width: 2, height: height)
        default:
            return CGSize(width: 1, height: height)
        }
    }
}

struct Key {
    let type: KeyType
    let value: String?

    init(type: KeyType, value: String? = nil) {
        self.type = type

        switch type {
        case .delete:
            self.value = value ?? "x"
        case .enter:
            self.value = value ?? "Enter"
        default:
            self.value = value
        }
    }
}
