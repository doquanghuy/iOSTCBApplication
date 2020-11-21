//
//  QPBaseViewController.swift
//  TCBPay
//
//  Created by Duong Dinh on 7/29/20.
//  Copyright © 2020 teddy. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit

class NiblessViewController: UIViewController {
    // MARK: - Views
    lazy var activityIndicator: UIActivityIndicatorView = {
        var style = UIActivityIndicatorView.Style.large
        if #available(iOS 13.0, *) {
            style = .large
        }
        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.color = .darkGray
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @objc func addDismissKeyboardGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(gesture)
    }
    
    @objc private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    @available(*, unavailable, message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable,
    message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
    )
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func navigateTo(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        if let navigationController = navigationController {
            navigationController.pushViewController(viewController, animated: animated)
            completion?()
        } else {
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: animated, completion: completion)
        }
    }
    
    func showError(_ error: String) {
        showAlert(title: "Error", message: error, cancelActionTitle: "OK", style: .alert)
    }
    
    func addViewController(_ vc: UIViewController) {
        addChild(vc)
        view.addSubview(vc.view)
        vc.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        vc.didMove(toParent: self)
    }
    
    func remove(_ childVC: UIViewController) {
        guard childVC.parent != nil else {
            return
        }
        childVC.willMove(toParent: nil)
        childVC.view.removeFromSuperview()
        childVC.removeFromParent()
    }
}
