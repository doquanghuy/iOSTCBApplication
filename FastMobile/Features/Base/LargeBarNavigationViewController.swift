//
//  LargeBarNavigationViewController.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 10/21/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class LargeBarNavigationViewController: UINavigationController {
    
    private lazy var backgrounBar: UIImageView = {
        
        let image = UIImage(named: "home_background")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0,
                                 y: 0,
                                 width: UIScreen.main.bounds.size.width,
                                 height: image?.size.height ?? 0)
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        
        view.backgroundColor = .white
        view.addSubview(backgrounBar)
        view.sendSubviewToBack(backgrounBar)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let frame = backgrounBar.frame
        backgrounBar.frame = CGRect(x: frame.origin.x,
                                    y: frame.origin.y,
                                    width: UIScreen.main.bounds.size.width,
                                    height: frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 432 - (scrollView.contentOffset.y + 166)
        let h = max(60, y)
        let frame = backgrounBar.frame
        backgrounBar.frame = CGRect(x: 0,
                                    y: -100,
                                    width: frame.width,
                                    height: h)
    }
}
