//
//  EnvironmentViewController.swift
//  FastMobile
//
//  Created by Huy Van Nguyen on 11/4/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain
import TCBService

class EnvironmentViewController: UIViewController {
    
    @IBOutlet private weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var cancelButton: UIButton!
    
    var viewModel: EnvironmentViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Choose Enviroment"
        tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil),
                    forCellReuseIdentifier: "ItemTableViewCell")
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        bindViewModel()
    }
    
    func updateUI(items: [String]) {
        tableViewHeightConstraint?.constant = 44.0 * CGFloat(items.count)
        tableView.reloadData()
    }
    
    func bindViewModel() {
        let input = EnvironmentViewModel.Input(loadTrigger: Driver.just(()), cancelTrigger: cancelButton.rx.tap.asDriver(), switchEnviromentTrigger: tableView.rx.itemSelected.asDriver())
        let output = viewModel.transform(input: input)

        output.environments.drive(tableView.rx.items(cellIdentifier: "ItemTableViewCell", cellType: ItemTableViewCell.self)) { [weak self]  (_, environment, cell) in
            cell.delegate = self
            cell.update(environment)
            
        }.disposed(by: disposeBag)
        
        output.dismiss.drive().disposed(by: disposeBag)
        
        output.switchEnviroment.drive().disposed(by: disposeBag)

    }
}

extension EnvironmentViewController: ItemTableViewCellDelegate {
    func editEnviroment(_ enviroment: Environment?) {
        guard let enviroment = enviroment else {
            return
        }
        let editEnvironmentViewController = EditEnvironmentViewController(nibName: "EditEnvironmentViewController", bundle: nil)
        let services = TCBUseCasesProvider()
        editEnvironmentViewController.viewModel = EditEnvironmentViewModel(environment: enviroment, useCase: services.makeConfigurationUseCase(), navigator: DefaultEditEnvironmentNavigator(services: services, navigationController: self.navigationController))
        editEnvironmentViewController.prepareToPresentAsPanel()
        
        self.navigationController?.pushViewController(editEnvironmentViewController, animated: true)

    }
}

extension EnvironmentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}
