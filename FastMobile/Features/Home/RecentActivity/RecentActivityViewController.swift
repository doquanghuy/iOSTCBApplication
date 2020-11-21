//
//  RecentActivityViewController.swift
//  FastMobile
//
//  Created by Huy TO. Nguyen Van on 9/11/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain
import TCBComponents

class RecentActivityViewController: UIViewController {
    
    var viewModel: RecentActivityViewModel!
    private let disposeBag = DisposeBag()
    @IBOutlet weak var recentActivityTableView: UITableView!
    
    private lazy var indicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        bindViewModel()
    }
    
    func configView() {
        recentActivityTableView.register(UINib.init(nibName: "RecentActivityCell", bundle: nil), forCellReuseIdentifier: "RecentActivityCell")
        recentActivityTableView.rowHeight = 72
        recentActivityTableView.tableFooterView = UIView()
        
        view.addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        indicator.startAnimating()
    }

    func bindViewModel() {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        
        let refeshDataNotification = NotificationCenter.default.rx.notification(.refeshDataInHomeVC).mapToVoid().asDriverOnErrorJustComplete()
        
        let input = RecentActivityViewModel.Input(loadTrigger: viewWillAppear,
                                                  refeshDataTrigger: refeshDataNotification,
                                                  selectedItemTrigger: recentActivityTableView.rx.itemSelected.asDriver())
        let output = viewModel.transform(input: input)
        
        output.recentActivities
            .drive(recentActivityTableView.rx.items(cellIdentifier: "RecentActivityCell", cellType: RecentActivityCell.self)) { _, recentActivity, cell in
                cell.fillData(with: recentActivity)
                
        }.disposed(by: disposeBag)
        
        output.recentActivities.asObservable().subscribe { [weak self] (items) in
            self?.indicator.stopAnimating()
            if items.count == 0 {
                self?.recentActivityTableView.setEmptyMessage("No data")
            } else {
                self?.recentActivityTableView.restore()
            }
        } onError: { [weak self] (error) in
            self?.indicator.stopAnimating()
        }.disposed(by: disposeBag)
        
        output.selectedItem.drive().disposed(by: disposeBag)
    }
}
