//
//  GridLayout.swift
//  CustomKeyboard
//
//  Created by Pham Thanh Hoa on 9/18/20.
//  Copyright © 2020 Pham Thanh Hoa. All rights reserved.
//

import Foundation
import UIKit

protocol GridLayoutProtocol: NSObjectProtocol {
    func sizeForItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) -> CGSize
    func insetForItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) -> UIEdgeInsets
    func numberOfColumnsAt(_ collectionView: UICollectionView, section: Int) -> Int
}

final class GridLayout: UICollectionViewFlowLayout {
    weak var delegate: GridLayoutProtocol?
    
    private var cache: [IndexPath: UICollectionViewLayoutAttributes] = [:]
    
    private var contentHeight: CGFloat = 0
    private var collectionViewBoundSize: CGSize = .zero
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    // MARK: Layout Overrides
    
    override func prepare() {
        guard let collectionView = collectionView else { return }
        
        contentHeight = 0
        cache.removeAll()
        
        let numberOfSections = collectionView.numberOfSections
        for index in 0 ..< numberOfSections {
            caculateLayoutAttributes(sectionIndex: index)
        }
    }
    
    func reload() {
        contentHeight = 0
        cache.removeAll()
        prepare()
    }
    
    private func caculateLayoutAttributes(sectionIndex: Int) {
        guard let collectionView = collectionView, collectionView.frame.width > 0,
            let delegate = delegate else { return }
        
        let numberOfColumns = delegate.numberOfColumnsAt(collectionView, section: sectionIndex)
        let numberOfItems = collectionView.numberOfItems(inSection: sectionIndex)
        
        var column = 0
        
        var xOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
        var yOffset: [CGFloat] = .init(repeating: contentHeight, count: numberOfColumns)
        
        for item in 0 ..< numberOfItems {
            let indexPath = IndexPath(item: item, section: sectionIndex)
            let itemSize = delegate.sizeForItemAt(collectionView, indexPath: indexPath)
            let itemInset = delegate.insetForItemAt(collectionView, indexPath: indexPath)
            
            var frame = CGRect(x: xOffset[column],
                               y: yOffset[column],
                               width: itemSize.width + itemInset.left + itemInset.right,
                               height: itemSize.height + itemInset.top + itemInset.bottom)
            
            if frame.maxX > contentWidth {
                column = 0
                frame = CGRect(x: xOffset[column],
                               y: yOffset[column],
                               width: itemSize.width + itemInset.left + itemInset.right,
                               height: itemSize.height + itemInset.top + itemInset.bottom)
            }
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame.inset(by: itemInset)
            cache[indexPath] = attributes
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + frame.height
            
            if column < numberOfColumns - 1 {
                column += 1
                xOffset[column] = xOffset[column - 1] + frame.width
                
                if yOffset[column] >= itemSize.height * CGFloat(numberOfColumns) {
                    column = 0
                }
            } else {
                column = 0
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
            var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
            
            let appendBlock: (UICollectionViewLayoutAttributes) -> Void = { attributes in
                guard attributes.frame.intersects(rect) else { return }
                visibleLayoutAttributes.append(attributes)
            }
            
            cache.values.forEach { appendBlock($0) }
            
            return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath]
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else { return false }
        collectionViewBoundSize = newBounds.size
        
        return !newBounds.size.equalTo(collectionView.bounds.size)
    }
}
