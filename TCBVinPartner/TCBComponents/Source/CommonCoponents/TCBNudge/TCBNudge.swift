//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import Foundation
import UIKit

public class TCBNudge: UIView {
    let type: TCBNudgeType
    let title: String
    let subtitle: String
    let tapHandler: (() -> Void)?
    var tapIcon: UIImage?
    let dismissHandler: (() -> Void)?
    let superView: UIView
    let animationDuration: TimeInterval = 0.6
    var alertDuration: Double = 2.0
    let style: TCBNudgeStyle
    let notificationStyle: TCBNudgeNotificationStyle

    var topConstraint: NSLayoutConstraint?
    var timer: Timer?

    @IBInspectable dynamic var nudgeBackgroundColor: UIColor = .white {
        didSet {
            backgroundColor = nudgeBackgroundColor
        }
    }

    @IBInspectable dynamic var titleColor: UIColor = .black {
        didSet {
            titleLabel.textColor = titleColor
        }
    }

    @IBInspectable dynamic var messageColor: UIColor = .gray {
        didSet {
            messageLabel.textColor = messageColor
        }
    }

    @objc dynamic var titleFont: UIFont = DefaultDesign.fonts.defaultFont(ofSize: 16.0, weight: .medium) {
        didSet {
            titleLabel.font = titleFont
        }
    }

    @objc dynamic var messageFont: UIFont = DefaultDesign.fonts.defaultFont(ofSize: 14.0, weight: .regular) {
        didSet {
            messageLabel.font = messageFont
        }
    }

    lazy var closeButton: TCBNudgeCloseButton = {
        let button = TCBNudgeCloseButton(tapHandler: tapHandler != nil ? (tapHandler as! () -> Void) : dismiss,icon: tapIcon)
        button.backgroundColor = .clear
        return button
    }()

    lazy var icon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        let image = iconImage?.tint(with: .white)
            .resize(toSize: CGSize(width: 20.0, height: 20.0), scale: UIScreen.main.scale)
        imageView.contentMode = .center
        imageView.backgroundColor = iconColor
        imageView.image = image
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.text = title
        label.accessibilityIdentifier = TCBNudgeIdentifiers.titleLabel
        return label
    }()

    lazy var messageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.text = subtitle
        label.accessibilityIdentifier = TCBNudgeIdentifiers.messageLabel
        return label
    }()

    static public func show(message: TCBNudgeMessage,
                            style: TCBNudgeStyle = TCBNudgeDefaultStyle(),
                            notificationStyle: TCBNudgeNotificationStyle = TCBNudgeNotificationDefaultStyle()) {
        guard let view = UIApplication.shared.keyWindow else {
            return
        }

        let isAlreadyShow = view.subviews.filter({ $0.isKind(of: TCBNudge.self) }).count > 0
        if isAlreadyShow {
            return
        }

        let nudgeView = TCBNudge(view: view, type: message.type, title: message.title,
                                subtitle: message.subtitle, tapHandler: message.onTap,
                                dismissHandler: message.onDismiss, tapIcon: message.tapIcon,
                                alertDuration: message.duration,
                                style: style,
                                notificationStyle: notificationStyle)

        nudgeView.show()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init(view: UIView,
                type: TCBNudgeType,
                title: String,
                subtitle: String,
                tapHandler: (() -> Void)? = nil,
                dismissHandler: (() -> Void)? = nil,
                tapIcon: UIImage?,
                alertDuration: Double,
                style: TCBNudgeStyle = TCBNudgeDefaultStyle(),
                notificationStyle: TCBNudgeNotificationStyle = TCBNudgeNotificationDefaultStyle()) {
        self.type = type
        self.title = title
        self.subtitle = subtitle
        self.tapHandler = tapHandler
        self.tapIcon = tapIcon
        superView = view
        self.dismissHandler = dismissHandler
        self.alertDuration = alertDuration
        self.style = style
        self.notificationStyle = notificationStyle
        super.init(frame: .zero)
    }

    private func setupView() {
        accessibilityIdentifier = TCBNudgeIdentifiers.view
        backgroundColor = .white
        layer.masksToBounds = false
        layer.cornerRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowRadius = 16
        layer.shadowOpacity = 0.15
        superView.addSubview(self)
        addSubview(closeButton)
        addSubview(icon)
        addSubview(titleLabel)
        addSubview(messageLabel)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        addGestureRecognizer(tapGesture)
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(didMoveView(_:)))
        addGestureRecognizer(gesture)

        addConstraints()
        startTimer()

        icon.layer.masksToBounds = true
        icon.layer.cornerRadius = icon.frame.size.height / 2
    }

    private func startTimer() {
        closeButton.setProgress(alertDuration)
        var animationTime: TimeInterval = 0
        if #available(iOS 10.0, *) {
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] timer in
                animationTime += 0.1
                if animationTime >= (self?.alertDuration ?? 2.0) {
                    timer.invalidate()
                    self?.dismiss()
                }
            })
        } else {
            // Fallback on earlier versions
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        closeButton.setProgress(0)
    }

    @objc func didTapView() {
        if let tapAction = tapHandler {
            tapAction()
        }
    }
    
    @objc func didMoveView(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        let verticalMovement = translation.y / bounds.height
        let upwardMovement = fmaxf(Float(verticalMovement), -1.0)
        let upwardMovementPercent = fminf(upwardMovement, 0.0)
        let progress = CGFloat(upwardMovementPercent)
        
        switch sender.state {
        case .began:
            stopTimer()
        case .changed:
            frame.origin.y += (progress * 2)
            stopTimer()
        case .ended:
            if progress < 0 {
                dismiss()
            }
            startTimer()
        default:
            break
        }
    }
}

