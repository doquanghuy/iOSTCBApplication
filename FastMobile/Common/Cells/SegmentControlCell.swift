//
//  SegmentControlCell.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 9/23/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation
import UIKit

final class SegmentControlCell: BaseCell {
    
    private var observation: NSKeyValueObservation?
    private var segment: SegmentView?
    
    override func setup(with dataSource: DataSource? = nil, index: IndexPath = IndexPath(item: 0, section: 0), actionHandler: CellActionProtocol? = nil) {
        super.setup(with: dataSource, index: index, actionHandler: actionHandler)
        
        guard let items = dataSource?.items as? [Segment] else { return }
        
        segment?.removeFromSuperview()
        
        let segment = SegmentView(items: items)
        segment.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(segment)
        segment.fitToSuperview(inset: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        
        observation?.invalidate()
        observation = segment.observe(\.selectedIndex,
                                      options: [.old, .new],
                                      changeHandler: { [weak self] _, value in
            guard let self = self else { return }
            
            self.actionHandler?.selectedSegment(value.newValue ?? 0, at: self.indexPath)
        })
        
        self.segment = segment
    }
}

struct Segment {
    let title: String
    let isSelected: Bool
}

private class SegmentView: UIView {
    
    @objc dynamic var selectedIndex: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(items: [Segment]) {
        self.init(frame: .zero)
        
        let segment = UISegmentedControl(items: items.map({ $0.title }))
        segment.layer.cornerRadius = 8
        segment.backgroundColor = .segmentBackground
        segment.tintColor = .white
        segment.setTitleTextAttributes([.font: UIFont.boldFont(14),
                                        .foregroundColor: UIColor.black.withAlphaComponent(0.85)],
                                       for: .selected)
        segment.setTitleTextAttributes([.font: UIFont.boldFont(14),
                                        .foregroundColor: UIColor.black.withAlphaComponent(0.38)],
                                       for: .normal)
        segment.selectedSegmentIndex = items.firstIndex(where: { $0.isSelected }) ?? 0
        segment.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
        segment.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(segment)
        segment.fitToSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func valueChanged(_ sender: UISegmentedControl) {
        selectedIndex = sender.selectedSegmentIndex
    }
}
