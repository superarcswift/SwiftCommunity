//
//  Copyright © 2019 An Tran. All rights reserved.
//

import PromiseKit

extension TaskQueue {

    @discardableResult
    public func run<T>(_ task: @escaping () -> Promise<T>) -> Promise<T> {
        return Promise { resolver in
            start {
                task().done { result in
                    resolver.fulfill(result)
                }.catch { error in
                    resolver.reject(error)
                }.finally {
                    self.finish()
                }
            }
        }
    }
}
