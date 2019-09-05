//
//  Copyright © 2019 An Tran. All rights reserved.
//

/// A container holding a list of objects of the same type.
public class Container<T> {

    // MARK: Properties

    // Public

    public enum ContainerError: Error {
        case alreadyRegistered
        case notFound
    }

    // Private

    private var store = [String: Any]()
    private let lock = NSRecursiveLock()

    // MARK: Initialization

    public init() {}

    // MARK: APIs

    /// Register an instance for a specific type.
    public func register<T>(_ instance: T, for type: T.Type) throws {
        lock.lock()
        let key = String(describing: type)
        guard store[key] == nil else {
            throw ContainerError.alreadyRegistered
        }

        store[key] = instance
        lock.unlock()
    }

    public func register<T>(_ type: T.Type, builder: @escaping () -> T) throws {
        let instance = builder()
        try register(instance, for: type)
    }

    /// Find and return an instance for a specific type.
    public func resolve<T>(_ type: T.Type) throws -> T {
        lock.lock()
        let key = String(describing: type)
        guard let instance = store[key] as? T else {
            throw ContainerError.notFound
        }
        lock.unlock()
        return instance
    }

}
