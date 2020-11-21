//
// Copyright © 2020 Backbase R&D B.V. All rights reserved.
//

import UIKit

public protocol QuickActionField: UIView {
    typealias TapHandler = () -> Void

    var icon: UIImage { get set }
    var title: String { get set }
    var tapHandler: TapHandler? { get set }

    init(icon: UIImage, title: String, tapHandler: TapHandler?)
}

public final class TCBQuickActionFieldView: UIStackView, QuickActionField {
    public var icon: UIImage {
        get { button.image(for: .normal) ?? UIImage() }
        set { button.setImage(newValue, for: .normal) }
    }

    public var title: String {
        get { label.text ?? "" }
        set { label.text = newValue }
    }

    public var tapHandler: TapHandler?

    public required init(icon: UIImage, title: String, tapHandler: TapHandler?) {
        self.tapHandler = tapHandler

        super.init(frame: .zero)

        self.icon = icon
        self.title = title

        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        alignment = .center
        distribution = .fill
        spacing = 8

        addArrangedSubview(button)
        addArrangedSubview(label)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    @objc private func didTapButton() {
        tapHandler?()
    }

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)

        button.layer.cornerRadius = 25
        button.layer.masksToBounds = false

        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 48),
            button.heightAnchor.constraint(equalToConstant: 48)
        ])

        return button
    }()
}

public final class TCBQuickActionsView: UIView {
    public var fields: [QuickActionField] = [] {
        didSet {
            collectionView.reloadData()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
                UIView.animate(withDuration: 0.25) {
                    self.collectionView.snp.updateConstraints { make in
                        make.height.equalTo(self.collectionView.contentSize.height + 16)
                    }
                }
            })
        }
    }
    
    public init(fields: [QuickActionField]) {
        super.init(frame: .zero)
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(collectionView.contentSize.height)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 60, height: 96)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        view.dataSource = self
        view.register(of: UICollectionViewCell.self)
        view.backgroundColor = .clear
        
        return view
    }()
}

extension TCBQuickActionsView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fields.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(of: UICollectionViewCell.self,
                                                            indexPath: indexPath),
              let field = fields[safe: indexPath.item] else {
            return UICollectionViewCell()
        }
        
        cell.contentView.subviews.forEach({ $0.removeFromSuperview() })
        cell.contentView.addSubview(field)
        field.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        return cell
    }
}
