//
//  MenuCollectionView.swift
//  FastMobile
//
//  Created by Son le on 10/14/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import UIKit

/// A private subclass of UICollectionView that has:
///     1. self sizing, where the height update when adding or removing items
///     2. clipping to a max height
///     3. touching outside any cell ignored
private final class SelfSizingCollectionView: UICollectionView {
    var isClippingEnabled = true

    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        guard isClippingEnabled else { return contentSize }
        let width = contentSize.width
        let height = min(contentSize.height, 125)
        return CGSize(width: width, height: height)
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if isClippingEnabled { return view }
        return view == self ? nil : view
    }
}

public class MenuCollectionView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configSubViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configSubViews()
    }

    private lazy var collectionView: SelfSizingCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        layout.minimumLineSpacing = 24
        layout.minimumInteritemSpacing = 24
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal

        let collection = SelfSizingCollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(of: MenuCell.self)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    var collection: UICollectionView {
        return collectionView
    }

    private var items: [MenuItem] = []
    public var onSelectedIndexPath: ((IndexPath) -> Void)?

    func configSubViews() {
        addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension MenuCollectionView {
    public func bind(_ list: [MenuItem]) {
        items = list
        collection.reloadData()
    }

    func registerCell(_ cell: UICollectionViewCell.Type) {
        collectionView.register(of: cell.self)
    }

    func setLayout(_ layout: UICollectionViewFlowLayout) {
        collectionView.collectionViewLayout = layout
    }
}

extension MenuCollectionView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(of: MenuCell.self, indexPath: indexPath) {
            let itemAtIndex = items[indexPath.row]
            cell.bind(itemAtIndex.iconName, title: itemAtIndex.title)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension MenuCollectionView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onSelectedIndexPath?(indexPath)
    }
}
