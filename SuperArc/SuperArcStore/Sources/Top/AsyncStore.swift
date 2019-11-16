//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation
import Foundation

public class AsyncStore: AsyncStoreProtocol {

    // MARK: Properties

    // Private

    private let store: StoreProtocol

    private let queue: DispatchQueue

    // MARK: Initalization

    public init(store: StoreProtocol) {
        self.store = store
        queue = DispatchQueue(label: "app.superarc.store.asyncstore.\(store.name)")
    }

    // MARK: API

    public var name: String {
        return store.name
    }

    public func read(_ key: String, continuation: @escaping Result<StoreValue?, Error>.Continuation) {
        doAsync(continuation) {
            try self.store.read(key)
        }
    }

    public func write(_ key: String, value: StoreValue, continuation: @escaping Result<Void, Error>.Continuation) {
        doAsync(continuation) {
            try self.store.write(key, value: value)
        }
    }

    public func delete(_ key: String, continuation: @escaping Result<Void, Error>.Continuation) {
        doAsync(continuation) {
            try self.store.delete(key)
        }
    }

    public func reset() throws {
        try store.reset()
    }

    // MARK: Private helpers

    private func doAsync<T>(_ continuation: @escaping Result<T, Error>.Continuation, call: @escaping () throws -> T) {
        DispatchQueue.doAsyncOn(queue, continuation: continuation, call: call)
    }
}
