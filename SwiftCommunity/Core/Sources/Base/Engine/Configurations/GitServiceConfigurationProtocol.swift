//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation

public protocol GitRepositoryConfigurationProtocol: Configuration {
    var conferencesRepositoryURL: URL { get }
    var algorithmRepositoryURL: URL { get }
}
