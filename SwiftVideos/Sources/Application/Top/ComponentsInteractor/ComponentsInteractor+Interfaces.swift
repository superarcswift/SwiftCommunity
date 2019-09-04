//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Videos

extension ComponentsInteractor {

    var videosInterface: VideosInterfaceProtocol {
        return interfaceRegistry.resolve(type: VideosInterfaceProtocol.self)
    }
}
