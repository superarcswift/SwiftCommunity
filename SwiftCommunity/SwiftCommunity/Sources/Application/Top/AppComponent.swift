//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation

class AppComponent: Component<EmptyDependency, EmptyViewBuildable, EmptyInterface, EmptyComponentRoute> {}

extension AppComponent: HasConferencesGitService {

    var conferencesGitService: ConferencesGitService {
        return dependencyProvider.context.engine.serviceRegistry.resolve(type: ConferencesGitService.self)
    }
}
