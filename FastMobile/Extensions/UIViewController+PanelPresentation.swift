//
//  UIViewController+PanelPresentation.swift
//  FastMobile
//
//  Created by duc on 9/28/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit

extension UIViewController {
    private struct AssociatedKeys {
        static var TransitioningDelegate: UInt8 = 0
    }

    private var _storedTransitioningDelegate: UIViewControllerTransitioningDelegate? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.TransitioningDelegate) as? UIViewControllerTransitioningDelegate
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.TransitioningDelegate, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension UIViewController {
    func prepareToPresentAsPanel() {
        _storedTransitioningDelegate = PanelTransitioningDelegate()
        transitioningDelegate = _storedTransitioningDelegate
        modalPresentationStyle = .custom
    }
}

extension UIApplication {
    public static var isRunningTest: Bool {
        return ProcessInfo().arguments.contains("UITestMode")
    }
}
