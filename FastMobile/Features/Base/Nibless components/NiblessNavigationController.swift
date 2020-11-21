//
//  NiblessNavigationController.swift
//  TCBPay
//
//  Created by Dinh Duong on 9/11/20.
//  Copyright © 2020 teddy. All rights reserved.
//

import UIKit
import RxSwift

class NiblessNavigationController: UINavigationController {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    
    // MARK: - Methods
    public init() {
        super.init(nibName: nil, bundle: nil)
        delegate = self
    }
    
    @available(*, unavailable,
    message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
    )
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable,
    message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
    )
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")
    }
}

// MARK: - UINavigationControllerDelegate
extension NiblessNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        navigationController.setNavigationBarHidden(true, animated: false)
    }
}
