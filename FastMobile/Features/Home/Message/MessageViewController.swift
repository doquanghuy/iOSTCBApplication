//
//  MessageViewController.swift
//  FastMobile
//
//  Created by duc on 9/12/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import RxSwift
import Domain

class MessageViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var viewModel: MessageViewModel!

    @IBOutlet private weak var swipeableCardView: SwipeableCardViewContainer!

    override func viewDidLoad() {
        super.viewDidLoad()

        swipeableCardView.dataSource = self
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchMessages()
    }
    
    // MARK: Private
    
    private func bindViewModel() {
        viewModel.cardViewModels
            .subscribe(onNext: { [weak self] _ in
                self?.swipeableCardView.reloadData()
            }).disposed(by: disposeBag)
    }
}

extension MessageViewController: SwipeableCardViewDataSource {
    
    func numberOfCards() -> Int {
        return viewModel.cardViewModels.value.count
    }

    func card(forItemAtIndex index: Int) -> SwipeableCardViewCard {
        let cardView = MessageSwipeableCard()
        cardView.viewModel = viewModel.cardViewModels.value[index]
        return cardView
    }

    func viewForEmptyCards() -> UIView? {
        return nil
    }
}
