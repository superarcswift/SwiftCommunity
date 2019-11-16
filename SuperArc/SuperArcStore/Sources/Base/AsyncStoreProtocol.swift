//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation
import Foundation

public protocol AsyncStoreProtocol {

    var name: String { get }

    // MARK: CRUD

    func read(_ key: String, continuation: @escaping Result<StoreValue?, Error>.Continuation)

    func write(_ key: String, value: StoreValue, continuation: @escaping Swift.Result<Void, Error>.Continuation)

    func delete(_ key: String, continuation: @escaping Result<Void, Error>.Continuation)

    func reset() throws
}
