//
//  TCBAccountViewModel.swift
//  Alamofire
//
//  Created by Pham Thanh Hoa on 11/6/20.
//

import Foundation

public struct TCBAccountViewModel {
    public let title: String?
    public let id: String?
    public let name: String?
    public let balance: Double
    public let description: String?
    public let icon: UIImage?
    
    public init(title: String?,
                id: String?,
                name: String?,
                balance: Double,
                description: String?,
                icon: UIImage?) {
        self.title = title
        self.id = id
        self.name = name
        self.balance = balance
        self.description = description
        self.icon = icon
    }
}
