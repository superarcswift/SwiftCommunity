//
//  Copyright © 2019 An Tran. All rights reserved.
//

import CoreUX
import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation

class ComponentsInteractor: ComponentsInteractorProtocol {

    // MARK: Properties

    // Private

    internal var context: ApplicationContextProtocol!
    internal var interfaceRegistry = InterfaceRegistry()

    // MARK: Setup

    init(context: ApplicationContextProtocol) {
        self.context = context
    }

    // MARK: APIs

    func register<T: Interface>(_ instance: T, for type: T.Type) {
        interfaceRegistry.register(instance, for: type)
    }
}
