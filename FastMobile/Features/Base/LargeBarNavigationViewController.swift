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
        
        let label = UILabel(frame: .zero)
//        label.text = "Enjoy the faster and more \nconvenient way"
        label.textColor = UIColor.black.withAlphaComponent(0.6)
        label.font = .mediumFont(16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.addSubview(label)
        label.bottomAnchor(to: imageView.bottomAnchor, constant: -280)
        label.trailingAnchor(to: imageView.trailingAnchor, constant: -16)
        label.leadingAnchor(to: imageView.leadingAnchor, constant: 16)
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        
        view.backgroundColor = .white
        view.addSubview(backgrounBar)
        view.sendSubviewToBack(backgrounBar)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = 0 - scrollView.contentOffset.y
        let frame = backgrounBar.frame
        backgrounBar.frame = CGRect(x: 0,
                                    y: max(min(height - 432, 0), -170) - 100,
                                    width: frame.width,
                                    height: max(432, height))
    }
}
