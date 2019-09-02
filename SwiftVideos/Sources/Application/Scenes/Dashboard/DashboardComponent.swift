//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Conferences
import Core
import SuperArcCoreComponent
import SuperArcCoreUI

class DashboardComponent: Component<EmptyDependency, EmptyViewBuildable> {}

// MARK: Children's dependencies

extension DashboardComponent: HasConferencesService {

    var conferencesService: ConferencesServiceProtocol {
        return context.engine.serviceRegistry.resolve(type: ConferencesServiceProtocol.self)
    }
}

extension DashboardComponent: HasVideosService {

    var videosService: VideosServiceProtocol {
        return context.engine.serviceRegistry.resolve(type: VideosServiceProtocol.self)
    }
}

extension DashboardComponent: HasAuthorsService {

    var authorsService: AuthorsServiceProtocol {
        return context.engine.serviceRegistry.resolve(type: AuthorsServiceProtocol.self)
    }
}

extension DashboardComponent: HasGitService {

    var gitService: GitServiceProtocol {
        return context.engine.serviceRegistry.resolve(type: GitServiceProtocol.self)
    }
}
