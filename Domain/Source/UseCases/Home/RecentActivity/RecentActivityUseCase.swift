//
//  RecentActivityUseCase.swift
//  Domain
//
//  Created by vuong on 10/16/20.
//

import Foundation

public protocol RecentActivityUseCase {
    func retrieveRecentActivities(completion: @escaping TCBResponseCompletion<[TransactionItem]>)
    func getIBANfromUserAccountName(useAccountName: String, completion: @escaping TCBResponseCompletion<TCBCard?>)
}
