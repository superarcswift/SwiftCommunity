//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore

public protocol GitRepositoryConfigurationProtocol: Configuration {
    var url: URL { get }
}
