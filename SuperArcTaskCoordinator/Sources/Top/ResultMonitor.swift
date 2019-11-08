//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

///
/// Serialize accessing to a common resource.
///
public class ResultMonitor<T> {

    public typealias Continuation = (Result<T, Error>) -> Void

    // MARK: Properties

    // Private

    private var continuations = [Continuation]()

    // MARK: Initialization

    public init() {}

    // MARK: APIs

    ///
    /// Enter the monitor
    ///
    public func run(_ continuation: @escaping Continuation, call: (@escaping Continuation) -> Void) {
        start(continuation) {
            call { result in
                self.finish(result)
            }
        }
    }

    ///
    /// Enqueue a continuation and start the call.
    ///
    public func start(_ continuation: @escaping Continuation, call: () -> Void) {
        continuations.append(continuation)

        guard continuations.count == 1 else {
            return
        }

        call()
    }

    ///
    /// Invoke all continuations in the queue with the `result`
    ///
    public func finish(_ result: Result<T, Error>) {
        let continuations = self.continuations

        reset()

        for continuation in continuations {
            continuation(result)
        }
    }

    ///
    /// Remove all continuation in the queue.
    ///
    public func reset() {
        continuations.removeAll()
    }
}
