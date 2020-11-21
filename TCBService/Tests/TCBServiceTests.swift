//
//  TCBServiceTests.swift
//  TCBServiceTests
//
//  Created by duc on 10/14/20.
//

import XCTest
@testable import TCBService

class TCBServiceTests: XCTestCase {
    override class func setUp() {
        try? TCBService.initialize()
    }
}
