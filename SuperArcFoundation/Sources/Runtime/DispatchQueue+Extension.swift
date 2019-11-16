//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

extension DispatchQueue {

    public static func doAsyncOnMainQueue(_ call: @escaping () -> Void) {
        DispatchQueue.main.async(execute: call)
    }

    public static func doAsyncOnGlobalQueue<T>(qos: DispatchQoS.QoSClass = .userInitiated, continuation: @escaping Result<T, Error>.Continuation, call: @escaping () throws -> T) {
        doAsyncOn(DispatchQueue.global(qos: qos), continuation: continuation, call: call)
    }

    ///
    /// Execute `call` on a background queue and return the `Result` to the main queue.
    ///
    public static func doAsyncOn<T>(_ queue: DispatchQueue, continuation: @escaping Result<T, Error>.Continuation, call: @escaping () throws -> T) {
        queue.async {
            let result: Result<T, Error>
            do {
                result = .success(try call())
            } catch {
                result = .failure(error)
            }

            doAsyncOnMainQueue {
                continuation(result)
            }
        }
    }
}
