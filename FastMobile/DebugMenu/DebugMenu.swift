//
//  DebugMenu.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 11/4/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import UIKit
import Domain
import TCBService

#if DEBUG

enum ClassType: String, CaseIterable {
    case `default`
    case dashboard
    case userInfo
    case leftMenu
    case faceID
    case passcode
    case confirm
    
    var className: String {
        switch self {
        case .dashboard:
            return String(describing: HomeViewController.self)
        case .userInfo:
            return String(describing: ProfileViewController.self)
        case .leftMenu:
            return String(describing: LeftMenuViewController.self)
        case .faceID:
            return String(describing: FaceIDViewController.self)
        case .passcode:
            return String(describing: SetupPasscodeViewController.self)
        case .confirm:
            return String(describing: ConfirmViewController.self)
        default:
            return "Default"
        }
    }
}

enum DomainType: String, CaseIterable {
    case local
    case aws
}

class DebugMenu: NSObject {
    static var shared = DebugMenu()
    
    let domainTypeKey = "domain_type"
    let classTypeKey = "class_type"
    
    var domainType: String {
        get {
            UserDefaults.standard.string(forKey: domainTypeKey) ?? "local"
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: domainTypeKey)
        }
    }
    
    var domain: DomainType {
        return DomainType(rawValue: domainType) ?? .local
    }
    
    var classType: String {
        get {
            UserDefaults.standard.string(forKey: classTypeKey) ?? "Default"
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: classTypeKey)
        }
    }
    
    var firstVCType: ClassType {
        return ClassType(rawValue: classType) ?? .default
    }
    
    var firstVC: UIViewController? {
        switch firstVCType {
        case .userInfo:
            return makeUserProfileViewController()
        case .leftMenu:
            return makeDashboardAndShowLeftMenu()
        case .faceID:
            return makeFaceIDViewController()
        case .passcode:
            return makePasscodeViewController()
        case .confirm:
            return makeConfirmViewController()
        case .dashboard:
            if let home = homeViewController.getHomeController() {
                home.user = User()
                home.services = TCBUseCasesProvider()
            }
            return homeViewController
        case .default:
            return nil
        }
    }
    
    // MARK: make viewcontrollers
    
    private lazy var signedInDependencyContainer: SignedInDependencyContainer = {
        return SignedInDependencyContainer()
    }()
    
    private lazy var homeViewController = makeHomeViewController()
    
    private lazy var mainNavigationController: NiblessNavigationController = {
        return NiblessNavigationController()
    }()
    
    private func makeHomeViewController() -> UIViewController {
        return signedInDependencyContainer.makeHomeViewController() ?? UIViewController()
    }
    
    private func makeUserProfileViewController() -> UIViewController {
        let profileVC = ProfileViewController()
        profileVC.viewModel = ProfileViewModel(user: User())
        mainNavigationController.viewControllers = [profileVC]
        
        return mainNavigationController
    }
    
    private func makeDashboardAndShowLeftMenu() -> UIViewController {
        if let home = homeViewController.getHomeController() {
            home.user = User()
            home.services = TCBUseCasesProvider()
            home.showLeftMenuImmediately = true
        }
        
        return homeViewController
    }
    
    private func makeFaceIDViewController() -> UIViewController {
        
        if let home = homeViewController.getHomeController() {
            home.user = User()
            home.services = TCBUseCasesProvider()
        }
        let navigator = DefaultFaceIDNavigator(navigationController: mainNavigationController,
                                               directViewController: homeViewController)
        let viewModel = FaceIDViewModel(navigator: navigator)
        let faceIDVC = FaceIDViewController(viewModel: viewModel)
        mainNavigationController.viewControllers = [faceIDVC]
        
        return mainNavigationController
    }
    
    private func makePasscodeViewController() -> UIViewController {
        
        if let home = homeViewController.getHomeController() {
            home.user = User()
            home.services = TCBUseCasesProvider()
        }
        let navigator = DefaultSetupPasscodeNavigator(navigationController: mainNavigationController,
                                                      directViewController: homeViewController)
        let viewModel = SetupPasscodeViewModel(navigator: navigator)
        let passcodeVC = SetupPasscodeViewController(viewModel: viewModel)
        mainNavigationController.viewControllers = [passcodeVC]
        
        return mainNavigationController
    }
    
    private func makeConfirmViewController() -> UIViewController {
        
        if let home = homeViewController.getHomeController() {
            home.user = User()
            home.services = TCBUseCasesProvider()
        }
        let navigator = DefaultConfirmNavigator(navigationController: mainNavigationController,
                                                directViewController: homeViewController)
        let confirmVC = ConfirmViewController(navigator: navigator)
        mainNavigationController.viewControllers = [confirmVC]
        
        return mainNavigationController
    }
}

#endif
