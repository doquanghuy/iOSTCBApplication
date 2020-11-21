//
//  BeneficiaryListViewController.swift
//  FastMobile
//
//  Created by Dinh Duong on 9/17/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import SnapKit
import TCBService
import TCBComponents

enum BeneficiarySection: Int {
    case favorite = 1
    case all = 0
}

class BeneficiaryListViewController: NiblessViewController {
    
    // MARK: - Views
    lazy var titleLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        label.textAlignment = .center
        label.textColor = UIColor.black.withAlphaComponent(0.85)
        label.text = "Beneficiary list"

        return label
    }()

    lazy var closeButton: UIButton = {
        let button = UIButton()

        button.setImage(UIImage(named: "ic_close"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)

        return button
    }()

    lazy var searchTextField: TextField = {
        let textField = TextField()

        textField.font = UIFont(name: "HelveticaNeue", size: 15)
        textField.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        textField.placeholder = "Search by name, account number"
        textField.layer.cornerRadius = 7
        textField.layer.masksToBounds = true
        textField.rightViewMode = .always
        let rightView = UIView(frame: CGRect(x: 307, y: 12, width: 36, height: 24))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        rightView.addSubview(imageView)
        imageView.image = UIImage(named: "ic_search")
        textField.rightView = rightView
        textField.autocorrectionType = .no
        textField.addTarget(self, action: #selector(textValueChanged(_:)), for: .editingChanged)

        return textField
    }()

    lazy var addAccountButton: UIButton = {
        let button = UIButton()

        button.setImage(UIImage(named: "ic_add"), for: .normal)
        button.backgroundColor = UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 1.0)
        button.layer.cornerRadius = 24
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(addAccountButtonDidTap), for: .touchUpInside)
        button.accessibilityIdentifier = "add_account"

        return button
    }()

    lazy var addAccountTitleLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.textColor = UIColor.gray
        label.text = "New account, card number"

        return label
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)

        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(BeneficiaryTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 80, left: 0, bottom: 279, right: 1)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag

        return tableView
    }()

    let viewModel: BeneficiaryListViewModeling
    init(viewModel: BeneficiaryListViewModeling) {
        self.viewModel = viewModel
        super.init()
    }
}

// MARK: - Life cycle
extension BeneficiaryListViewController {

    override func loadView() {
        super.loadView()

        setupLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.accessibilityIdentifier = "BeneficiaryListViewController"
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - Setup
extension BeneficiaryListViewController {
    
    private func loadData() {
        viewModel.fetchBeneficiaries { [weak self] (error) in
            if let error = error {
                self?.showError(error)
                return
            }
            self?.viewModel.searchBeneficiary(searchTerm: "", completion: { _ in
                self?.tableView.reloadData()
            })
        }
    }
    
    func setupLayout() {
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(256)
        }

        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(16)
            make.width.height.equalTo(48)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }

        view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(26)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }

        view.addSubview(addAccountButton)
        addAccountButton.snp.makeConstraints { (make) in
            make.top.equalTo(searchTextField.snp.bottom).offset(32)
            make.leading.equalToSuperview().inset(16)
            make.width.height.equalTo(48)
        }

        view.addSubview(addAccountTitleLabel)
        addAccountTitleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(addAccountButton.snp.trailing).offset(16)
            make.centerY.equalTo(addAccountButton.snp.centerY)
            make.width.equalTo(256)
        }

        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(addAccountButton.snp.bottom)
            make.leading.equalToSuperview().offset(16)
            make.trailing.bottom.equalToSuperview()
        }
        
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
    }
}

// MARK: - Actions
extension BeneficiaryListViewController {

    @objc func closeButtonDidTap() {
        dismiss(animated: true)
    }
    
    @objc func addAccountButtonDidTap() {
        let newAccountVC = NewAccountViewController()
        newAccountVC.accountViewModel = NewAccountViewModel(dataSource: NewAccountDataSource(),
                                                            container: newAccountVC)
        newAccountVC.confirmDone = { [weak self] beneficiary in
            guard let beneficiary = beneficiary else { return }
            
            self?.viewModel.selectedBeneficiary.onNext(beneficiary)
        }
        
        navigateTo(newAccountVC, animated: true)
    }
}

extension BeneficiaryListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = BeneficiarySection(rawValue: section) else { return 0 }
        switch section {
        case .favorite:
            return viewModel.favoriteBeneficiaries.count
        case .all:
            return viewModel.searchedBeneficiaries.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BeneficiaryTableViewCell
        guard let section = BeneficiarySection(rawValue: indexPath.section) else { return cell }
        switch section {
        case .favorite:
            let beneficiary = viewModel.favoriteBeneficiaries[indexPath.row]
            cell.beneficiary = beneficiary
        case .all:
            let beneficiary = viewModel.searchedBeneficiaries[indexPath.row]
            cell.beneficiary = beneficiary
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectBeneficiary(at: indexPath)
        dismiss(animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UILabel(frame: CGRect(x: 0, y: 0, width: 90, height: 24))
        view.textColor = UIColor.black.withAlphaComponent(0.6)
        view.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        view.backgroundColor = .clear
        guard let section = BeneficiarySection(rawValue: section) else { return nil }
        switch section {
        case .favorite:
            view.text = "Favorite lists"
        case .all:
            view.text = "Bank/ Card number accounts"
        }
        return view
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            activityIndicator.startAnimating()
            viewModel.deleteContactAt(indexPath.row) { [weak self] _, error in
                self?.activityIndicator.stopAnimating()
                
                guard error == nil else { return }
                
                DispatchQueue.main.async {
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            }
        }
    }
}

extension BeneficiaryListViewController {
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width, height: parentSize.height - 100)
    }
}

// MARK: - UITextFieldDelegate
extension BeneficiaryListViewController: UITextFieldDelegate {
    
    @objc private func textValueChanged(_ textField: UITextField) {
        activityIndicator.showLoading()
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.search), object: nil)
        perform(#selector(search), with: textField, afterDelay: 0.5)
    }
    
    @objc private func search() {
        guard let searchTerm = searchTextField.text else { return }
        
        viewModel.searchBeneficiary(searchTerm: searchTerm) {[weak self] (result) in
            self?.activityIndicator.hideLoading()
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .error(let error):
                self?.showError(error)
            }
        }
    }
}

// MARK: - Error handler
extension BeneficiaryListViewController {
    
    func showError(_ error: Error) {
        DispatchQueue.main.async {
            var errorMessage = error.message
            if let errorEntity = error as? ErrorEntity {
                errorMessage = errorEntity.errorDescription
            }
            let message = TCBNudgeMessage(title: "",
                                         subtitle: errorMessage,
                                         type: .error, onTap: nil, onDismiss: nil)
            TCBNudge.show(message: message)
        }
    }
}
