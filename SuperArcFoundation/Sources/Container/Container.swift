//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

public class Container<T> {

    // MARK: Properties

    // Public

    public enum ContainerError: Error {
        case alreadyRegistered
        case notFound
    }

    // Private

    private var dict = [String: Any]()

    // MARK: Initialization

    public init() {}

    // MARK: APIs

    public func register<T>(_ instance: T, for type: T.Type) throws {
        let key = String(describing: type)
        guard dict[key] == nil else {
            throw ContainerError.alreadyRegistered
        }

        dict[key] = instance
    }

    public func resolve<T>(_ type: T.Type) throws -> T {
        let key = String(describing: type)
        guard let instance = dict[key] as? T else {
            throw ContainerError.notFound
        }

        return instance
    }

}
