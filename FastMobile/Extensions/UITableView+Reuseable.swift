//
//  UITableView+Reuseable.swift
//  FastMobile
//
//  Created by Son le on 10/8/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ aClass: T.Type, bundle: Bundle? = .main) {
        let name = String(describing: aClass)
        if bundle?.path(forResource: name, ofType: "nib") != nil {
            let nib = UINib(nibName: name, bundle: bundle)
            register(nib, forCellReuseIdentifier: name)
        } else {
            register(aClass, forCellReuseIdentifier: name)
        }
    }

    func dequeue<T: UITableViewCell>(_ aClass: T.Type, indexPath: IndexPath) -> T {
        let name = String(describing: aClass)
        guard let cell = dequeueReusableCell(withIdentifier: name, for: indexPath) as? T else {
            fatalError("`\(name)` is not registed")
        }
        return cell
    }
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 15.0)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
