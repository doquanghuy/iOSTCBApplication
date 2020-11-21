//
//  BaseViewController.swift
//  FastMobile
//
//  Created by Huy TO. Nguyen Van on 9/17/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.setNavigationBarHidden(true, animated: false)
        customNavigationBar()
        addImageBackground()
    }
    
    func addImageBackground() {
        let imageBackground = UIImage(named: "group13")
        let backgroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 206))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = imageBackground
        view.insertSubview(backgroundImageView, at: 0)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        backgroundImageView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        backgroundImageView.heightAnchor.constraint(equalToConstant: 206).isActive = true
    }
    
    func customNavigationBar() {
        
        let navigationBarView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        view.insertSubview(navigationBarView, at: 0)
        navigationBarView.translatesAutoresizingMaskIntoConstraints = false
        navigationBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        navigationBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        navigationBarView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        navigationBarView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        backView.backgroundColor = UIColor.init(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1)
        backView.layer.cornerRadius = 16
        navigationBarView.addSubview(backView)
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.leadingAnchor.constraint(equalTo: navigationBarView.leadingAnchor, constant: 16).isActive = true
        backView.topAnchor.constraint(equalTo: navigationBarView.topAnchor, constant: 6).isActive = true
        backView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        backView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        let iconImage = UIImage(named: "arrowBack")
        let iconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image = iconImage
        backView.addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 4).isActive = true
        iconImageView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 4).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        let backButton = UIButton(type: .custom)
        backButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        backButton.backgroundColor = .clear
        backView.addSubview(backButton)
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 0).isActive = true
        backView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 0).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }
    
    @objc func didTapBackButton(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func pushViewController(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }

}
