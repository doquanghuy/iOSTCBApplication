//
//  ViewShaker.swift
//  FastMobile
//
//  Created by Duong Dinh on 10/7/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit

class ViewShaker: NSObject {
    private var views: [UIView]
    private var completionBlock: (() -> Void)?
    private var completedAnimations = 0
    private let viewShakerAnimationKey = "kAFViewShakerAnimationKey"
    private let viewShakerDuration = 0.5
    
    init(viewsArray: [UIView]) {
        self.views = viewsArray
    }
    
    func shake() {
        shakeWithDuration(duration: viewShakerDuration, completion: nil)
    }
    
    func shakeWithDuration(duration: TimeInterval, completion: (() -> Void)?) {
        completionBlock = completion
        for view in views {
            addShakeAnimationForView(view, withDuration: duration)
        }
    }
    
    func addShakeAnimationForView(_ view: UIView, withDuration duration: TimeInterval) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        let currentTx = view.transform.tx
        animation.delegate = self
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.values = [currentTx, currentTx + 10, currentTx - 8, currentTx + 8, currentTx - 5, currentTx + 5, currentTx]
        animation.keyTimes = [0, 0.225, 0.425, 0.6, 0.75, 0.875, 1]
        
        view.layer.add(animation, forKey: viewShakerAnimationKey)
    }
}

extension ViewShaker: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        completedAnimations += 1
        guard completedAnimations >= views.count else { return }
        completedAnimations = 0
        completionBlock?()
    }
}
