//
//  NumberKeyboardView.swift
//  CustomKeyboard
//
//  Created by Pham Thanh Hoa on 9/19/20.
//  Copyright © 2020 Pham Thanh Hoa. All rights reserved.
//

import Foundation
import UIKit

protocol NumberKeyboardProtocol: NSObjectProtocol {
    func didTapKey(_ key: Key)
}

final class NumberKeyboardView: UIView {
    private let offset: CGFloat = 2
    private let columnNumber = 4
    private var padding: CGFloat = 14

    weak var delegate: NumberKeyboardProtocol?

    let keys: [Key] = [Key(type: .number, value: "1"),
                               Key(type: .number, value: "2"),
                               Key(type: .number, value: "3"),
                               Key(type: .delete),
                               Key(type: .number, value: "4"),
                               Key(type: .number, value: "5"),
                               Key(type: .number, value: "6"),
                               Key(type: .enter),
                               Key(type: .number, value: "7"),
                               Key(type: .number, value: "8"),
                               Key(type: .number, value: "9"),
                               Key(type: .number, value: "0"),
                               Key(type: .unit, value: "000")]

    lazy var collectionView: UICollectionView = {
        let layout = GridLayout()
        layout.delegate = self

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0,
                                                   left: padding,
                                                   bottom: 0,
                                                   right: padding)
        collectionView.register(of: KeyboardCell.self)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        autoresizingMask = UIView.AutoresizingMask.flexibleHeight

        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(orientationChanged),
                                               name: UIDevice.orientationDidChangeNotification,
                                               object: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        let height = calculateItemSize().height * CGFloat(columnNumber) + 30
            + UIApplication.shared.safeAreaInsetsBottom

        return CGSize(width: bounds.width, height: height)
    }

    func calculateItemSize() -> CGSize {

        let viewWidth = UIScreen.main.bounds.width - CGFloat(padding * 2)
        let width = (viewWidth - CGFloat(columnNumber) * offset * 2) / 4.1375
        let height =  width * KeyType.number.ratio.height

        return CGSize(width: width, height: height)
    }

    @objc func orientationChanged() {
        invalidateIntrinsicContentSize()
        collectionView.reloadData()
    }
}

extension NumberKeyboardView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

        guard let key = keys[safe: indexPath.item] else {
            return
        }

        delegate?.didTapKey(key)
    }
}

extension NumberKeyboardView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return keys.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView
            .dequeueReusableCell(of: KeyboardCell.self,
                                 indexPath: indexPath) else { return UICollectionViewCell() }

        guard let key = keys[safe: indexPath.item] else {
            return UICollectionViewCell()
        }

        cell.key = key

        return cell
    }
}

extension NumberKeyboardView: GridLayoutProtocol {

    func sizeForItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
        guard collectionView.frame.width > 0, let key = keys[safe: indexPath.item] else {
            return .zero
        }

        let width = calculateItemSize().width
        let ratio = key.type.ratio

        let heightRatio: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 0.3 : 0.7
        let offset: CGFloat = ratio.height >= (heightRatio * 2)  ? 4 : 0
        return CGSize(width: width * ratio.width, height: width * ratio.height + offset)
    }

    func insetForItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) -> UIEdgeInsets {
        return UIEdgeInsets(top: offset, left: offset, bottom: offset, right: offset)
    }

    func numberOfColumnsAt(_ collectionView: UICollectionView, section: Int) -> Int {
        return columnNumber
    }
}
