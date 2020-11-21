//
//  PanelInteractionController.swift
//  FastMobile
//
//  Created by duc on 9/25/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit

class PanelInteractionController: UIPercentDrivenInteractiveTransition {
    private(set) var interactionInProgress = false
    private var shouldCompleteTransition = false
    private var beginTranslationY: CGFloat = 0
    private var panGestureRecognizer: UIPanGestureRecognizer?
    private weak var viewController: UIViewController?

    func wireToViewController(viewController: UIViewController) {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGestureRecognizer(_:)))
        panGestureRecognizer.delegate = self
        viewController.view.addGestureRecognizer(panGestureRecognizer)

        self.viewController = viewController
        self.panGestureRecognizer = panGestureRecognizer
    }

    // MARK: Private

    @objc private func handlePanGestureRecognizer(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let view = gestureRecognizer.view, let superview = view.superview else {
            return
        }

        switch gestureRecognizer.state {
        case .changed:
            if let srollView = gestureRecognizer.view as? UIScrollView ?? gestureRecognizer.view?.subviews.first as? UIScrollView, srollView.contentOffset.y > 0, percentComplete == 0 {
                return
            }
            let translation = gestureRecognizer.translation(in: superview)
            let rawProgress = (translation.y - beginTranslationY) / view.bounds.height
            let progress = CGFloat(fminf(fmaxf(Float(rawProgress), 0), 1))

            if interactionInProgress {
                shouldCompleteTransition = progress > 0.3
                update(progress)
            } else {
                interactionInProgress.toggle()
                beginTranslationY = translation.y
                viewController?.dismiss(animated: true)
            }
        case .cancelled, .failed, .ended:
            interactionInProgress = false
            beginTranslationY = 0

            if shouldCompleteTransition {
                finish()
            } else {
                cancel()
            }
        default:
            break
        }
    }
}

extension PanelInteractionController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
