//
//  TransferAccount.swift
//  FastMobile
//
//  Created by Huy Van Nguyen on 9/21/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import Domain

enum TransferAmountType: Int {
    case from
    case to
}

class TransferAccount: UIView {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var letterLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundLetterView: UIView!
    
    var contentView: UIView!
    
    // MARK: - Init methods -
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadView()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    private func loadView() {
        let bundle = Bundle(for: TransferAccount.self)
        let nib = UINib(nibName: "TransferAccount", bundle: bundle)
        contentView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
                
        self.addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
    }
    
    func fillData(_ transaction: Transaction?, _ transferAmountType: TransferAmountType) {
        backgroundLetterView.applyGradient(isVertical: true, colorArray: [UIColor.init(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1), UIColor.init(red: 217/255.0, green: 217/255.0, blue: 217/255.0, alpha: 1)])
        switch transferAmountType {
        case .from:
            titleLabel.text = "Transfer from"
            fillData(transaction?.sender)
        case .to:
            titleLabel.text = "Transfer to"
            fillData(transaction?.receiver)
        }
        
    }
    
    private func fillData(_ account: Account?) {
        var name = account?.name ?? ""
        if let nickname = account?.nickname, nickname.count > 0 {
            name.append(" (\(nickname))")
        }
        let attributedString = NSMutableAttributedString(
            string: name,
            attributes: [
                .font: UIFont(name: "HelveticaNeue", size: 16.0)!
            ]
        )
        attributedString.addAttribute(.font, value: UIFont(name: "HelveticaNeue-Bold", size: 16.0)!, range: NSRange(location: 0, length: account?.name.count ?? 0))
        nameLabel.attributedText = attributedString
        categoryLabel.text = account?.bank?.name
        accountLabel.text = account?.accountNumber
        if let logo = account?.bank?.logo {
            logoView.isHidden = false
            logoImageView.image = UIImage(named: logo)
        } else {
            logoView.isHidden = true
        }
        var letter = ""
        if let fullname = account?.name, fullname.count > 0, let firstCharacter = fullname.byWords.last?.first {
            letter = String(firstCharacter)
        }
        letterLabel.text = letter
    }
}
