//
//  ViewModelType.swift
//  FastMobile
//
//  Created by duc on 9/18/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
