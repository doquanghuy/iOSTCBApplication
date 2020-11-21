//
//  LeftMenuViewController.swift
//  FastMobile
//
//  Created by Son le on 11/2/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import UIKit
import TCBComponents

protocol LeftMenuDelegate: class {
    func didTapLogout()
}

private enum TableSection: Int, CaseIterable {
    struct Data {
        static let notifications = [
            MenuItem(title: "Notification", iconName: "menu_notification")
        ]
        
        static let profiles = [
            MenuItem(title: "Accounts & Cards", iconName: "menu_card"),
            MenuItem(title: "Payment", iconName: "menu_payment"),
            MenuItem(title: "Savings", iconName: "menu_saving"),
            MenuItem(title: "Investment", iconName: "menu_investment"),
            MenuItem(title: "Insurance", iconName: "menu_insurance"),
            MenuItem(title: "Loan", iconName: "menu_loan")
        ]
        
        static let guides = [
            MenuItem(title: "User guide", iconName: "menu_userGuide"),
            MenuItem(title: "Branches & ATMS", iconName: "menu_branch"),
            MenuItem(title: "FAQs", iconName: "menu_faq")
        ]
        
        static let actions = [
            MenuItem(title: "Settings", iconName: "menu_setting"),
            MenuItem(title: "Logout", iconName: "menu_logout")
        ]
    }
    
    case notification, profile, guide, action
    
    var items: [MenuItem] {
        switch self {
        case .notification:
            return Data.notifications
        case .profile:
            return Data.profiles
        case .guide:
            return Data.guides
        case .action:
            return Data.actions
        }
    }
}

class LeftMenuViewController: UIViewController {
    
    lazy private var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(TCBMenuCell.self)
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        table.showsVerticalScrollIndicator = false
        table.contentInset.bottom = 80
        return table
    }()
    
    lazy private var headerCloseView: UIView = {
        let view = UIView()
        let button = UIButton()
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(named: "ic_close_withborder", in: .main, with: nil), for: .normal)
        } else {
            button.setImage(UIImage(named: "ic_close_withborder"), for: .normal)
        }
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.height.width.equalTo(40)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
        }
        button.addTarget(self, action: #selector(onCloseAction), for: .touchUpInside)
        return view
    }()
    
    weak var delegate: LeftMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.height.leading.centerY.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.size.width * 0.76)
        }
    }
    
    @objc
    private func onCloseAction() {
        revealViewController()?.revealToggle(animated: true)
    }
    
    private func createSeparatorView() -> UIView {
        let view = UIView()
        let separator = UIView()
        separator.backgroundColor = UIColor.grayBackground
        view.addSubview(separator)
        separator.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(1)
            make.top.equalToSuperview()
        }
        return view
    }
}

extension LeftMenuViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableSection(rawValue: section)?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(TCBMenuCell.self, indexPath: indexPath)
        guard let section = TableSection(rawValue: indexPath.section) else { return UITableViewCell() }
        let data = section.items[indexPath.row]
        cell.contentView.alpha = 0.4
        cell.selectionStyle = .none
        if section == .action {
            cell.bindSmall(icon: data.iconName, title: data.title)
            if indexPath.row == 1 {
                cell.selectionStyle = .default
                cell.contentView.alpha = 1
            }
        } else {
            cell.bind(icon: data.iconName, title: data.title)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == TableSection.notification.rawValue {
            return headerCloseView
        } else {
            return createSeparatorView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == TableSection.notification.rawValue {
            return view.frame.height * 0.12
        } else if section == TableSection.action.rawValue {
            return 12
        } else {
            return 1
        }
    }
}

extension LeftMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == TableSection.action.rawValue {
            return 44
        } else {
            return 54
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = TableSection(rawValue: indexPath.section) else { return }
        switch section {
        case .action:
            if indexPath.row == 1 {
                delegate?.didTapLogout()
            }
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
