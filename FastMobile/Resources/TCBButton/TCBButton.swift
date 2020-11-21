//
//  TCBButton.swift
//  FastMobile
//
//  Created by Thuy Truong Quang on 10/22/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import UIKit

class TCBButton: UIButton {
    
    // MARK: - Properties
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        addSubview(indicator)
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor(to: centerXAnchor)
        indicator.centerYAnchor(to: centerYAnchor)
        indicator.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5, constant: 1).isActive = true
        indicator.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5, constant: 1).isActive = true
        return indicator
    }()
    
    private var activeColor: UIColor = .blackButtonBackground
    private var inactiveColor: UIColor = .segmentBackground
    private var buttonState: TCBButtonState = .inactive
    private var normalTextColor = UIColor.gray
    
    private var text: String?
    
    private var needsTitleUpdate: Bool = false

    @IBInspectable dynamic var foregroundColor: UIColor = .white {
        didSet {
            needsTitleUpdate = true
        }
    }

    @objc dynamic var titleFont: UIFont = .boldSystemFont(ofSize: 16) {
        didSet {
            needsTitleUpdate = true
        }
    }

    @IBInspectable dynamic var disabledAlpha: CGFloat = 0.5

    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1 : disabledAlpha
        }
    }

    var isLoading: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.setTitle(self.text, for: .normal)
                self.activityIndicator.color = self.foregroundColor
                self.activityIndicator.isHidden = !self.isLoading

                if self.isLoading {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }

                self.isEnabled = !self.isLoading
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateTitleIfNeeded()

        if isLoading {
            bringSubviewToFront(activityIndicator)
        }
    }

    func updateTitleIfNeeded() {
        guard needsTitleUpdate else { return }
        needsTitleUpdate = false
        setTitle(text, for: .normal)
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        self.text = title

        var attributes: [NSAttributedString.Key: Any] = [.font: titleFont]
        if let color = isLoading ? backgroundColor : foregroundColor {
            attributes[.foregroundColor] = color
        }
        let text = NSAttributedString(string: title ?? "",
                                      attributes: attributes)
        DispatchQueue.main.async { [weak self] in
            self?.setAttributedTitle(text, for: state)
        }
    }
}

extension TCBButton: TCBButtonBuilder {
    func setText(text: String, for state: TCBButtonState) {
        self.titleLabel?.text =  state == .loading ? nil : text
    }
    
    func setTextColor(color: UIColor, forState: TCBButtonState) {
        self.titleLabel?.textColor = forState == .active ? color : .segmentBackground
    }
    
    func setBackgroundColor(color: UIColor, forState: TCBButtonState) {
        self.backgroundColor = forState == .active ? color : self.normalTextColor
    }
    
    func setFontFamily(fontPath: UIFont = .boldSystemFont(ofSize: 21)) {
        self.titleLabel?.font = fontPath
    }
    
    func setState(state: TCBButtonState) {
        self.buttonState = state
        self.addLoading()
        self.isUserInteractionEnabled = state == .active
        self.setBackgroundColor(color: state == .active ? self.activeColor : self.inactiveColor, forState: state)
        self.setTextColor(color: state == .active ? .white : .gray, forState: state)
    }
    
    func setCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func getState() -> TCBButtonState {
        addLoading()
        return buttonState
    }
    
    private func addLoading() {
        if self.buttonState == .loading {
            self.activityIndicator.startAnimating()
            self.activityIndicator.isHidden = false
            self.titleLabel?.layer.opacity = 0
        } else {
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
            self.titleLabel?.layer.opacity = 1
        }
    }
}
