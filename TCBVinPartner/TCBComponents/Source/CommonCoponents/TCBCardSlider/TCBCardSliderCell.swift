//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import UIKit
import SnapKit

public final class TCBCardSliderCell: UICollectionViewCell {
    enum CardPosition {
        case left, center, right
    }

    weak var cardView: UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setCardView(_ card: UIView) {
        for subview in subviews {
            subview.removeFromSuperview()
        }

        addSubview(card)
        card.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        card.backgroundColor = UIColor.clear
    }
}
