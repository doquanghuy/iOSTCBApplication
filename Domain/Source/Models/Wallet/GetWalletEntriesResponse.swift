//
//  GetWalletEntriesResponse.swift
//  MBTest
//
//  Created by Huy TO. Nguyen Van on 10/2/20.
//

import Foundation

public struct GetWalletEntriesResponse: TCBAutoCodable {

    public var unstructuredData: [KeyValue]?
    public var status: Status?
    public var conversationId: String?
    public var walletEntries: [WalletEntry]?

    public init(unstructuredData: [KeyValue]?, status: Status?, conversationId: String?, walletEntries: [WalletEntry]?) {
        self.unstructuredData = unstructuredData
        self.status = status
        self.conversationId = conversationId
        self.walletEntries = walletEntries
    }
}
