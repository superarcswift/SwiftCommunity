//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Videos

extension NavigationDelegateManager {

    var videosInterface: VideosInterfaceProtocol {
        return interfaceRegistry.resolve(type: VideosInterfaceProtocol.self)
    }
}
