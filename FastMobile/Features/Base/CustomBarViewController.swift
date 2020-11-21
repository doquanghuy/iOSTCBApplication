//
//  CustomBarViewController.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 9/23/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import TCBComponents
import TCBService

class CustomBarViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
        view.backgroundColor = .white
        customNavigationBar()
    }
    
    func customNavigationBar() {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.text = title
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.font = .boldFont(18)
        
        navigationItem.titleView = titleLabel
        
        if let nav = navigationController, nav.viewControllers.count > 1 {
            let backButton = UIButton(type: .custom)
            backButton.setImage(UIImage(named: "backArrow"), for: .normal)
            backButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            backButton.addTarget(self, action: #selector(onBack), for: .touchUpInside)
            backButton.contentHorizontalAlignment = .left
            
            navigationItem.leftBarButtonItems = [UIBarButtonItem.init(customView: backButton)]
        }
        else if presentingViewController != nil {
            let closeButton = UIButton(type: .custom)
            closeButton.setImage(UIImage(named: "ic_close"), for: .normal)
            closeButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            closeButton.addTarget(self, action: #selector(onClose), for: .touchUpInside)
            closeButton.contentHorizontalAlignment = .left
            
            navigationItem.leftBarButtonItems = [UIBarButtonItem.init(customView: closeButton)]
        }
    }
    
    @objc func onBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func onClose() {
        dismiss(animated: true)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    func enableTapToDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
}

// MARK: - Error handler
extension CustomBarViewController {
    
    func showError(_ error: Error) {
        DispatchQueue.main.async {
            var errorMessage = error.message
            if let errorEntity = error as? ErrorEntity {
                errorMessage = errorEntity.errorDescription
            }
            let message = TCBNudgeMessage(title: "",
                                         subtitle: errorMessage,
                                         type: .error, onTap: nil, onDismiss: nil)
            TCBNudge.show(message: message)
        }
    }
}
