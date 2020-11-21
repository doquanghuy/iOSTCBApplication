//
//  AuditDataType.swift
//  MBTest
//
//  Created by Huy TO. Nguyen Van on 9/30/20.
//

import Foundation

public struct AuditDataType: TCBAutoCodable {

    public var device: String?
    public var deviceId: String?
    public var otherDeviceId: String?
    public var application: String?
    public var applicationVersion: String?

    public init(device: String?, deviceId: String?, otherDeviceId: String?, application: String?, applicationVersion: String?) {
        self.device = device
        self.deviceId = deviceId
        self.otherDeviceId = otherDeviceId
        self.application = application
        self.applicationVersion = applicationVersion
    }
}
