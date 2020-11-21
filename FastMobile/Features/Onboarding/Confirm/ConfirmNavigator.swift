//
//  ConfirmNavigator.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 11/1/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import UIKit

protocol ConfirmNavigator {
    func onConfirmDone()
}

class DefaultConfirmNavigator: ConfirmNavigator {
    
    private let navigationController: UINavigationController
    private let directViewController: UIViewController
    
    init(navigationController: UINavigationController,
         directViewController: UIViewController) {
        
        self.navigationController = navigationController
        self.directViewController = directViewController
    }
    
    func onConfirmDone() {
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(directViewController, animated: true)
    }
}
