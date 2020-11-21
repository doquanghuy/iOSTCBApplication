//
//  DebugMenuViewController.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 11/3/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

#if DEBUG

final class DebugMenuViewController: CustomBarViewController {
    private let dataSource = DebugMenuDataSource()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.delegate = dataSource
        table.dataSource = dataSource
        table.register(UITableViewCell.self)
        
        return table
    }()
    
    override func viewDidLoad() {
        title = "Debug Menu"
        super.viewDidLoad()
        
        dataSource.mainNavigation = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    override func onClose() {
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        let rootVC = appDelegate?.window?.rootViewController
        
        defer {
            dismiss(animated: true, completion: nil)
        }
        
        let debugTag = 123312
        
        guard let vc = DebugMenu.shared.firstVC else {
            rootVC?.view.subviews.forEach({ view in
                if view.tag == debugTag {
                    view.removeFromSuperview()
                    view.viewContainingController()?.removeFromParent()
                }
            })
            
            return
        }
        
        rootVC?.addChild(vc)
        vc.view.tag = debugTag
        rootVC?.view.addSubview(vc.view)
    }
}

#endif
