//
//  Copyright © 2019 An Tran. All rights reserved.
//

public class Container<T> {

    // MARK: Properties

    // Public

    public enum ContainerError: Error {
        case alreadyRegistered
        case notFound
    }

    // Private

    private var store = [String: Any]()

    // MARK: Initialization

    public init() {}

    // MARK: APIs

    public func register<T>(_ instance: T, for type: T.Type) throws {
        let key = String(describing: type)
        guard store[key] == nil else {
            throw ContainerError.alreadyRegistered
        }

        store[key] = instance
    }

    public func register<T>(_ type: T.Type, builder: @escaping () -> T) throws {
        let instance = builder()
        try register(instance, for: type)
    }

    public func resolve<T>(_ type: T.Type) throws -> T {
        let key = String(describing: type)
        guard let instance = store[key] as? T else {
            throw ContainerError.notFound
        }

        return instance
    }

}
