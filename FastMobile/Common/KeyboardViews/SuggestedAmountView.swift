//
//  SuggestedAmountView.swift
//  CustomKeyboard
//
//  Created by Pham Thanh Hoa on 9/19/20.
//  Copyright © 2020 Pham Thanh Hoa. All rights reserved.
//

import Foundation
import UIKit

final class SuggestedAmountView: UIView {
    weak var textField: UITextField? {
        didSet {
            guard let textField = textField else { return }

            textField.addTarget(self, action: #selector(textInputDidChange(_:)), for: .editingChanged)
        }
    }

    private var _inputKey: String?
    var inputKey: String? {
        get {
            return _inputKey
        }

        set {
            guard let new = newValue, new != _inputKey else { return }

            _inputKey = new
            let value = new.doubleValue

            guard value < 100000 else { return }

            if value <= 0 {
                suggestionKeys.removeAll()
            } else {
                let units: [Double] = [1000, 10000, 100000]
                suggestionKeys = units.compactMap({ ($0 * value).formattedNumber })
            }

            collectionView.reloadData()
            invalidateIntrinsicContentSize()
        }
    }

    private var observation: NSKeyValueObservation?
    private let padding: CGFloat = 10
    private let itemHeight: CGFloat = 40

    let unit = "đ"
    var suggestionKeys: [String] = []
    
    lazy var collectionView: UICollectionView = {
        let layout = GridLayout()
        layout.delegate = self

        let view = UICollectionView(frame: .zero,
                                    collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = true
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .white
        view.delegate = self
        view.dataSource = self
        view.contentInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        view.register(of: SuggestedKeyboardCell.self)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        autoresizingMask = UIView.AutoresizingMask.flexibleHeight

        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        let widths = suggestionKeys.map { itemSize(with: $0).width + 16 }
        let totalWidth = widths.reduce(0, +)

        let height: CGFloat
        let padding: CGFloat = UIApplication.shared.safeAreaInsetsBottom > 0 ? 18 : 40
        if totalWidth > collectionView.contentSize.width {
            height = 2 * itemHeight + padding
        } else if totalWidth <= 0 {
            height = 0
        } else {
            height = itemHeight + padding
        }

        return CGSize(width: bounds.width, height: height)
    }

    @objc private func textInputDidChange(_ sender: UITextField) {
        inputKey = sender.text
        sender.text = sender.text?.formattedNumber
    }

    private func itemSize(with key: String) -> CGSize {
        let text = "\(key) \(unit)"
        let width = text.width(with: itemHeight, font: .systemFont(ofSize: 16))

        return CGSize(width: width + 40, height: itemHeight)
    }
}

extension SuggestedAmountView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let key = suggestionKeys[safe: indexPath.item] else {
            return
        }

        textField?.text = key
    }
}

extension SuggestedAmountView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return suggestionKeys.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView
            .dequeueReusableCell(of: SuggestedKeyboardCell.self,
                                 indexPath: indexPath) else { return UICollectionViewCell() }

        guard let key = suggestionKeys[safe: indexPath.item] else {
            return UICollectionViewCell()
        }

        cell.key = "\(key) \(unit)"

        return cell
    }
}

extension SuggestedAmountView: GridLayoutProtocol {
    
    func sizeForItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
        guard collectionView.frame.width > 0,
            let key = suggestionKeys[safe: indexPath.item] else {
            return .zero
        }

        return itemSize(with: key)
    }

    func insetForItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    }

    func numberOfColumnsAt(_ collectionView: UICollectionView, section: Int) -> Int {
        return 3
    }
}
