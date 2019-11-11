//
//  Copyright © 2019 An Tran. All rights reserved.
//

public class MemoryStore: StoreProtocol {

    // MARK: Properties

    // Private

    private var memory = [String: StoreValue]()

    // Public

    public var name: String

    // MARK: Initialization

    public init(name: String) {
        self.name = name
    }

    // MARK: API

    public func read(_ key: String) throws -> StoreValue? {
        return memory[key]
    }

    public func write(_ key: String, value: StoreValue) throws {
        memory[key] = value
    }

    public func delete(_ key: String) throws {
        memory.removeValue(forKey: key)
    }

    public func reset() throws {
        memory.removeAll()
    }

    public var keys: Set<String> {
        return Set<String>(memory.keys)
    }

}
