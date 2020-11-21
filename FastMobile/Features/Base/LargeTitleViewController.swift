//
//  LargeTitleViewController.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 10/21/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import UIKit

class LargeTitleViewController: CustomBarViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard view.alpha != 1 else {
            return
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
            self.view.alpha = 1
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard view.alpha != 0 else {
            return
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
            self.view.alpha = 0
        }
    }
}

extension LargeTitleViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let nav = navigationController as? LargeBarNavigationViewController else { return }
        nav.scrollViewDidScroll(scrollView)
    }
}
