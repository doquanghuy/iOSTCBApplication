//
//  TransferOptionsViewController.swift
//  FastMobile
//
//  Created by Dinh Duong on 9/17/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import SnapKit
import TCBComponents

class AccountOptionsViewController: UIViewController {
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
        tableView.register(AccountOptionTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none

        return tableView
    }()
    
    private lazy var indicator = UIActivityIndicatorView()

    var viewModel: AccountOptionsViewModeling

    init(viewModel: AccountOptionsViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Life Cycle
extension AccountOptionsViewController {

    override func loadView() {
        super.loadView()
        setupLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = viewModel.title
        
        indicator.startAnimating()
        viewModel.loadProducts(completion: { [weak self] error in
            guard error == nil else {
                let message = TCBNudgeMessage(title: "Error", subtitle: error?.localizedDescription ?? "", type: .error)
                TCBNudge.show(message: message)
                return
            }
            self?.tableView.reloadData()
            self?.indicator.stopAnimating()
        })
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
        
        containerView.addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}

extension AccountOptionsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.accountOptions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AccountOptionTableViewCell

        let option = viewModel.accountOptions[indexPath.row]
        cell.accountOption = option
        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath == viewModel.selectedCellIndexPath {
            cell.setSelected(true, animated: false)
        } else {
            cell.setSelected(false, animated: false)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: viewModel.selectedCellIndexPath), indexPath != viewModel.selectedCellIndexPath {
            cell.setSelected(false, animated: false)
        }
        viewModel.didSelectAccountOption(at: indexPath)

        dismiss(animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}

// MARK: - Actions
extension AccountOptionsViewController {

    @objc func closeButtonDidTap() {
        dismiss(animated: true)
    }
}

extension AccountOptionsViewController {
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width, height: 308)
    }
}
