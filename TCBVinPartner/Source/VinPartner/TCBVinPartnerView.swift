//
//  VinPartnerView.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 11/18/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import SnapKit
import RxCocoa
import TCBComponents
import Domain

public final class TCBVinPartnerView: UIView {
    
    private let viewModel: TCBVinPartnerViewModel?
    private let user: User?
    
    private let disposeBag = DisposeBag()
    private(set) public var selectedActionType = BehaviorRelay<TCBQuickActionModel.ActionType>(value: .default)
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor.black.withAlphaComponent(0.6)
        label.text = "Vin Partner"
        
        return label
    }()
    
    private let entryView = TCBQuickActionsView(fields: [])
    
    public init(user: User?, viewModel: TCBVinPartnerViewModel?) {
        self.viewModel = viewModel
        self.user = user
        
        super.init(frame: .zero)
        
        setupLayouts()
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        viewModel?.fetchActions(with: user?.type ?? .default)
    }
    
    private func setupLayouts() {
        backgroundColor = .clear
        
        let background = UIView(frame: .zero)
        background.backgroundColor = .white
        background.layer.cornerRadius = 16
        
        addSubview(background)
        background.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
        }
        
        background.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }
        
        background.addSubview(entryView)
        entryView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
        
        background.layer.addShadow()
    }
    
    private func bindViewModel() {
        viewModel?.quickActionModels
            .asDriver()
            .drive(onNext: { [weak self] models in
                let actions = models.map { model -> TCBQuickActionFieldView in
                    let icon = UIImage(named: model.iconName) ?? UIImage()
                    let action = TCBQuickActionFieldView(icon: icon,
                                                      title: model.title,
                                                      tapHandler: {
                                                        self?.selectedActionType.accept(model.type)
                                                      })
                    return action
                }
                
                self?.entryView.fields = actions
            }).disposed(by: disposeBag)
    }
}
