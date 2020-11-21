//
//  TransactionViewController.swift
//  FastMobile
//
//  Created by duc on 9/18/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import RxSwift
import TCBComponents
import TCBService

class TransactionViewController: LargeTitleViewController {
    var viewModel: TransactionViewModel!
    
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var selectSenderButton: UIButton!
    @IBOutlet private weak var senderNameLabel: UILabel!
    @IBOutlet private weak var balanceLabel: UILabel!
    @IBOutlet private weak var senderIdLabel: UILabel!
    @IBOutlet private weak var selectReceiverButton: UIButton!
    @IBOutlet private weak var receiverNameLabel: UILabel!
    @IBOutlet private weak var receiverIdLabel: UILabel!
    @IBOutlet private weak var receiverView: UIView!
    @IBOutlet private weak var showReceiverViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var enterAmountButton: UIButton!
    @IBOutlet private weak var amountTextField: UITextField!
    @IBOutlet private weak var amountDescriptionLabel: UILabel!
    @IBOutlet private weak var messageTextField: UITextField!
    @IBOutlet private weak var scheduleView: UIView!
    @IBOutlet private weak var showScheduleViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var scheduleSwitch: UISwitch!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var confirmButton: UIButton!
    @IBOutlet private weak var accountView: UIView!
    @IBOutlet weak var amounTextFieldConstraint: NSLayoutConstraint!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(nibName: "TransactionViewController", bundle: nil)
    }
    
    private lazy var accountPanel = TCBAccountPanel(viewModel: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amountTextField.attributedPlaceholder = NSAttributedString(string: "Enter amount",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.38)])
        title = "Transfer to another"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureSubviews()
        bindViewModel()
        view.accessibilityIdentifier = "TransactionViewController"
        
        enableTapToDismissKeyboard()
    }
    
    override func onBack() {
        
        guard (receiverNameLabel.text?.isEmpty ?? true),
              (amountTextField.text?.isEmpty ?? true),
              (messageTextField.text?.isEmpty ?? true) else {
            
            let popupVC = TCBPopupViewController()
            popupVC.prepareToPresentAsPanel()
            popupVC.navigation = self.navigationController
            self.navigationController?.present(popupVC, animated: true)
            
            return
        }
        
        super.onBack()
    }
    
    // MARK: Private
    
    private func configureSubviews() {
        amountTextField.setupCustomNumberKeyboard(with: view.frame.width)
        
        enterAmountButton.rx.tap.subscribe(onNext: { [unowned self] _ in
            self.amountTextField.becomeFirstResponder()
        }).disposed(by: disposeBag)
        
        amountTextField.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [unowned self] _ in
                self.amountTextField.resignFirstResponder()
            }).disposed(by: disposeBag)
       
        messageTextField.attributedPlaceholder = NSAttributedString(string: "Enter message", attributes: [.foregroundColor: UIColor.black.withAlphaComponent(0.38)])
        
        scheduleSwitch.rx.value.changed.subscribe(onNext: { [unowned self] shouldShowSchedule in
            self.showScheduleViewConstraint.priority = shouldShowSchedule ? .defaultHigh : .defaultLow
            self.scheduleView.isHidden = !shouldShowSchedule
            self.scrollView.setContentOffset(CGPoint(x: 0, y: -self.scrollView.adjustedContentInset.top), animated: true)
            }).disposed(by: disposeBag)
        
        view.addSubview(accountPanel)
        accountPanel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(accountView.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        accountView.isHidden = true
    }
    
    private func bindViewModel() {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        
        let input = TransactionViewModel.Input(
            loadSenderTrigger: viewWillAppear,
            selectSenderTrigger: accountPanel.tapAction.rx.event.asDriver(),
            loadReceiverTrigger: viewWillAppear,
            selectReceiverTrigger: selectReceiverButton.rx.tap.asDriver(),
            updateAmountTrigger: amountTextField.rx.text.orEmpty.asDriver(),
            updateMessageTrigger: messageTextField.rx.text.orEmpty.asDriver(),
            confirmTransactionTrigger: confirmButton.rx.tap.asDriver(),
            backTrigger: backButton.rx.tap.asDriver()
        )
        let output = viewModel.transform(input: input)
        
        output.sender.drive(onNext: { [unowned self] sender in
            let type: AccountType = AccountType(rawValue: sender.type ?? "") ?? .current
            let viewModel = TCBAccountViewModel(title: "Chuyển khoản từ",
                                                id: sender.id,
                                                name: sender.name,
                                                balance: sender.balance,
                                                description: sender.accountNumber,
                                                icon: type.icon)
            self.accountPanel.viewModel = viewModel
        }).disposed(by: disposeBag)
        
        output.receiver.map { $0 != nil }.drive(onNext: { [unowned self] shouldShowReceiver in
            self.showReceiverViewConstraint.priority = .defaultHigh
            self.receiverView.isHidden = !shouldShowReceiver
            }).disposed(by: disposeBag)
        output.receiver.drive(onNext: { [unowned self] receiver in
            guard let receiver = receiver else { return }
            
            var name = receiver.name
            if let nickname = receiver.nickname, nickname.count > 0 {
                name.append(" (\(nickname))")
            }
            let attributedString = NSMutableAttributedString(
                string: name,
                attributes: [
                    .font: UIFont(name: "HelveticaNeue", size: 16.0)!
                ]
            )
            attributedString.addAttribute(.font, value: UIFont(name: "HelveticaNeue-Bold", size: 16.0)!, range: NSRange(location: 0, length: receiver.name.count))
            self.receiverNameLabel.attributedText = attributedString
            self.receiverIdLabel.text = "\(receiver.accountNumber)"
            }).disposed(by: disposeBag)
        
        output.amountDescription
            .do(onNext: { [weak self] _  in
                let text = self?.amountTextField.text ?? ""
                self?.amounTextFieldConstraint.constant = text.isEmpty ? self?.view.bounds.width ?? 0 : 0
                self?.amountDescriptionLabel.textAlignment = text.isEmpty ? .left : .right
            })
            .drive(amountDescriptionLabel.rx.text)
            .disposed(by: disposeBag)
        

        output.canConfirm.drive(onNext: { [unowned self] isEnabled in
            self.confirmButton.isEnabled = isEnabled
            self.confirmButton.backgroundColor = isEnabled ? UIColor(hexString: "141414") : UIColor(hexString: "eeeeee")
        }).disposed(by: disposeBag)
        
        output.confirm.drive()
            .disposed(by: disposeBag)
        
        output.dismiss.drive()
            .disposed(by: disposeBag)
    }
}
