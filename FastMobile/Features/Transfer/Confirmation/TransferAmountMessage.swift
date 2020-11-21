//
//  TransferAmountMessage.swift
//  FastMobile
//
//  Created by Huy Van Nguyen on 9/21/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import Domain

class TransferAmountMessage: UIView {
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
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
        let bundle = Bundle(for: TransferAmountMessage.self)
        let nib = UINib(nibName: "TransferAmountMessage", bundle: bundle)
        contentView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
                
        self.addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
    }
    
    func fillData(_ transaction: Transaction?, balance: Balance?) {
        let amount = transaction?.amount.formattedNumber ?? "0"
        amountLabel.text = "\(amount) đ"
        feeLabel.text = "Status: \(balance?.status ?? "")"//"Fee: \(transaction?.fee ?? "-")đ"
        messageLabel.text = balance?.id
    }
}
