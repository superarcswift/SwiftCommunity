//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation

public protocol HasConfigurations {
    var configurations: AnyRegistry<Configuration> { get }
}
