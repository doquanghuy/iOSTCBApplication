//
// Copyright © 2020 Backbase R&D B.V. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView {
    
    func reloadData(_ completion: @escaping (() -> Void)) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }

//    func registerNibCell(_ cellType: CellType) {
//        
//        let bundle: Bundle?
//    
//        if Bundle.main.path(forResource: cellType.rawValue, ofType: "nib") != nil {
//            bundle = nil
//        }
//        else {
//            bundle = Bundle(for: DefaultDesign.self)
//        }
//        
//        register(UINib(nibName: cellType.rawValue,
//                       bundle: bundle),
//                       forCellReuseIdentifier: cellType.rawValue)
//    }
//    
//    func dequeue<T: UITableViewCell>(cellType: CellType, for indexPath: IndexPath) -> T? {
//        if !cellType.rawValue.isEmpty {
//            let cell = dequeueReusableCell(withIdentifier: cellType.rawValue, for: indexPath)
//            return cell as? T
//        }
//        return UITableViewCell() as? T
//    }
    
    @available(iOS 11.0, *)
    func updateContentInsetAdjustmentBehavior(_ behavior: UIScrollView.ContentInsetAdjustmentBehavior) {
        contentInsetAdjustmentBehavior = behavior
    }
}

//extension UITableView: StatableCollection {
//    private static let stateViewTag = 6544
//
//    public var numberOfItems: Int {
//        guard let dataSource = dataSource else { return 0 }
//
//        var result = 0
//        let sections = dataSource.numberOfSections?(in: self) ?? 1
//
//        for section in 0 ..< sections {
//            result += dataSource.tableView(self, numberOfRowsInSection: section)
//        }
//
//        return result
//    }
//
//    public func reload(error: Error?, _ completion: (() -> Void)? = nil) {
//        reloadData { [weak self] in
//            guard let strongSelf = self,
//                let stateDataSouce = strongSelf.stateDataSouce else {
//                    completion?()
//                    return
//            }
//            strongSelf.tableFooterView = nil
//
//            if strongSelf.isEmpty {
//                if stateDataSouce.shouldDisplayEmptyState {
//                    strongSelf.addEdgeCaseView(for: error)
//                    strongSelf.isScrollEnabled = false
//                    completion?()
//                    return
//                }
//            } else if let error = error {
//                strongSelf.addEdgeCaseView(for: error)
//                strongSelf.isScrollEnabled = true
//                completion?()
//                return
//            }
//
//            self?.removeEdgeCaseView()
//            completion?()
//        }
//    }
//
//    public func removeEdgeCaseView() {
//        viewWithTag(UITableView.stateViewTag)?.removeFromSuperview()
//        isScrollEnabled = true
//    }
//}
