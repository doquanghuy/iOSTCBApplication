//
//  UICollectionView+Identifier.swift
//  CustomKeyboard
//
//  Created by Pham Thanh Hoa on 9/18/20.
//  Copyright © 2020 Pham Thanh Hoa. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(of type: T.Type = T.self,
                                                      indexPath: IndexPath) -> T? {
        let cell = dequeueReusableCell(
            withReuseIdentifier: NSStringFromClass(type.self),
            for: indexPath) as? T
        
        return cell
    }
    
    func register<T: UICollectionViewCell>(of type: T.Type = T.self) {
        register(type.self,
                 forCellWithReuseIdentifier: NSStringFromClass(type.self))
    }
    
    func registerHeader<T: UICollectionReusableView>(of type: T.Type = T.self) {
        register(type.self,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: NSStringFromClass(type.self))
    }
    
    func dequeueReusableHeader<T: UICollectionReusableView>(of type: T.Type = T.self,
                                                            indexPath: IndexPath) -> T? {
        let cell = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: NSStringFromClass(type.self),
            for: indexPath) as? T
        
        return cell
    }
}
