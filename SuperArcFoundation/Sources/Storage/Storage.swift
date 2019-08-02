//
//  Copyright © 2019 An Tran. All rights reserved.
//

public protocol Storage {

    var name: String { get }

    func read(_ key: String) throws -> StorageValue?

    func write(_ key: String, value: StorageValue) throws

    func delete(_ key: String) throws

    func reset() throws
}

/// The Value to store in the Store.
public protocol StorageValue {
    var data: Data { get }
}


extension Data: StorageValue {
    public var data: Data {
        return self
    }
}

extension NSData: StorageValue {
    public var data: Data {
        return self as Data
    }
}
