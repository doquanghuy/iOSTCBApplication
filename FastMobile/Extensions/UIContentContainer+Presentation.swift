//
//  UIViewController+Presentation.swift
//  FastMobile
//
//  Created by duc on 9/25/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit

extension UIContentContainer {
    func presentedSize(with parentSize: CGSize) -> CGSize {
        assertionFailure("Should be implemented in subclasses")
        return .zero
    }
}
