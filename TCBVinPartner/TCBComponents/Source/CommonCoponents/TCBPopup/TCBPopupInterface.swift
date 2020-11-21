//
//  TCBPopupInterface.swift
//  FastMobile
//
//  Created by Thuy Truong Quang on 11/9/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import UIKit

protocol TCBPopupInterface {
    
    var navigation: UINavigationController? { get set }
    
    func setBackgroundImage(image: UIImage)
    func setTitle(text: String)
    func setDescription(text: String)
    
    func onCancelAction()
    func onDoneAction()
}
