//
//  UIApplication+Toast.swift
//  FastMobile
//
//  Created by Son le on 10/5/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation
import Toast_Swift

extension UIApplication {

    static func hideAllToast() {
        DispatchQueue.main.async {
            guard let topController = UIApplication.shared.topMostController() else {
                return
            }
            
            topController.view.hideAllToasts()
        }
    }
    
    func topMostController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
}
