//
//  PanelTransitioningDelegate.swift
//  FastMobile
//
//  Created by duc on 9/25/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit

class PanelTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    private let animationController = PanelAnimationController()
    private let interactionController = PanelInteractionController()

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = PanelPresentationController(presentedViewController: presented, presenting: presenting)
        interactionController.wireToViewController(viewController: presented)
        return presentationController
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animationController
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animationController
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if interactionController.interactionInProgress {
            return interactionController
        }
        return nil
    }
}
