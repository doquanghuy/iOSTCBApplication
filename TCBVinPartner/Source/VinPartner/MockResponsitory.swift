//
//  MockResponsitory.swift
//  FastMobile
//
//  Created by duc on 9/12/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation
import RxSwift
import Domain

class MockResponsitory {
    
    static func fetchActions(with type: Int = 0) -> Observable<[TCBQuickActionModel]> {
        let json = (type == 1) ? "QuickActions_Ext" : "QuickActions"
        let bundle = Bundle(for: MockResponsitory.self)
        guard let url = bundle.url(forResource: json, withExtension: "json") else {
            return Observable.just([])
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([TCBQuickActionModel].self, from: data)
            return Observable.of(jsonData)
        } catch {
            return Observable.just([])
        }
    }
}
