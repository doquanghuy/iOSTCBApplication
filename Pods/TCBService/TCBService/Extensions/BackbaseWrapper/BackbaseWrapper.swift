//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import Foundation

/**
 Use `BackbaseWrapper` proxy as customization point for constrained protocol extensions.

 General pattern would be:

 // 1. Extend BackbaseWrapper struct with constrain on Base
 // Read as: Backbase Extension where Base is a SomeType
 extension BackbaseWrapper where Base: SomeType {
 // 2. Put any specific Backbase extension for SomeType here
 }

 With this approach we can have more specialized methods and properties using
 `Base` and not just specialized on common base type.

 */

// MARK: - BackbaseWrapper struct to extend

public struct BackbaseWrapper<Base> {
    /// Base object to extend.
    public var base: Base

    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    public init(_ base: Base) {
        self.base = base
    }
}

// MARK: - BackbaseCompatible protocol

/// A type that has Backbase extensions.
public protocol BackbaseCompatible {
    /// Extended type
    associatedtype ExtendedType

    /// Backbase extensions.
    static var bb: BackbaseWrapper<ExtendedType>.Type { get set }

    /// Backbase extensions.
    var bb: BackbaseWrapper<ExtendedType> { get set }
}

// MARK: - BackbaseCompatible protocol default implementation

extension BackbaseCompatible {
    /// Backbase extensions.
    public var bb: BackbaseWrapper<Self> {
        get {
            return BackbaseWrapper(self)
        }
        // swiftlint:disable:next unused_setter_value
        set {
            // this enables using the wrapper to "mutate" base type
        }
    }

    /// Backbase extensions.
    public static var bb: BackbaseWrapper<Self>.Type {
        get {
            return BackbaseWrapper<Self>.self
        }
        // swiftlint:disable:next unused_setter_value
        set {
            // this enables using the wrapper to "mutate" base type
        }
    }
}

extension NSObject: BackbaseCompatible {}
extension String: BackbaseCompatible {}
extension Optional: BackbaseCompatible {}
extension Date: BackbaseCompatible {}
