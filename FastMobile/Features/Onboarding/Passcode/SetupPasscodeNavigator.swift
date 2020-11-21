//
//  SetupPasscodeNavigator.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 11/2/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import UIKit

protocol SetupPasscodeNavigator {
    func onEnabled()
    func onSkip()
    func onClose()
}

class DefaultSetupPasscodeNavigator: SetupPasscodeNavigator {
    
    private let navigationController: UINavigationController
    private let directViewController: UIViewController
    
    init(navigationController: UINavigationController,
         directViewController: UIViewController) {
        
        self.navigationController = navigationController
        self.directViewController = directViewController
    }
    
    func onEnabled() {
        navigationController.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.navigationController.pushViewController(self.directViewController,
                                                         animated: true)
        }
    }
    
    func onSkip() {
        navigationController.dismiss(animated: true) {  [weak self] in
            guard let self = self else { return }
            self.navigationController.pushViewController(self.directViewController,
                                                         animated: true)
        }
    }
    
    func onClose() {
        navigationController.dismiss(animated: true)
    }
}
