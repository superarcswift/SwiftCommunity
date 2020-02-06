//
//  Copyright © 2019 An Tran. All rights reserved.
//

public protocol Registry {
    associatedtype ElementType

    var container: Container<ElementType> { get }
}

// MARK: - Register/Resolve

extension Registry {

    public func register<ElementType>(_ instance: ElementType, for type: ElementType.Type) {
        do {
            try container.register(instance, for: type)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    public func register<ElementType>(type: ElementType.Type, builder: @escaping () -> ElementType) {
        do {
            try container.register(type, builder: builder)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    public func deregister<ElementType>(type: ElementType.Type) {
        container.deregister(type
        )
    }

    public func resolve<ElementType>(type: ElementType.Type) -> ElementType {
        do {
            return try container.resolve(type)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

// MARK: - Type erasure

private class _AnyRegistryBase<ElementType>: Registry {

    var container: Container<ElementType> {
        fatalError("must override")
    }

    init() {
        guard type(of: self) != _AnyRegistryBase.self else {
            fatalError("Cannot initialise, must subclass")
        }
    }
}

private final class _AnyRegistryBox<ConcreteRegistry: Registry>: _AnyRegistryBase<ConcreteRegistry.ElementType> {

    var concrete: ConcreteRegistry

    override var container: Container<ConcreteRegistry.ElementType> {
        return concrete.container
    }

    init(_ concrete: ConcreteRegistry) {
        self.concrete = concrete
        super.init()
    }
}

open class AnyRegistry<ElementType>: Registry {

    private let box: _AnyRegistryBase<ElementType>

    public var container: Container<ElementType> {
        return box.container
    }

    public init<ConcreteRegistry: Registry>(_ concrete: ConcreteRegistry) where ConcreteRegistry.ElementType == ElementType {
        box = _AnyRegistryBox(concrete)
    }
}
