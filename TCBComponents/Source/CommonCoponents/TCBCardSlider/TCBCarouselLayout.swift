//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import UIKit

/// Style of card sliding
public enum TCBCardSlidingStyle {
    /// Preposition first and last cards at minimumLineSpacing from left/right side
    case sticky

    /// Preposition each card to the center of collectionView
    case centered
}

/// Implementation of custom CollectionViewFlowLayout for horizontal carousel
open class TCBCarouselFlowLayout: UICollectionViewFlowLayout {
    private var currentSize: CGSize = CGSize.zero
    private var style: TCBCardSlidingStyle

    public init(itemSize: CGSize, spacing: CGFloat, style: TCBCardSlidingStyle) {
        self.style = style
        super.init()
        scrollDirection = .horizontal
        minimumLineSpacing = spacing
        self.itemSize = itemSize
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func prepare() {
        super.prepare()

        guard
            let collectionView = self.collectionView,
            !self.currentSize.equalTo(collectionView.bounds.size)
            else { return }

        currentSize = collectionView.bounds.size
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        let yInset = (currentSize.height - itemSize.height) / 2
        let xInset = (currentSize.width - itemSize.width) / 2
        switch style {
        case .sticky:
            let spacing = minimumLineSpacing
            sectionInset = UIEdgeInsets(top: yInset, left: spacing, bottom: yInset, right: spacing)
        case .centered:
            sectionInset = UIEdgeInsets(top: yInset, left: xInset, bottom: yInset, right: xInset)
        }
    }

    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect),
            let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes]
            else { return nil }
        return attributes
    }

    open override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                           withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard
            let collectionView = self.collectionView,
            !collectionView.isPagingEnabled,
            let layoutAttributes = layoutAttributesForElements(in: collectionView.bounds)
            else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset) }

        let center = collectionView.bounds.size.width / 2
        let targetOrigin = center + proposedContentOffset.x * (1 + velocity.x)

        guard
            let closest = (layoutAttributes.min { abs($0.center.x - targetOrigin) < abs($1.center.x - targetOrigin) })
            else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset) }

        return CGPoint(x: floor(closest.center.x - center), y: proposedContentOffset.y)
    }
}
