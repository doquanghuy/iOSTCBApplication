//
//  PanelPresentationController.swift
//  FastMobile
//
//  Created by duc on 9/25/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import RxSwift

class PanelPresentationController: UIPresentationController {
    private let disposeBag = DisposeBag()
    private var dimmingView: UIView!

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        let presentedViewSize = size(forChildContentContainer: presentedViewController,
                        withParentContainerSize: containerView.bounds.size)
        return CGRect(
            x: 0,
            y: containerView.bounds.height - presentedViewSize.height,
            width: presentedViewSize.width,
            height: presentedViewSize.height
        )
    }

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        setupDimmingView()
    }

    // MARK: Private

    private func setupDimmingView() {
        dimmingView = UIView()
        dimmingView.backgroundColor = UIColor(white: 0, alpha: 0.6)
        dimmingView.alpha = 0

        let recognizer = UITapGestureRecognizer()
        dimmingView.addGestureRecognizer(recognizer)

        recognizer.rx.event
            .subscribe { [unowned self] _ in
                self.presentingViewController.dismiss(animated: true)
            }.disposed(by: disposeBag)
    }

    override func presentationTransitionWillBegin() {
        guard let containerView = containerView, let presentedView = presentedView else { return }

        dimmingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dimmingView.frame = containerView.bounds
        containerView.insertSubview(dimmingView, at: 0)

        presentedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        presentedView.frame = frameOfPresentedViewInContainerView

        containerView.layoutIfNeeded()

        animateDimmingView(to: 1)
    }

    override func dismissalTransitionWillBegin() {
        animateDimmingView(to: 0)
    }

    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return container.size(forChildContentContainer: container, withParentContainerSize: parentSize)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        guard let containerView = containerView else { return }
        coordinator.animate { _ in
            self.dimmingView.frame = containerView.bounds
            self.presentedView?.frame = self.frameOfPresentedViewInContainerView
        }
    }

    private func animateDimmingView(to alpha: CGFloat) {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = alpha
            return
        }
        coordinator.animate { _ in
            self.dimmingView.alpha = alpha
        }
    }

    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
}
