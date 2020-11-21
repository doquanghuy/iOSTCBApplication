//
//  BaseNavigationViewController.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 9/23/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation
import UIKit

final class BaseNavigationViewController: UINavigationController {
    private var duringPushAnimation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationBar.barTintColor = .white
        navigationBar.shadowImage = UIImage()
        
        delegate = self
        interactivePopGestureRecognizer?.delegate = self
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        duringPushAnimation = true
        super.pushViewController(viewController, animated: animated)
    }
}

// MARK: - UINavigationControllerDelegate

extension BaseNavigationViewController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController, animated: Bool) {
        guard let swipeNavigationController = navigationController as? BaseNavigationViewController else { return }

        swipeNavigationController.duringPushAnimation = false
    }
}

// MARK: - UIGestureRecognizerDelegate

extension BaseNavigationViewController: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == interactivePopGestureRecognizer else {
            return true // default value
        }

        // Disable pop gesture in two situations:
        // 1) when the pop animation is in progress
        // 2) when user swipes quickly a couple of times and animations don't have time to be performed
        return viewControllers.count > 1 && duringPushAnimation == false
    }
}
