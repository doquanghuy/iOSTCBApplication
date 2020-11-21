//
//  Observable+Extensions.swift
//  FastMobile
//
//  Created by Dinh Duong on 9/15/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import RxSwift

extension ObservableType where Element == Bool {
    /// Boolean not operator
    public func not() -> Observable<Bool> {
        return self.map { value -> Bool in
            return !value
        }
    }
}
