//
//  BankListViewController.swift
//  FastMobile
//
//  Created by Thuy Truong Quang on 9/25/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain

class BankListViewController: CustomBarViewController {

    // MARK: - Properties
    var viewModel: BankListViewModel!
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK: - Life circle
    override func viewDidLoad() {
        title = "Choose bank"
        super.viewDidLoad()
        
        self.configurationUI()
        self.bindViewModel()
        
        view.accessibilityIdentifier = "BankListViewController"
    }
    
    // MARK: - Functions
    private func configurationUI() {
        tableView.register(UINib(nibName: "BankTableViewCell", bundle: nil), forCellReuseIdentifier: "BankItemCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = false
        
        searchTextField.font = UIFont(name: "HelveticaNeue", size: 15)
        searchTextField.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        searchTextField.layer.cornerRadius = 7
        searchTextField.layer.masksToBounds = true
        searchTextField.rightViewMode = .always
        let rightView = UIView(frame: CGRect(x: 307, y: 12, width: 36, height: 24))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        rightView.addSubview(imageView)
        imageView.image = UIImage(named: "ic_search")
        searchTextField.rightView = rightView
        
    }
    
    private func bindViewModel() {
        let viewWillAppear = rx.sentMessage(#selector(self.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        let input = BankListViewModel.Input(loadListBank: viewWillAppear,
                                            selectBank: tableView.rx.itemSelected.asDriver(),
                                            searchBankTrigger: searchTextField.rx.text.orEmpty.asDriver())
        
        let output = viewModel.transfrom(input: input)
        
        output.listBank.drive(self.tableView.rx.items(cellIdentifier: "BankItemCell", cellType: BankTableViewCell.self)) { _, item, cell in
            cell.selectionStyle = .none
            cell.configCell(item: item)
        }.disposed(by: disposeBag)
        output.bankSelected
            .drive()
            .disposed(by: disposeBag)
    }
}
