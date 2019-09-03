//
//  Copyright © 2019 An Tran. All rights reserved.
//

public protocol Registry {
    associatedtype T

    var container: Container<T> { get }
}

extension Registry {

    public func register<T>(_ instance: T, for type: T.Type) {
        do {
            try container.register(instance, for: type)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    public func register<T>(type: T.Type, builder: @escaping () -> T) {
        do {
            try container.register(type, builder: builder)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    public func resolve<T>(type: T.Type) -> T {
        do {
            return try container.resolve(type)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
