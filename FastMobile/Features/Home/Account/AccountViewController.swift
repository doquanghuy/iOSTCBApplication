//
//  AccountViewController.swift
//  FastMobile
//
//  Created by Son le on 10/8/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import TCBService

class AccountViewController: LargeTitleViewController {

    private let cellId = "AccountSummaryCell"
    lazy private var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none

        let nib = UINib(nibName: cellId,
                        bundle: BackbaseComponents.bundle)
        table.register(nib, forCellReuseIdentifier: cellId)
//        table.register(AccountSummaryCell.self)
        
        return table
    }()

    private lazy var cardErrorView: CardErrorView = {
        let errorView = CardErrorView(title: "Failed to load accounts",
                                      message: "Please try again",
                                      viewDelegate: self)
        errorView.alpha = 0
        return errorView
    }()

    private let viewModel = AccountViewModel(service: TCBServiceFactory.loadService())
    internal var spinner: CustomLoadingView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Accounts"
        navigationController?.navigationBar.prefersLargeTitles = true

        let tableViewSeperator = UIView()
        tableViewSeperator.backgroundColor = .clear
        tableViewSeperator.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableViewSeperator)
        tableViewSeperator.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(tableViewSeperator.snp.bottom).offset(24)
            make.leading.trailing.bottom.equalToSuperview()
        }

        showProgress()
        viewModel.products.subscribe { [weak self] (data) in
            if let elements = data.element, elements.count > 0 {
                self?.hideProgress()
                self?.hideError()
            }
        }.disposed(by: disposeBag)

        view.addSubview(cardErrorView)
        cardErrorView.snp.makeConstraints { (make) in
            make.top.equalTo(tableView.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.viewModel.fetchProducts()
//            self.hideProgress()
//            UIView.animate(withDuration: 0.3) {
//                self.showError()
//            }
        }
    }
}

extension AccountViewController: CardErrorViewDelegate {
    func retryClicked() {
        self.showProgress()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.viewModel.fetchProducts()
        }
    }
}

extension AccountViewController: LoadingViewContainer {
    private func showError() {
        UIView.animate(withDuration: 0.3) {
            self.cardErrorView.alpha = 1
        }
    }

    private func hideError() {
        UIView.animate(withDuration: 0.3, animations: {
            self.cardErrorView.alpha = 0
        }, completion: { _ in
            self.tableView.reloadData()
            self.tableView.backgroundColor = .clear
        })
    }

    private func showProgress() {
        if spinner?.isAnimating == true { return }
        spinner = updateLoadingSpinner(in: view)
        spinner?.startAnimating()
    }

    private func hideProgress() {
        spinner?.stopAnimating()
    }
}

// MARK: - UITableViewDelegate & DataSource
extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    private var productList: [TCBProductModel] {
        return viewModel.products.value
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return productList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList[section].accounts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AccountSummaryCell") as? AccountSummaryCell {
            let numberOfRows = self.tableView(tableView, numberOfRowsInSection: indexPath.section)
            let dataAtIndex = productList[indexPath.section].accounts[indexPath.row]
            cell.setupCell(with: dataAtIndex)
            cell.showSeparator(indexPath.item != numberOfRows - 1)
            return cell
        }
        return UITableViewCell()
//        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let products = productList[section].accounts
        if products.count == 0 {
            return 0
        } else {
            return 32.0
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 24.0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .white
        addTopSeparator(in: header)

        let title = productList[section].name
        addTitleLabel(in: header, with: title)

        let balance = productList[section].aggregatedBalance
        addAggregatedBalance(in: header, with: balance)

        return header
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Header UI
extension AccountViewController {
    private func addTopSeparator(in header: UIView) {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "DDE4E9")
        view.translatesAutoresizingMaskIntoConstraints = false

        header.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }

    private func addTitleLabel(in header: UIView, with text: String) {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .mediumFont(12.0)
        titleLabel.textColor = .darkGray
        titleLabel.text = text
        titleLabel.accessibilityIdentifier = "Product kind name"

        header.addSubview(titleLabel)
        header.accessibilityIdentifier = text
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16.0)
            make.firstBaseline.equalTo(header.snp_bottomMargin).inset(-4)
        }
    }

    private func addAggregatedBalance(in header: UIView, with text: String) {
        let aggregatedBalanceLabel = UILabel()
        aggregatedBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
        aggregatedBalanceLabel.attributedText = NSAttributedString(string: text,
                                                                   attributes: [
                                                                    NSAttributedString.Key.font: UIFont.mediumFont(12.0),
                                                                    NSAttributedString.Key.foregroundColor: UIColor.darkGray
                                                                   ])
        aggregatedBalanceLabel.accessibilityIdentifier = "Aggregated balance"

        header.addSubview(aggregatedBalanceLabel)
        aggregatedBalanceLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-16)
            make.firstBaseline.equalTo(header.snp_bottomMargin).inset(-4)
        }
    }
}

extension AccountSummaryCell {
    public func setupCell(with accountData: AccountSummaryData, isExcluded: Bool = false) {
        partyLabel.text = accountData.name
        partyLabel.accessibilityIdentifier = "accountNameID of " + accountData.name
        category.text = accountData.category
        category.accessibilityIdentifier = "accountNumberID of " + accountData.name
        amountLabel.attributedText = accountData.amount
        amountLabel.accessibilityIdentifier = "accountBalanceID of " + accountData.name
        setupLogo(with: accountData)
        self.isExcluded = isExcluded
        accessibilityIdentifier = accountData.name + " cell"
    }

    public func setupLogo(with accountData: AccountSummaryData) {
        let accessory = accountData.accessory
        let categoryColor = ((accessory?.image?.serverIcon) != nil) ? UIColor.clear : accessory?.categoryColor
        let isFullWidth = ((accessory?.image?.serverIcon) != nil)
        setLogoImageView(categoryColor: categoryColor, isFullWidth: isFullWidth)
        if let imageData = accessory?.image, let localImage = imageData.bundleIconImage() {
            logoImageView.image = localImage
        } else {
            logoImageView.image = accountData.accessory?.image?.bundleIconImage()
        }
    }
}
