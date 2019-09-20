//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore

public protocol Interface: HasApplicationContext {}

public class EmptyInterface: Interface {

    public var context: ApplicationContextProtocol! {
        get {
            fatalError("should never be used")
        }
        set {
            fatalError("should never be used")
        }
    }
}
