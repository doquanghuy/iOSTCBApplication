//
//  PanelAnimationController.swift
//  FastMobile
//
//  Created by duc on 9/25/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit

class PanelAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    private static var presentDuration: TimeInterval = 0.25
    private static var dismissDuration: TimeInterval = 0.15

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        let fromView = transitionContext?.viewController(forKey: .from)
        return fromView != nil ? PanelAnimationController.presentDuration : PanelAnimationController.dismissDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
              let fromView = transitionContext.view(forKey: .from) ?? fromViewController.view,
              let toViewController = transitionContext.viewController(forKey: .to),
              let toView = transitionContext.view(forKey: .to) ?? toViewController.view else {
            return
        }

        let toPresentingViewController = toViewController.presentingViewController
        let presenting = toPresentingViewController == fromViewController

        let containerView = transitionContext.containerView
        if presenting {
            containerView.addSubview(toView)
        }

        let animatingView = presenting ? toView: fromView

        animatingView.frame = CGRect(
            x: 0,
            y: presenting ? containerView.bounds.height : containerView.bounds.height - animatingView.bounds.height,
            width: animatingView.bounds.width,
            height: animatingView.bounds.height
        )
        let finalFrame = CGRect(
            x: 0,
            y: presenting ? containerView.bounds.height - animatingView.bounds.height : containerView.bounds.height,
            width: animatingView.bounds.width,
            height: animatingView.bounds.height
        )

        let transitionDuration = self.transitionDuration(using: transitionContext)

        UIView.animateKeyframes(withDuration: transitionDuration, delay: 0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                animatingView.frame = finalFrame
            }
        }, completion: { _ in
            if !presenting, !transitionContext.transitionWasCancelled {
                fromView.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
