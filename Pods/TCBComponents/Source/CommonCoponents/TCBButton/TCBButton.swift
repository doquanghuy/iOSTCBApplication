//
//  TCBButton.swift
//  FastMobile
//
//  Created by Thuy Truong Quang on 10/22/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import UIKit

public class TCBButton: UIButton {
    
    // MARK: - Properties
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor(to: centerXAnchor)
        indicator.centerYAnchor(to: centerYAnchor)
        indicator.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5, constant: 1).isActive = true
        indicator.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5, constant: 1).isActive = true
        indicator.color = .gray
        return indicator
    }()
    
    private var activeBackgroundColor: UIColor = .darkGreyBlue
    private var inactiveBackgroundColor: UIColor = .cloudyBlue
    private var buttonState: TCBButtonState = .active
    private var activeTextColor = UIColor.white
    private var inactiveTextColor = UIColor.gray
    private var titleText: String = "Button"
    
    public init(state: TCBButtonState, title: String) {
        super.init(frame: .infinite)
        self.buttonState = state
        self.titleText = title
        self.setText(text: titleText)
        self.titleLabel?.textColor = state == .active ? self.activeTextColor : self.inactiveTextColor
        self.backgroundColor = state == .active ? self.activeBackgroundColor : self.inactiveBackgroundColor
        
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TCBButton: TCBButtonBuilder {
    public func setText(text: String) {
        self.titleText = text
        self.setTitle(titleText, for: .normal)
    }
    
    public func setTextColor(color: UIColor, forState: TCBButtonState) {
        if forState == .active {
            self.activeTextColor = color
        } else {
            self.inactiveTextColor = color
        }
        
        self.titleLabel?.textColor = forState == .active ? self.activeTextColor : self.inactiveTextColor
    }
    
    public func setBackgroundColor(color: UIColor, forState: TCBButtonState) {
        if forState == .active {
            self.activeBackgroundColor = color
        } else {
            self.inactiveBackgroundColor = color
        }
        
        self.backgroundColor = forState == .active ? self.activeBackgroundColor : self.inactiveBackgroundColor
    }
    
    public func setFontFamily(fontPath: UIFont = .boldSystemFont(ofSize: 21)) {
        self.titleLabel?.font = fontPath
    }
    
    public func setState(state: TCBButtonState) {
        self.buttonState = state
        self.hideLoading()
        
        if state == .loading {
            self.addLoading()
        }
        self.isUserInteractionEnabled = state == .active
        self.setText(text: self.titleText)
        self.titleLabel?.textColor = state == .active ? self.activeTextColor : self.inactiveTextColor
        self.backgroundColor = state == .active ? self.activeBackgroundColor : self.inactiveBackgroundColor
    }
    
    public func setCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    public func getState() -> TCBButtonState {
        self.hideLoading()
        if buttonState == .loading {
            self.addLoading()
        }
        return buttonState
    }
    
    private func addLoading() {
        self.titleLabel?.layer.opacity = 0
        self.activityIndicator.startAnimating()
        
    }
    
    private func hideLoading() {
        self.titleLabel?.layer.opacity = 1
        self.activityIndicator.stopAnimating()
    }
}
