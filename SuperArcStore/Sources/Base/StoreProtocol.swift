//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

public protocol StoreProtocol {

    var name: String { get }

    // MARK: CRUD

    func read(_ key: String) throws -> StoreValue?

    func write(_ key: String, value: StoreValue) throws

    func delete(_ key: String) throws

    func reset() throws

    // MARK: Keys listing

    var keys: Set<String> { get }
}
