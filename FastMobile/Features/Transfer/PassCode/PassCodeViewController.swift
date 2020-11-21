//
//  PassCodeViewController.swift
//  FastMobile
//
//  Created by Huy TO. Nguyen Van on 9/18/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class PassCodeViewController: BaseViewController {
    
    var viewModel: PassCodeViewModel!
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var pinView: PinView!
    @IBOutlet weak var getOTPButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        configurePinView()
    }
    
    override func addImageBackground() {
    }
    
    func bindViewModel() {
        let input = PassCodeViewModel.Input(loadTrigger: Driver.just(()), getOTPTrigger: getOTPButton.rx.tap.asDriver())
        let output = viewModel.transform(input: input)
        
        output.passCode.drive().disposed(by: disposeBag)
        output.otp.drive().disposed(by: disposeBag)
    }
    
    func configurePinView() {
        pinView.pinLength = 4
        pinView.secureCharacter = "\u{25CF}"
        pinView.interSpace = 8
        pinView.textColor = UIColor.init(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1)
        pinView.placeholderColor = UIColor.init(red: 217/255.0, green: 217/255.0, blue: 217/255.0, alpha: 1)
        pinView.borderLineColor = UIColor.init(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        
        pinView.activeBorderLineColor = UIColor.init(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1)
        pinView.borderLineThickness = 2
        pinView.shouldSecureText = true
        pinView.allowsWhitespaces = false
        pinView.activeBorderLineThickness = 2

        pinView.placeholder = "\u{25CF}"
        pinView.deleteButtonAction = .deleteCurrentAndMoveToPrevious
        pinView.keyboardAppearance = .default
        pinView.tintColor = .white
        pinView.becomeFirstResponderAtIndex = 0
        pinView.shouldDismissKeyboardOnEmptyFirstField = false
        
        pinView.font = UIFont.init(name: "HelveticaNeue", size: 16) ?? UIFont.systemFont(ofSize: 16)
        pinView.keyboardType = .phonePad
        pinView.pinInputAccessoryView = UIView()
    }
    
    func didFinishEnteringPin(pin: String) {
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(false)
    }
}
