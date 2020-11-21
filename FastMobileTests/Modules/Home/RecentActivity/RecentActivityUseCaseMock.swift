//
//  RecentActivityUseCaseMock.swift
//  FastMobileTests
//
//  Created by Huy TO. Nguyen Van on 9/22/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

@testable import FastMobile
import RxSwift
import Domain

class RecentActivityUseCaseMock: RecentActivityUseCase {

    var recentActivities_ReturnValue: Observable<[RecentActivity]> = Observable.just([])
    var recentActivities_Called = false
    
    func retrieveRecentActivities() -> Observable<[RecentActivity]> {
        recentActivities_Called = true
        return recentActivities_ReturnValue
    }

}
