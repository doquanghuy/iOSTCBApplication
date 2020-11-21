//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import UIKit

public class TCBNudgeCloseButton: UIButton {
    let tapHandler: () -> Void
    let icon: UIImage?
    
    private lazy var circleProgress: TCBCircularProgressView = {
        let progressView = TCBCircularProgressView()
        progressView.lineWidth = 2.0
        return progressView
    }()
    
    init(tapHandler: @escaping () -> Void, icon: UIImage?) {
        self.tapHandler = tapHandler
        self.icon = icon
        super.init(frame: .zero)
        setupView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapButton))
        addGestureRecognizer(tapGesture)
    }
    
    func setProgress(_ to: Double) {
        circleProgress.count(to: to)
    }
    
    @objc private func didTapButton() {
        tapHandler()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        backgroundColor = .red
        if let customIcon = icon {
            setImage(customIcon, for: .normal)
        } else {
            setImage(UIImage(named: "ic_cancel",
                             in: Bundle(for: TCBNudgeDefaultStyle.self),
                             compatibleWith: nil)?.tint(with: .gray), for: .normal)
            addSubview(circleProgress)
            addConstraints()
        }
    }
    
    fileprivate func addConstraints() {
        circleProgress.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints([NSLayoutConstraint(item: circleProgress, attribute: .width, relatedBy: .equal,
                                           toItem: self, attribute: .width, multiplier: 1.0, constant: 0),
                        NSLayoutConstraint(item: circleProgress, attribute: .height, relatedBy: .equal,
                                           toItem: self, attribute: .height, multiplier: 1.0, constant: 0),
                        NSLayoutConstraint(item: circleProgress, attribute: .centerX, relatedBy: .equal,
                                           toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0),
                        NSLayoutConstraint(item: circleProgress, attribute: .centerY, relatedBy: .equal,
                                           toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)])
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}
