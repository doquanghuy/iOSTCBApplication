//
//  NewAccountViewController.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 9/23/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation
import UIKit
import TCBService
import Domain
import TCBComponents

final class NewAccountViewController: CustomBarViewController {
    
    var confirmDone: ((Beneficiary?) -> Void)?
    var accountViewModel: NewAccountViewModel?
    
    private var reloadObservation: NSKeyValueObservation?
    private var buttonObservation: NSKeyValueObservation?
    
    private lazy var collectionView: UICollectionView = {
        let layout = GridLayout()
        layout.delegate = accountViewModel

        let view = UICollectionView(frame: .zero,
                                    collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = true
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .white
        view.delegate = accountViewModel
        view.dataSource = accountViewModel
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private lazy var confirmButton: TCBButton = {
        let confirmButton = TCBButton()
        confirmButton.setTitle("Transfer to this peron", for: .normal)
        confirmButton.titleFont = UIFont.boldFont(16)
        confirmButton.foregroundColor = .white
        confirmButton.backgroundColor = .black
        confirmButton.setCornerRadius(radius: 4)
        confirmButton.addTarget(self, action: #selector(confirmTransfer), for: .touchUpInside)
        confirmButton.isEnabled = false
        confirmButton.accessibilityIdentifier = "confirm_button"
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        
        return confirmButton
    }()
    
    private lazy var searchTextField: TextField = {
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
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        var style = UIActivityIndicatorView.Style.large
        if #available(iOS 13.0, *) {
            style = .large
        }
        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.color = .darkGray
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)

        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(BeneficiaryTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = accountViewModel
        tableView.dataSource = accountViewModel
        tableView.separatorInset = UIEdgeInsets(top: 80, left: 0, bottom: 279, right: 1)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag

        return tableView
    }()
    
    deinit {
        reloadObservation?.invalidate()
        reloadObservation = nil
        buttonObservation?.invalidate()
        buttonObservation = nil
    }
    
    override func viewDidLoad() {
        title = "New account, card number"
        super.viewDidLoad()
        
        view.accessibilityIdentifier = "NewAccountViewController"
//        enableTapToDismissKeyboard()
        
        view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(26)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(16)
            make.trailing.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(81)
        }
        collectionView.isHidden = true
        
        view.addSubview(confirmButton)
        confirmButton.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: 16).isActive = true
        confirmButton.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -16).isActive = true
        confirmButton.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: -34).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        confirmButton.isHidden = true
        
        accountViewModel?.currentDataSources.map({ $0.type.cellClass }).forEach({ collectionView.register(of: $0) })
                
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func bindViewModel() {
        reloadObservation = accountViewModel?
            .observe(\.reloadDataSections,
                     options: [.old, .new],
                     changeHandler: { [weak self] _, value in
                        
                        guard let self = self, let indexSet = value.newValue else { return }
                        
                        self.collectionView.reloadSections(indexSet)
            })
        
        buttonObservation = accountViewModel?
            .observe(\.isValidParameters,
                     options: [.old, .new],
                     changeHandler: { [weak self] _, value in
                        
                        guard let self = self, let new = value.newValue else { return }
                        
                        self.confirmButton.isEnabled = new
            })
        
        tableView.rx.itemSelected.subscribe { [weak self] _ in
            guard let self = self else { return }
            
            self.confirmButton.alpha = 0
            self.confirmButton.isHidden = false
            
            self.collectionView.alpha = 0
            self.collectionView.isHidden = false
            self.collectionView.reloadData()
            
            self.tableView.alpha = 1
            
            UIView.animate(withDuration: 0.25) {
                self.confirmButton.alpha = 1
                self.collectionView.alpha = 1
                self.tableView.alpha = 0
            } completion: { _ in
                self.tableView.isHidden = true
            }
        }.disposed(by: disposeBag)

    }
    
    @objc private func confirmTransfer() {
        confirmButton.isLoading = true
        accountViewModel?.confirmTransfer { [weak self] beneficiary in
            self?.confirmButton.isLoading = false
            self?.confirmDone?(beneficiary)
            self?.onClose()
        }
    }
}


// MARK: - UITextFieldDelegate
extension NewAccountViewController: UITextFieldDelegate {
    
    @objc private func textValueChanged(_ textField: UITextField) {
        guard !(textField.text?.isEmpty ?? true) else {
            activityIndicator.hideLoading()
            return
        }
        
        tableView.isHidden = false
        
        UIView.animate(withDuration: 0.25) {
            self.confirmButton.alpha = 0
            self.collectionView.alpha = 0
            self.tableView.alpha = 1
        } completion: { _ in
            self.confirmButton.isHidden = true
            self.collectionView.isHidden = true
        }
        
        activityIndicator.showLoading()
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.search), object: nil)
        perform(#selector(search), with: textField, afterDelay: 0.5)
    }
    
    @objc private func search() {
        guard let searchTerm = searchTextField.text else { return }
        guard searchTerm.count >= 1 else { return }
        
        accountViewModel?.searchBeneficiary(searchTerm: searchTerm) {[weak self] (result) in
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
