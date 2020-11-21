//
//  AuditViewController.swift
//  FastMobile
//
//  Created by Duong Dinh on 11/16/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AuditViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Properties
    var viewModel: AuditViewModel!
    private let disposeBag = DisposeBag()
    private lazy var indicator = UIActivityIndicatorView()
}

// MARK: - Life Cycle
extension AuditViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        bindViewModel()
    }
    
    func configView() {
        tableView.register(AuditCell.self, forCellReuseIdentifier: AuditCell.cellIdentifier)
        tableView.rowHeight = 87
        tableView.tableFooterView = UIView()
        
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
        
        let input = AuditViewModel.Input(loadTrigger: viewWillAppear, refeshDataTrigger: refeshDataNotification)
        let output = viewModel.transform(input: input)
        
        output.recentActivities
            .drive(tableView.rx.items(cellIdentifier: AuditCell.cellIdentifier, cellType: AuditCell.self)) { _, auditMessage, cell in
                cell.fillData(with: auditMessage)
        }.disposed(by: disposeBag)
        
        output.recentActivities.asObservable().subscribe { [weak self] (items) in
            self?.indicator.stopAnimating()
            if items.count == 0 {
                self?.tableView.setEmptyMessage("No data")
            } else {
                self?.tableView.restore()
            }
        } onError: { [weak self] (error) in
            self?.indicator.stopAnimating()
        }.disposed(by: disposeBag)
    }
}
