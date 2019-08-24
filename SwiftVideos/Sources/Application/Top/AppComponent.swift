//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SwiftVideos_Core
import SuperArcCoreComponent
import SuperArcCore
import SuperArcFoundation

class AppComponent: Component<EmptyDependency> {}

extension AppComponent: HasGitService {

    var gitService: GitService {
        return context.engine.serviceRegistry.resolve(type: GitService.self)
    }
}
