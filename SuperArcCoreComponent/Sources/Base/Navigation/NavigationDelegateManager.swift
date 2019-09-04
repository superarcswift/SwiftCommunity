//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import SuperArcFoundation

public protocol ComponentsInteractorProtocol: HasApplicationContext {
    var interfaceRegistry: InterfaceRegistry { get }
}

public protocol HasComponentsInteractor {
    var componentsInteractor: ComponentsInteractorProtocol { get }
}

public class InterfaceRegistry: Registry {

    // MARK: Properties

    public var container: Container<Interface>

    // MARK: Initialization

    public init() {
        container = Container()
    }
}
