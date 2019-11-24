//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

// MARK: - StrongWrapper

public struct StrongWrapper<Value> {
    private var _value: () -> Value

    public var wrappedValue: Value {
        _value()
    }
}

extension StrongWrapper where Value: AnyObject {

    public init(_ value: Value) {
        self._value = StrongWrapper.createValueClosure(for: value)
    }

    private static func createValueClosure(for value: Value) -> () -> Value {
        return { value }
    }
}

// MARK: - UnownedWrapper

public struct UnownedWrapper<Value> {
    private var _value: () -> Value

    public var wrappedValue: Value {
        _value()
    }
}

extension UnownedWrapper where Value: AnyObject {

    public init(_ value: Value) {
        self._value = UnownedWrapper.createValueClosure(for: value)
    }

    private static func createValueClosure(for value: Value) -> () -> Value {
        return { [unowned value] in value }
    }
}

// MARK: - WeakWrapper

public struct WeakWrapper<Value> {
    private var _value: () -> Value?

    public var wrappedValue: Value? {
        _value()
    }
}

extension WeakWrapper where Value: AnyObject {

    public init(_ value: Value?) {
        self._value = WeakWrapper.createValueClosure(for: value)
    }

    private static func createValueClosure(for value: Value?) -> () -> Value? {
        return { [weak value] in value }
    }
}