// MARK: - Constraints

extension TCBNudge {
    func addConstraints() {
        alertConstraints()
        closeButtonConstraints()
        iconConstraints()
        titleConstraints()
        messageConstraints()

        superView.setNeedsLayout()
        superView.layoutIfNeeded()
    }

    func alertConstraints() {
        translatesAutoresizingMaskIntoConstraints = false

        topConstraint = topAnchor.constraint(equalTo: superView.topAnchor, constant: -200)

        leftAnchor.constraint(equalTo: superView.leftAnchor, constant: 8.0).isActive = true
        rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -8.0).isActive = true

        topConstraint?.isActive = true
    }

    private func closeButtonConstraints() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            closeButton.heightAnchor.constraint(equalToConstant: 26.5),
            closeButton.widthAnchor.constraint(equalToConstant: 26.5),
            closeButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -12.0)
        ])
    }

    private func iconConstraints() {
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 32.0).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 32.0).isActive = true
        icon.leftAnchor.constraint(equalTo: leftAnchor, constant: 16.0).isActive = true
    }

    private func titleConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16.0).isActive = true
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20.0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 16.0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: closeButton.leftAnchor, constant: -8.0).isActive = true
    }

    private func messageConstraints() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // In case haven't title.
        if title.isEmpty {
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 13.0).isActive = true
        } else {
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1.0).isActive = true
        }
        
        messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13.0).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 16.0).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: closeButton.leftAnchor, constant: -8.0).isActive = true
        
    }
}

// MARK: - Show

extension TCBNudge {
    public func show() {
        guard !superView.subviews.contains(self) else { return }
        setupView()
        animateViews()
    }

    public func animateViews() {
        if #available(iOS 11.0, *) {
            topConstraint?.constant = safeAreaInsets.top > 0 ? safeAreaInsets.top : 24
        } else {
            // Fallback on earlier versions
        }

        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.4, options: [], animations: {
                           self.superView.layoutIfNeeded()
                       }, completion: { _ in
                           self.timer?.fire()
        })
    }

    @objc public func dismiss() {
        dismissHandler?()
        topConstraint?.constant = -frame.size.height * 2

        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.4, options: [], animations: {
                           self.superView.layoutIfNeeded()
                       }, completion: { _ in
                           self.removeFromSuperview()
        })
    }
}

extension TCBNudge {
    
    var iconImage: UIImage? {
        switch type {
        case .error:
            return style.errorIcon
        case .info:
            return style.infoIcon
        case .success:
            return style.successIcon
        case .warning:
            return style.warningIcon
        }
    }
    
    var iconColor: UIColor {
        switch type {
        case .error:
            return notificationStyle.alertLevelColor
        case .info:
            return notificationStyle.infoLevelColor
        case .success:
            return notificationStyle.successLevelColor
        case .warning:
            return notificationStyle.warningLevelColor
        }
    }
}

// MARK: - BBThemeableComponent
public protocol BBThemeableComponent {
    associatedtype Style
    func theme(style: Style)
}

//extension TCBNudge: TCBThemeableComponent {
//    public typealias Style = TCBNudgeStyle
//
//    public func theme(style: TCBNudgeStyle) {
//        backgroundColor = style.backgroundColor
//        titleFont = style.titleFont
//        messageFont = style.messageFont
//        titleColor = style.titleColor
//        messageColor = style.messageColor
//    }
//}

