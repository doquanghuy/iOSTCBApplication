//
//  SignedInDepedencyContainer.swift
//  TCBPay
//
//  Created by Dinh Duong on 9/11/20.
//  Copyright © 2020 teddy. All rights reserved.
//

import UIKit
import Domain
import SWRevealViewController

class SignedInDependencyContainer {
    
    private var swContainer: SWRevealViewController?
    
    func makeHomeViewController() -> UIViewController? {
        ///Home controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let home = (storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController)
        let navigationController = LargeBarNavigationViewController(rootViewController: home)

        ///Menu controller
        let menu = LeftMenuViewController()
        menu.delegate = home

        ///Create container
        swContainer = SWRevealViewController(rearViewController: menu,
                                             frontViewController: navigationController)
        swContainer?.rearViewRevealWidth = UIScreen.main.bounds.size.width * 0.76
        swContainer?.frontViewShadowColor = .clear

        return swContainer
    }
}
