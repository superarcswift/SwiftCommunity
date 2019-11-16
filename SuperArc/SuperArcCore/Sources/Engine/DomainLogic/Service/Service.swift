//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation
import Foundation

public protocol Service: ClassNameDerivable {
    var context: ServiceContext { get }
}

/// Services adopting this protocol can be auto-created by the Engine.
public protocol OnDemandService {
    init(onDemandWith context: ServiceContext)
}
