//
//  UIViewController+Extensions.swift
//  TCBPay
//
//  Created by Duong Dinh on 7/29/20.
//  Copyright © 2020 teddy. All rights reserved.
//

import UIKit
import SWRevealViewController

extension UIViewController {
    
    func showAlert(title: String,
                   message: String,
                   okActionTitle: String? = "OK",
                   cancelActionTitle: String? = nil,
                   okAction: (() -> Void)? = nil,
                   okActionStyle: UIAlertAction.Style = .default,
                   cancelAction: (() -> Void)? = nil,
                   cancelActionStyle: UIAlertAction.Style = .cancel,
                   style: UIAlertController.Style,
                   completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        if okActionTitle != nil {
            let confirmAction = UIAlertAction(title: okActionTitle, style: okActionStyle) { (_) in
                okAction?()
            }
            alert.addAction(confirmAction)
        }
        
        if cancelActionTitle != nil {
            let cancelAction = UIAlertAction(title: cancelActionTitle, style: cancelActionStyle) { (_) in
                cancelAction?()
            }
            alert.addAction(cancelAction)
        }
        
        present(alert, animated: true, completion: completion)
    }
}

extension UIViewController {
    func embed(_ viewController: UIViewController, inView view: UIView) {
        viewController.willMove(toParent: self)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }
}
