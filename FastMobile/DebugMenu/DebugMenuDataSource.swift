//
//  DebugMenuDataSource.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 11/4/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import SnapKit
import TCBService

#if DEBUG

class DebugMenuDataSource: NSObject {
    
    private let disposeBag = DisposeBag()
    weak var mainNavigation: UIViewController?
    
    let sections: [DebugMenuSection] =
        [DebugMenuSection(name: "Domain",
                          items: [DebugMenuItem(type: .selection,
                                                name: "Using",
                                                value: DebugMenu.shared.domainType,
                                                options: DomainType.allCases.map({ $0.rawValue }),
                                                action: { value in
                                                    DebugMenu.shared.domainType = value
                                                })
                          ]),
         DebugMenuSection(name: "Main Flow",
                          items: [DebugMenuItem(type: .selection,
                                                name: "First VC",
                                                value: DebugMenu.shared.classType,
                                                options: ClassType.allCases.map({ $0.rawValue }),
                                                action: { value in
                                                    DebugMenu.shared.classType = value
                                                })
                          ]
         ),
         DebugMenuSection(name: "Token",
                          items: [DebugMenuItem(type: .tapAction,
                                                name: "Clear all token",
                                                value: nil,
                                                options: nil,
                                                action: { _ in
                                                    TCBSessionManager.shared.clearAllToken()
                                                })
                          ])
        ]
    
}

// MARK: Private methods

extension DebugMenuDataSource {
    
    private func createButton(with item: DebugMenuItem, cell: UITableViewCell) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 300, height: 30)
        
        if let className = ClassType(rawValue: item.value ?? "") {
            button.setTitle(className.className, for: .normal)
        }
        else {
            button.setTitle(item.value, for: .normal)
        }
        button.backgroundColor = UIColor.purple.withAlphaComponent(0.5)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        
        button.rx.tap.subscribe(onNext: {
            guard let view = self.mainNavigation else { return }
            
            var actions: [UIAlertController.AlertAction] = []
            
            for value in item.options ?? [] {
                let action: UIAlertController.AlertAction = .action(title: value)
                actions.append(action)
            }
            
            actions.append(.action(title: "Cancel", style: .destructive))

            UIAlertController
                .present(in: view, title: "Select option",
                         message: "",
                         style: .actionSheet,
                         actions: actions)
                .subscribe(onNext: { buttonIndex in
                    guard let value = actions[safe: buttonIndex]?.title, value != "Cancel" else { return }
                    
                    item.action?(value)
                    
                    if let className = ClassType(rawValue: value) {
                        button.setTitle(className.className, for: .normal)
                    }
                    else {
                        button.setTitle(value, for: .normal)
                    }
                })
                .disposed(by: self.disposeBag)
        })
        .disposed(by: disposeBag)
        
        return button
    }
}

extension DebugMenuDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = sections[safe: section] else { return 0 }
        return section.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let section = sections[safe: indexPath.section],
              let item = section.items[safe: indexPath.item] else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeue(UITableViewCell.self, indexPath: indexPath)
        cell.textLabel?.text = item.name
        
        if item.type == .selection {
            let button = createButton(with: item, cell: cell)
            cell.accessoryView = button
            cell.selectionStyle = .none
            return cell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = sections[safe: section] else { return nil }
        return section.name
    }
}

extension DebugMenuDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = sections[safe: indexPath.section],
              let item = section.items[safe: indexPath.item],
              item.type == .tapAction else {
            return
        }
        item.action?("")
    }
}

#endif
