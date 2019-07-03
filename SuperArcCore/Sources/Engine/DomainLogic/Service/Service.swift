//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation
import Foundation

public protocol Service: ClassNameDerivable {
    var context: ServiceContext { get }
}
