//
//  Copyright © 2019 An Tran. All rights reserved.
//

import PromiseKit

extension Resolver {

    /// Bridging native Result type to PromiseKit's Result type
    public func resolve(_ result: Swift.Result<T, Error>) {
        switch result {
            case .success(let value):
                fulfill(value)
            case .failure(let error):
                reject(error)
        }
    }
}


/// MARK: Supporting dispatch async for promises

public struct Promises {

    /// Creates a promise which runs the given method on the specified queue and fulfills on the main queue.
    // Note: unfortunately I cant name this method dispatchAsyncOnQueue...
    public static func asyncOnQueue<T>(_ queue: DispatchQueue, call: @escaping () throws -> T) -> Promise<T> {
        return Promise<T> {
            DispatchQueue.doAsyncOn(queue, continuation: $0.resolve, call: call)
        }
    }

    /// Creates a promise which runs the given method on the global queue and fulfills on the main queue.
    public static func asyncOnGlobalQueue<T>(_ call: @escaping () throws -> T) -> Promise<T> {
        return Promise<T> {
            DispatchQueue.doAsyncOnGlobalQueue(continuation: $0.resolve, call: call)
        }
    }
}

/// Some common Result related errors.
public enum ResultError: Error {
    case unexpectedResult
    case notFound
}

/// Some `Promise` errors.
public enum PromiseError: Error {
    case cancel
    case timeout
}
