//
//  ProfileViewController.swift
//  FastMobile
//
//  Created by Duong Dinh on 10/30/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import UIKit
import SnapKit
import Domain
import TCBComponents
import RxSwift
import RxCocoa

enum ProfileRow: Int {
    case firstName = 0
    case lastName
    case email
    
    var title: String {
        switch self {
        case .firstName:
            return "First name"
        case .lastName:
            return "Last name"
        case .email:
            return "Email"
        }
    }
}

class ProfileViewController: NiblessViewController {
    // MARK: - Views
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    lazy var userNameLabel: UILabel = {
       let label = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        label.textColor = .white
        label.font = UIFont.boldFont(18)
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var userNameBackgroundView: UIView = {
       let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    lazy var logOutButton: TCBButton = {
        let button = TCBButton()
        
        button.setTitle("Log out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(logOutButtonDidTap), for: .touchUpInside)
        button.backgroundColor = .lightGray
        button.isHidden = true
        
        return button
    }()
    
//    var user: User!
    var viewModel: ProfileViewModel!
}

extension ProfileViewController {
    
    override func loadView() {
        super.loadView()
        setupLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
        setupBinding()
    }
}

// MARK: - Setups
extension ProfileViewController {
    
    func setupLayout() {
        view.addSubview(logOutButton)
//        logOutButton.snp.makeConstraints { (make) in
//            make.bottom.equalToSuperview().inset(20)
//            make.leading.trailing.equalToSuperview()
//            make.height.equalTo(50)
//        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        userNameBackgroundView.addSubview(userNameLabel)
        let rightBarButtonItem = UIBarButtonItem(customView: userNameBackgroundView)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        let yourBackImage = UIImage(named: "arrowBack")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        self.navigationController?.navigationBar.backItem?.title = nil
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationController?.navigationBar.tintColor = UIColor(hexString: "7b7b7b")
        
        view.insertSubview(activityIndicator, aboveSubview: tableView)
        activityIndicator.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
    }
    
    func setupComponents() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = "Profile"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TCBProfileTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func setupBinding() {
        viewModel.user
            .observeOn(MainScheduler.instance)
            .asObservable()
            .subscribe { [weak self] _ in
                self?.tableView.reloadData()
            }.disposed(by: disposeBag)
        
        viewModel.profileError.subscribe { [weak self] (error) in
            self?.showError(error)
        }.disposed(by: disposeBag)
        
        viewModel.isLoading
            .asDriver(onErrorJustReturn: false)
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        let sharedUsernameFirstLetter = viewModel.usernameFirstLetter.share()
        
        sharedUsernameFirstLetter
            .asDriver(onErrorJustReturn: "")
            .drive(userNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        sharedUsernameFirstLetter
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (firstLetter) in
            if firstLetter != nil {
                self?.userNameBackgroundView.isHidden = false
            } else {
                self?.userNameBackgroundView.isHidden = true
            }
        }).disposed(by: disposeBag)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showSuccess), name: .profileDidChange, object: nil)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TCBProfileTableViewCell
        
        let row = ProfileRow(rawValue: indexPath.row)
        var contentText = row?.title ?? ""
        switch row {
        case .firstName:
            contentText =  viewModel.user.value.firstName ?? ""
        case .lastName:
            contentText =  viewModel.user.value.lastName ?? ""
        case .email:
            contentText =  viewModel.user.value.email ?? ""
        default: break
        }
        cell.titleLb.text = row?.title
        cell.valueLb.text = contentText
        cell.btnEdit.tag = indexPath.row
        cell.delegate = self
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension ProfileViewController: TCBProfileDelegate {
    func editClicked(_ sender: UIButton?) {
        guard let row = sender?.tag else { return }
        let indexPath = IndexPath(row: row, section: 0)
        addAlertViewForRename(for: indexPath)
    }
}

extension ProfileViewController {
    
    func addAlertViewForRename(for indexPath: IndexPath) {
        var user = viewModel.user.value
        let row = ProfileRow(rawValue: indexPath.row)
        let alert = UIAlertController(title: row?.title,
                                      message: "",
                                      preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        alert.addAction(cancelButton)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { [weak self] _ in
            guard let strongSelf = self else { return }
            guard let updatedName = alert.textFields?.first?.text else { return }
            switch row {
            case .firstName:
                user.firstName = updatedName
            case .lastName:
                user.lastName = updatedName
            default:
               user.email = updatedName
            }
            strongSelf.viewModel.updateInfo(user: user)
        }
        
        alert.addAction(saveAction)
        alert.addTextField { textField in
            var textValue: String? = ""
            switch row {
            case .firstName:
                textValue = user.firstName
            case .lastName:
                textValue = user.lastName
            default:
                textValue = user.email
            }
            textField.text = textValue
            textField.keyboardType = .asciiCapable
        }
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func showError(_ error: Error) {
        showAlert(type: .error, message: error.message)
    }
    
    @objc func showSuccess() {
        showAlert(type: .success)
    }
    
    func showAlert(type: TCBNudgeType, message: String = "") {
        let title = type == .error ? "Error" : "Success"
        let message = type == .error ? message != "" ? message : "Update profile failed !" : "Update profile succeeded !"
        
        DispatchQueue.main.async {
            let nudgeMessage = TCBNudgeMessage(title: title,
                                              subtitle: message,
                                              type: type,
                                              onTap: nil,
                                              onDismiss: nil)
            TCBNudge.show(message: nudgeMessage)
        }
    }
    
    @objc func logOutButtonDidTap() {
        let alert = UIAlertController(title: "Log out",
                                      message: "Are you sure you want to log out ?",
                                      preferredStyle: .actionSheet)
        let cancelButton = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        alert.addAction(cancelButton)
        
        let confirmButton = UIAlertAction(title: "Log out", style: .default) {[weak self] (_) in
            self?.viewModel.logout()
        }
        alert.addAction(confirmButton)
        
        present(alert, animated: true, completion: nil)
    }
}
