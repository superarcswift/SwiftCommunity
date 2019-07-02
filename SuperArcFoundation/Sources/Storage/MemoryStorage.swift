//
//  Copyright © 2019 An Tran. All rights reserved.
//

public final class MemoryStorage: Storage {

    // MARK: Properties

    // Public

    public var name: String

    // Private

    private var dict = [String: StorageValue]()

    // MARK: Initialization

    public init(name: String) {
        self.name = name
    }

    // MARK: APIs

    public func read(_ key: String) throws -> StorageValue? {
        return dict[key]
    }

    public func write(_ key: String, value: StorageValue) throws {
        dict[key] = value
    }

    public func delete(_ key: String) throws {
        dict.removeValue(forKey: key)
    }

    public func reset() throws {
        dict.removeAll()
    }

}
