//
//  File.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 9/23/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation

protocol CellActionProtocol: NSObjectProtocol {
    func selectedSegment(_ index: Int, at indexPath: IndexPath)
    func textValueChanged(_ text: String?, at indexPath: IndexPath)
    func didTapLeftView(_ text: String?, at indexPath: IndexPath)
    func didTapRightView(_ text: String?, at indexPath: IndexPath)
    func showDropList(at indexPath: IndexPath)
    func switchValueChanged(_ isOn: Bool, indexPath: IndexPath)
}

extension CellActionProtocol {
    func selectedSegment(_ index: Int, at indexPath: IndexPath) {}
    func textValueChanged(_ text: String?, at indexPath: IndexPath) {}
    func didTapLeftView(_ text: String?, at indexPath: IndexPath) {}
    func didTapRightView(_ text: String?, at indexPath: IndexPath) {}
    func showDropList(at indexPath: IndexPath) {}
    func switchValueChanged(_ isOn: Bool, indexPath: IndexPath) {}
}
