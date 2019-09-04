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

    var context: ApplicationContextProtocol!

    var interfaceRegistry = InterfaceRegistry()

    // MARK: Setup

    init(context: ApplicationContextProtocol) {
        self.context = context
    }

    func register<T: Interface>(_ instance: T, for type: T.Type) {
        interfaceRegistry.register(instance, for: type)
    }
}
