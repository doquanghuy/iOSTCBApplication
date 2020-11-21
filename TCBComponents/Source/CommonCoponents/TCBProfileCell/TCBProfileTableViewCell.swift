//
//  TCBProfileTableViewCell.swift
//  TCBComponents
//
//  Created by vuong on 11/1/20.
//

import UIKit
import RxCocoa
import SnapKit

public struct TCBProfileItem {
    public var title: String?
    public var value: String?
}

public protocol TCBProfileDelegate {
    func editClicked(_ sender: UIButton?)
}

public class TCBProfileTableViewCell: UITableViewCell {
    
    private var data: TCBProfileItem?
    public var delegate: TCBProfileDelegate?
    
    public var theme: TCBProfileTableViewCellStyle {
        return TCBDefaultTCBProfileTableViewCellStyle()
    }
    
    public lazy var titleLb: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        
        return label
    }()
    
    public lazy var valueLb: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        
        return label
    }()
    
    public lazy var btnEdit: UIButton = {
        let button = UIButton()
        
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.blue)
        
        return button
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupLayout() {
        contentView.addSubview(titleLb)
        titleLb.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().inset(16)
        }
        
        contentView.addSubview(valueLb)
        valueLb.snp.makeConstraints { (make) in
            make.leading.equalTo(titleLb.snp.leading)
            make.top.equalTo(titleLb.snp.bottom).offset(5)
        }
        
        contentView.addSubview(btnEdit)
        btnEdit.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    func config() {
//        btnEdit.rx.tap.bind { [weak self] _ in
//            self?.delegate?.editClicked(self?.btnEdit)
//        }
        btnEdit.addTarget(self, action: #selector(didTapEditButton(_:)), for: .touchUpInside)
        
        titleLb.textColor = theme.titleColor
        titleLb.font = theme.titleFont
        valueLb.textColor = theme.valueColor
        valueLb.font = theme.valueFont
    }
    
    @objc func didTapEditButton(_ sender: UIButton) {
        self.delegate?.editClicked(sender)
    }
    
    public func displayView(with data: TCBProfileItem?) {
        titleLb.text = data?.title
        valueLb.text = data?.value
    }
}
