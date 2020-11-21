//
//  ConfirmationViewController.swift
//  FastMobile
//
//  Created by Huy Van Nguyen on 9/21/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Domain
import TCBComponents

class ConfirmationViewController: CustomBarViewController {
    
    var viewModel: ConfirmationViewModel!
    
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var confirmButton: TCBButton!
    @IBOutlet weak var transferAmountMessageView: TransferAmountMessage!
    @IBOutlet weak var transferAccountFromView: TransferAccount!
    @IBOutlet weak var transferAccountToView: TransferAccount!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Confirmation"
        view.backgroundColor = .clear
        navigationController?.navigationBar.prefersLargeTitles = true
        configureNoticeLabel()
        bindViewModel()
    }
    
    func bindViewModel() {
        let input = ConfirmationViewModel.Input(loadTrigger: Driver.just(()),
                                                confirmTrigger: confirmButton.rx.tap.asDriver())
        let output = viewModel.transform(input: input)
        
        output.transaction.drive(onNext: { [unowned self] transaction in
            self.configureConfirmView(transaction)
        }).disposed(by: disposeBag)
        
        output.toPassCodeScreen.drive().disposed(by: disposeBag)
        
        output.showLoading.asDriver().drive(onNext: { [weak self] loading in
            self?.confirmButton.isLoading = loading
        }).disposed(by: disposeBag)
    }
    
    func configureNoticeLabel() {
        let attributedString = NSMutableAttributedString(string: "Please make sure the information is correct", attributes: [
          .font: UIFont(name: "HelveticaNeue", size: 14.0)!,
          .foregroundColor: UIColor(red: 1.0, green: 149.0 / 255.0, blue: 0.0, alpha: 1.0),
          .kern: -0.1
        ])
        attributedString.addAttribute(.foregroundColor, value: UIColor(white: 0.0, alpha: 0.5), range: NSRange(location: 0, length: 6))
        attributedString.addAttribute(.foregroundColor, value: UIColor(white: 0.0, alpha: 0.5), range: NSRange(location: 33, length: 10))
        noticeLabel.attributedText = attributedString
        
        confirmButton.setTitle("Confirm", for: .normal)
    }
    
    func configureConfirmView(_ transaction: Transaction?) {
        transferAmountMessageView.fillData(transaction, balance: nil)
        transferAccountFromView.fillData(transaction, .from)
        transferAccountToView.fillData(transaction, .to)
    }
}
