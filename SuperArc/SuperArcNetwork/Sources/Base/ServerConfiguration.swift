//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation

public protocol ServerConfiguration: Configuration {
    var baseURL: URL { get }
}
