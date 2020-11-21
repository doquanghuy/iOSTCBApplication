//
//  SuccessfulTransactionViewController.swift
//  FastMobile
//
//  Created by Huy Van Nguyen on 9/21/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain
import TCBService

class SuccessfulTransactionViewController: CustomBarViewController {
    
    var viewModel: SuccessfulTransactionViewModel!
    @IBOutlet weak var justForYouView: UIView!
    @IBOutlet weak var transferAmountMessageView: TransferAmountMessage!
    @IBOutlet weak var transferAccountToView: TransferAccount!
    @IBOutlet weak var backToHomeButton: UIButton!
    @IBOutlet weak var sharingButton: UIButton!
    @IBOutlet weak var captureStackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var balance: Balance?
    var transaction: Transaction?
    
    private lazy var homeButton: UIButton = {
        let homeButton = UIButton(type: .custom)
        homeButton.setImage(UIImage(named: "homeOutlined"), for: .normal)
        homeButton.contentHorizontalAlignment = .left
        
        return homeButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        bindViewModel()
        configureJustForYouView()
        customNavigationBar()
    }
    
    func bindViewModel() {        
        let input = SuccessfulTransactionViewModel.Input(loadTrigger: Driver.just(()),
                                                         backToHomeTrigger: homeButton.rx.tap.asDriver(),
                                                         sharingTrigger: sharingButton.rx.tap.asDriver(),
                                                         generateSharedImage: generateSharedImage)
        let output = viewModel.transform(input: input)
        
        output.transaction.drive(onNext: { [unowned self] transaction in
            self.fillDataTransactionView(transaction)
        }).disposed(by: disposeBag)
        output.toHomeScreen.drive().disposed(by: disposeBag)
        output.toSharingScreen.drive().disposed(by: disposeBag)
    }
    
    @objc private func generateSharedImage() -> UIImage? {
        return captureStackView.capture()
    }
    
    func configureJustForYouView() {
        let offeringViewController = OfferingViewController(nibName: "OfferingViewController", bundle: nil)
        let useCase = OfferingUseCaseProvider()
        offeringViewController.viewModel = OfferingViewModel(useCase: OfferingUseCaseProvider(), navigator: DefaultOfferingNavigator(services: useCase, navigationController: self.navigationController))

        embed(offeringViewController, inView: justForYouView)
    }
    
    func fillDataTransactionView(_ transaction: Transaction) {
        self.transaction = transaction
        transferAmountMessageView.fillData(transaction, balance: balance)
        transferAccountToView.fillData(transaction, .to)
        print("====BALANCE=====: \(String(describing: balance))")
    }
    
    internal override func customNavigationBar() {
        let logo = UIImageView(image: UIImage(named: "tcb"))
        navigationItem.leftBarButtonItems = [UIBarButtonItem.init(customView: logo)]
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem.init(customView: homeButton)]
    }
}
