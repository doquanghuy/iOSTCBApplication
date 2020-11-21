//
// Copyright © 2020 Backbase R&D B.V. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    static func search(target: Any?, action: Selector?) -> UIBarButtonItem {
        return .init(image: #imageLiteral(resourceName: "ic_search"), style: .plain, target: target, action: action)
    }

    static func info(target: Any?, action: Selector?) -> UIBarButtonItem {
        return .init(image: #imageLiteral(resourceName: "ic_info"), style: .plain, target: target, action: action)
    }

    static func delete(target: Any?, action: Selector?) -> UIBarButtonItem {
        return .init(image: #imageLiteral(resourceName: "ic_delete"), style: .plain, target: target, action: action)
    }

    static func edit(target: Any?, action: Selector?) -> UIBarButtonItem {
        return .init(image: #imageLiteral(resourceName: "ic_edit"), style: .plain, target: target, action: action)
    }

    static func filter(target: Any?, action: Selector?) -> UIBarButtonItem {
        return .init(image: #imageLiteral(resourceName: "ic_filter_list"), style: .plain, target: target, action: action)
    }

    static func cancel(target: Any?, action: Selector?) -> UIBarButtonItem {
        return .init(title: "shared_alert_button_cancel".localized, style: .done, target: target, action: action)
    }

    static func reset(target: Any?, action: Selector?) -> UIBarButtonItem {
        let item = UIBarButtonItem(title: "shared_alert_button_reset".localized, style: .done, target: target, action: action)
        item.tintColor = DefaultDesign.colors.supportDanger
        return item
    }

    static func close(target: Any?, action: Selector?, tintColor: UIColor? = nil) -> UIBarButtonItem {
        let item = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_close"), style: .plain, target: target, action: action)
        item.tintColor = tintColor
        return item
    }

    static func settings(target: Any?, action: Selector?) -> UIBarButtonItem {
        return .init(image: #imageLiteral(resourceName: "ic_settings"), style: .plain, target: target, action: action)
    }

    static func done(target: Any?, action: Selector?) -> UIBarButtonItem {
        return .init(barButtonSystemItem: .done, target: target, action: action)
    }

    static func add(target: Any?, action: Selector?) -> UIBarButtonItem {
        return .init(barButtonSystemItem: .add, target: target, action: action)
    }

    static func activityIndicator(color: UIColor? = nil) -> UIBarButtonItem {
        let view = UIActivityIndicatorView()
        view.color = color
        view.startAnimating()
        return .init(customView: view)
    }

    static var space: UIBarButtonItem {
        return .init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    }
}
