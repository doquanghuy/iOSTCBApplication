//
//  TCBPopupViewController.swift
//  FastMobile
//
//  Created by Thuy Truong Quang on 11/9/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import UIKit
import SnapKit

public class TCBPopupViewController: UIViewController, TCBPopupInterface {
    
    public var navigation: UINavigationController?
    
    lazy var cancelButton: TCBButton = {
        let _cancelButton = TCBButton(state: .active, title: "Huỷ giao dịch")
        _cancelButton.layer.borderWidth = 1
        _cancelButton.setCornerRadius(radius: 4)
        _cancelButton.setTitleColor(.darkGray, for: .normal)
        _cancelButton.addTarget(self, action: #selector(self.onCancelButtonTapped(_:)), for: .touchUpInside)
        _cancelButton.backgroundColor = .white
        
        return _cancelButton
    }()
    
    lazy var contentView = UIView()
    
    lazy var doneButton: TCBButton = {
        let _doneButton = TCBButton(state: .active, title: "Tiếp tục giao dịch")
        _doneButton.setTitle("Tiếp tục giao dịch", for: .normal)
        _doneButton.setTitleColor(.white, for: .normal)
        _doneButton.setState(state: .active)
        _doneButton.addTarget(self, action: #selector(self.onDoneButtonTapped(_:)), for: .touchUpInside)
        _doneButton.setCornerRadius(radius: 4)
        
        return _doneButton
    }()
    
    lazy var backgroundImageView: UIImageView = {
        let _imageView = UIImageView()
        _imageView.image = UIImage(named: "background_popup",
                                   in: Bundle(for: type(of: self)),
                                   compatibleWith: nil)
        _imageView.sizeToFit()
        
        return _imageView
    }()

    lazy var titleLabel: UILabel = {
        let _title = UILabel()
        _title.text = "Giao dịch chưa hoàn thành"
        _title.font = .boldSystemFont(ofSize: 18)
        _title.textAlignment = .center
        _title.textColor = UIColor.black.withAlphaComponent(0.65)
        
        return _title
    }()
    
    lazy var descriptionLabel: UILabel = {
        let _description = UILabel()
        _description.numberOfLines = 0
        _description.text = "Bạn có chắc chắn muốn thoát khỏi giao dịch này không?"
        _description.textAlignment = .center
        _description.font = .systemFont(ofSize: 15)
        _description.textColor = UIColor.black.withAlphaComponent(0.85)
        
        return _description
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configurationUI()
    }
    
    private func configurationUI() {
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let stackView = UIStackView(arrangedSubviews: [cancelButton, doneButton])
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        
//        view.addSubview(contentView)
        
        view.backgroundColor = .white
        view.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.height.equalTo(48)
            make.bottom.equalToSuperview().inset(30)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(stackView.snp.top).offset(-20)
            make.leading.equalToSuperview().offset(55)
            make.trailing.equalToSuperview().inset(55)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(descriptionLabel.snp.top)
            make.leading.trailing.equalToSuperview().inset(55)
        }
        
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(titleLabel.snp.top)
            make.leading.trailing.equalToSuperview().inset(60)
            make.width.equalTo(backgroundImageView.snp.height)
        }
        
    }
    
    

    @IBAction func onCancelButtonTapped(_ sender: UIButton) {
       onCancelAction()
    }
    
    @IBAction func onDoneButtonTapped(_ sender: UIButton) {
       onDoneAction()
    }
    
    func setBackgroundImage(image: UIImage) {
        self.backgroundImageView.image = UIImage(named: "background_popup")
    }
    
    func setTitle(text: String) {
        self.titleLabel.text = text
    }
    
    func setDescription(text: String) {
        self.descriptionLabel.text = text
    }
    
    func onCancelAction() {
        self.dismiss(animated: true) {
            self.navigation?.popViewController(animated: true)
        }
    }
    
    func onDoneAction() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension TCBPopupViewController {
    public override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width, height: 502)
    }
}
