//
//  ConfirmViewController.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 11/1/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Lottie

final class ConfirmViewController: NiblessViewController {
    
    private let navigator: ConfirmNavigator
    private var animationView: AnimationView?
    
    init(navigator: ConfirmNavigator) {
        self.navigator = navigator
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.accessibilityIdentifier = "ConfirmViewController"
        view.backgroundColor = .white
        
        animationView = .init(name: "data2")
        
        animationView!.frame = view.bounds
        
        // 3. Set animation content mode
        
//        animationView!.contentMode = .scaleAspectFit
        
        // 4. Set animation loop mode
        
        animationView!.loopMode = .loop
        
        // 5. Adjust animation speed
        
//        animationView!.animationSpeed = 0.5
        
        view.addSubview(animationView!)
        
        // 6. Play animation
        
        animationView!.play()
    }
}

/*extension ConfirmViewController: SwiftyGifDelegate {
    
    func gifDidStart(sender: UIImageView) {
        let title = UILabel(frame: .zero)
        title.font = .boldFont(24)
        title.textAlignment = .center
        title.numberOfLines = 0
        title.textColor = .blackButtonBackground
        title.text = "Welcome!"
        title.alpha = 0

        let description = UILabel(frame: .zero)
        description.font = .regularFont(15)
        description.textAlignment = .center
        description.textColor = .grayLink
        description.numberOfLines = 0
        description.text = "Your device is registered successfully and now you can Log in."
        description.alpha = 0

        view.addSubview(title)
        title.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom).offset(50)
            make.leading.equalTo(view.snp.leading).inset(46)
            make.trailing.equalTo(view.snp.trailing).inset(46)
        }

        view.addSubview(description)
        description.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.bottom)
            make.leading.equalTo(view.snp.leading).inset(46)
            make.trailing.equalTo(view.snp.trailing).inset(46)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
                title.snp.updateConstraints { make in
                    make.bottom.equalTo(self.view.snp.bottom).inset(376)
                }
                title.alpha = 1
                self.view.layoutIfNeeded()
            }
            
            UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseOut) {
                description.snp.updateConstraints { make in
                    make.top.equalTo(self.view.snp.bottom).inset(368)
                }
                description.alpha = 1
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func gifDidStop(sender: UIImageView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.navigator.onConfirmDone()
        }
    }
}*/
