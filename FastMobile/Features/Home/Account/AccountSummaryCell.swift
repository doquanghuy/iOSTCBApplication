//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import UIKit
import TCBService

/*
final class AccountSummaryCell: UITableViewCell {
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var logoContainerView: UIView!
    @IBOutlet private weak var partyLabel: UILabel!
    @IBOutlet private weak var category: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    @IBOutlet private weak var separatorView: UIView! {
        didSet {
            separatorView.backgroundColor = UIColor(hexString: "DDE4E9")
            showSeparator(false)
        }
    }

    @IBOutlet weak var logoImageDefaultWidthConstraint: NSLayoutConstraint!

    @IBOutlet weak var logoImageFillWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var separatorViewHeight: NSLayoutConstraint! {
        didSet {
            separatorViewHeight.constant = 1 / UIScreen.main.scale
        }
    }

    private var isExcluded: Bool = false {
        didSet {
            let opacity: CGFloat = isExcluded ? 0.25 : 1

            [partyLabel, category, amountLabel].forEach {
                $0?.alpha = opacity
            }
            isUserInteractionEnabled = !isExcluded
        }
    }

    // MARK: - View lifecycle methods

    override func awakeFromNib() {
        super.awakeFromNib()
        partyLabel.font = .mediumFont(16.0)
        category.font = .regularFont(14.0)
        partyLabel.textColor = .black
        category.textColor = .darkGray
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        separatorInset.left = partyLabel.frame.minX
        separatorInset.right = 0
    }

    // MARK: - Setup functions

    func setupCell(with accountData: AccountSummaryData, isExcluded: Bool = false) {
        partyLabel.text = accountData.name
        partyLabel.accessibilityIdentifier = "accountNameID of " + accountData.name
        category.text = accountData.category
        category.accessibilityIdentifier = "accountNumberID of " + accountData.name
        amountLabel.attributedText = accountData.amount
        amountLabel.accessibilityIdentifier = "accountBalanceID of " + accountData.name
        setupLogo(with: accountData)
        self.isExcluded = isExcluded
        accessibilityIdentifier = accountData.name + " cell"
    }

    func setupLogo(with accountData: AccountSummaryData) {
        let accessory = accountData.accessory
        let categoryColor = ((accessory?.image?.serverIcon) != nil) ? UIColor.clear : accessory?.categoryColor
        let isFullWidth = ((accessory?.image?.serverIcon) != nil)
        setLogoImageView(categoryColor: categoryColor, isFullWidth: isFullWidth)
        if let imageData = accessory?.image, let localImage = imageData.bundleIconImage() {
            logoImageView.image = localImage
        } else {
            logoImageView.image = accountData.accessory?.image?.bundleIconImage()
        }
    }

    func setLogoImageView(categoryColor: UIColor?, isFullWidth: Bool) {
        logoImageView.tintColor = .white
        logoContainerView.backgroundColor = categoryColor
        logoContainerView.layer.cornerRadius = 16
        NSLayoutConstraint.deactivate([logoImageFillWidthConstraint, logoImageDefaultWidthConstraint])
        logoImageDefaultWidthConstraint.isActive = !isFullWidth
        logoImageFillWidthConstraint.isActive = isFullWidth
    }

    func showSeparator(_ show: Bool) {
        separatorView.isHidden = !show
    }
}
*/
