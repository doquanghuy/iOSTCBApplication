//
//  DropListCell.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 9/24/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation
import UIKit

final class DropListCell: BaseCell {
    
    private var observation: NSKeyValueObservation?
    
    private let dropListView: DropListView = {
        let view = DropListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(dropListView)
        dropListView.fitToSuperview(inset: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        
        observation?.invalidate()
        observation = dropListView.observe(\.didTap, options: [.old, .new], changeHandler: { [weak self] _, _ in
            guard let self = self else { return }
            
            self.actionHandler?.showDropList(at: self.indexPath)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup(with dataSource: DataSource? = nil,
                        index: IndexPath = IndexPath(item: 0, section: 0),
                        actionHandler: CellActionProtocol? = nil) {
        super.setup(with: dataSource, index: index, actionHandler: actionHandler)
        
        guard let item = dataSource?.items?[safe: index.item] as? DropItem else { return }
        
        dropListView.config = item
    }
}

struct DropItem {
    let text: String?
    let image: UIImage?
    let placeHolder: String?
    
    init(text: String? = nil, image: UIImage? = nil, placeHolder: String? = nil) {
        self.text = text
        self.image = image
        self.placeHolder = placeHolder
    }
}

private class DropListView: UIView {
    
    @objc dynamic var didTap: Bool = false
    
    var config: DropItem? {
        didSet {
            textField.text = config?.text
            textField.placeholder = config?.placeHolder
            imageView.image = config?.image
            leading?.constant = config?.image != nil ? 80 : 0
        }
    }
    
    private lazy var textField: UITextField = {
        let view = UITextField(frame: .zero)
        view.font = UIFont.regularFont(16)
        view.textColor = .black
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var leading: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addBorder(edge: .bottom, color: UIColor.line)
        
        let dropImage = UIImageView(image: UIImage(named: "ic_drop_arrow"))
        dropImage.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(dropImage)
        dropImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17).isActive = true
        dropImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        let imgView = UIImageView(frame: .zero)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imgView)
        imgView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imgView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        imgView.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: imgView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: imgView.centerYAnchor).isActive = true
        
        addSubview(textField)
        
        leading = textField.leadingAnchor.constraint(equalTo: leadingAnchor)
        leading?.isActive = true
        
        textField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapView() {
        didTap = true
    }
}
