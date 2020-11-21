//
//  TransferOptionsViewController.swift
//  FastMobile
//
//  Created by Dinh Duong on 9/17/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import SnapKit
import Domain

class TransferOptionsViewController: UIViewController {
    // MARK: - Views
    lazy var containerView: UIView = {
        let view = UIView()

        view.backgroundColor = .white
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true

        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        label.textColor = UIColor.black.withAlphaComponent(0.85)
        label.textAlignment = .center

        return label
    }()

    lazy var closeButton: UIButton = {
        let button = UIButton()

        button.setImage(UIImage(named: "ic_close"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)

        return button
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(TransferOptionTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none

        return tableView
    }()

    private let viewModel: TransferOptionsViewModeling

    init(viewModel: TransferOptionsViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Life Cycle
extension TransferOptionsViewController {

    override func loadView() {
        super.loadView()
        setupLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = viewModel.title
        view.accessibilityIdentifier = "TransferOptionsViewController"
    }

    func setupLayout() {
        view.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(308)
        }

        containerView.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.trailing.top.equalToSuperview().inset(16)
            make.width.height.equalTo(32)
        }

        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(20)
            make.trailing.equalTo(closeButton.snp.leading).offset(11)
        }

        containerView.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(26)
        }
    }
}

extension TransferOptionsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.transferOptions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TransferOptionTableViewCell

        let option = viewModel.transferOptions[indexPath.row]
        cell.transferOption = option

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigationController = presentingViewController as? UINavigationController
              else { return }

        let transactionViewController = TransactionViewController()
        transactionViewController.viewModel =
            TransactionViewModel(useCase: DefaultTransactionUseCase(),
                                 navigator: DefaultTransactionNavigator(navigationController: navigationController),
                                 senderAccount: Account(id: "",
                                                         accountNumber: "",
                                                         name: "",
                                                         balance: 0.0),
                                 receiverAccount: nil)

        DispatchQueue.main.async {
            self.dismiss(animated: true) {
                navigationController.pushViewController(transactionViewController, animated: true)
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}

// MARK: - Actions
extension TransferOptionsViewController {
    @objc func closeButtonDidTap() {
        dismiss(animated: true)
    }
}

extension TransferOptionsViewController {
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width, height: 308)
    }
}
