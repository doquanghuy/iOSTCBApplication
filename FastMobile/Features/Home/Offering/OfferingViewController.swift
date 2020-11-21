//
//  OfferingViewController.swift
//  FastMobile
//
//  Created by Huy Van Nguyen on 9/10/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain
import TCBComponents

class OfferingViewController: UIViewController {
    
    var viewModel: OfferingViewModel!
    private let disposeBag = DisposeBag()

    private lazy var offeringCollection: OfferingCollectionView = {
        let view = OfferingCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configView()
        bindViewModel()
    }
    
    func configView() {
        view.addSubview(offeringCollection)
        offeringCollection.fitToSuperview()
    }
    
    func bindViewModel() {
        let input = OfferingViewModel.Input(loadTrigger: Driver.just(()))
        let output = viewModel.transform(input: input)

        output.offerings.drive(onNext: { [unowned self] models in
            let newModels = models.compactMap({ OfferingItem(backgroundImage: UIImage(named: $0.backgroundImage ?? ""),
                                                             logo: UIImage(named: $0.logo ?? ""),
                                                             title: $0.title,
                                                             subtitle: $0.subtitle) })
            self.offeringCollection.bind(newModels)
        }).disposed(by: disposeBag)
    }

}
