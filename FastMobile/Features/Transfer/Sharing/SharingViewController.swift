//
//  SharingViewController.swift
//  FastMobile
//
//  Created by Huy TO. Nguyen Van on 9/25/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SharingViewController: UIViewController {
    
    var viewModel: SharingViewModel!
    let disposeBag = DisposeBag()
    @IBOutlet weak var transactionImageView: UIImageView!
    @IBOutlet weak var dismissButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSubviews()
        bindViewModel()
    }

    private func configureSubviews() {
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func bindViewModel() {
        let input = SharingViewModel.Input(loadTrigger: Driver.just(()), dismissTrigger: dismissButton.rx.tap.asDriver())
        let output = viewModel.transform(input: input)
        
        output.transactionImage.drive(onNext: { [unowned self] transactionImage in
            self.transformImage(transactionImage)
        }).disposed(by: disposeBag)
        output.dismiss.drive().disposed(by: disposeBag)
    }
    
    private func transformImage(_ image: UIImage?) {
        self.transactionImageView.image = image
    }
}

extension SharingViewController {
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width, height: parentSize.height * 0.7)
    }
}
