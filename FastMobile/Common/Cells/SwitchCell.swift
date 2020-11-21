//
//  SwitchCell.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 9/24/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation
import UIKit

final class SwitchCell: BaseCell {
    
    private var observation: NSKeyValueObservation?
    
    private lazy var switchView: SwitchView = {
        let switchView = SwitchView(frame: .zero)
        switchView.translatesAutoresizingMaskIntoConstraints = false
        
        return switchView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(switchView)
        switchView.fitToSuperview(inset: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 24))
        
        observation?.invalidate()
        observation = switchView.observe(\.isOn, options: [.old, .new], changeHandler: { [weak self] _, value in
            guard let self = self else { return }
            
            self.actionHandler?.switchValueChanged(value.newValue ?? false,
                                                    indexPath: self.indexPath)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup(with dataSource: DataSource? = nil, index: IndexPath = IndexPath(item: 0, section: 0), actionHandler: CellActionProtocol? = nil) {
        super.setup(with: dataSource, index: index, actionHandler: actionHandler)
        
        guard let item = dataSource?.items?[safe: index.item] as? Switch else { return }
        
        switchView.config = item
    }
}

struct Switch {
    let title: String
    var isOn: Bool
}

private class SwitchView: UIView {
    
    @objc dynamic var isOn: Bool = false
    
    var config: Switch? {
        didSet {
            title.text = config?.title
            switchControl.isOn = config?.isOn ?? false
        }
    }
    
    private lazy var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .mediumFont(16)
        label.textColor = UIColor.black.withAlphaComponent(0.6)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var switchControl: UISwitch = {
        let switchItem = UISwitch(frame: .zero)
        switchItem.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
        switchItem.translatesAutoresizingMaskIntoConstraints = false
        
        return switchItem
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(title)
        title.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        title.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(switchControl)
        switchControl.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        switchControl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func valueChanged(_ sender: UISwitch) {
        isOn = sender.isOn
    }
}
