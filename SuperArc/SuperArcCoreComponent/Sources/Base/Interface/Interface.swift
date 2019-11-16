//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore

public protocol Interface: HasApplicationContext {}

public protocol OnDemandInterface {
    init(onDemandWith context: ApplicationContextProtocol)
}

public class EmptyInterface: Interface {

    public var context: ApplicationContextProtocol! {
        get {
            fatalError("should never be used")
        }
        //swiftlint:disable:next unused_setter_value
        set {
            fatalError("should never be used")
        }
    }
}
