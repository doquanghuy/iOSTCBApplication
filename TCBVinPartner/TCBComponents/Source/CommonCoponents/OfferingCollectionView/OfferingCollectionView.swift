//
//  OfferingCollectionView.swift
//  FastMobile
//
//  Created by Son le on 10/15/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import UIKit

public class OfferingCollectionView: MenuCollectionView {

    private var items: [OfferingItem] = []

    override func configSubViews() {
        super.configSubViews()

        registerCell(OfferingCell.self)
        let layout = CarouselFlowLayout(itemSize: CGSize(width: 280, height: 268),
                                        spacing: 16,
                                        style: .sticky)
        setLayout(layout)
    }
}

extension OfferingCollectionView {
    public func bind(_ list: [OfferingItem]) {
        items = list
        collection.reloadData()
    }
}

extension OfferingCollectionView {
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(of: OfferingCell.self, indexPath: indexPath) {
            let itemAtIndex = items[indexPath.row]
            cell.bind(itemAtIndex)
            return cell
        }
        return UICollectionViewCell()
    }
}
