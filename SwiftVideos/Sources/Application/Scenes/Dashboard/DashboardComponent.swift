//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent

class DashboardComponent: Component<EmptyDependency> {}

extension DashboardComponent: HasConferencesService {

    var conferencesService: ConferencesService {
        return context.engine.serviceRegistry.resolve(type: ConferencesService.self)
    }
}

extension DashboardComponent: HasVideosService {

    var videosService: VideosService {
        return context.engine.serviceRegistry.resolve(type: VideosService.self)
    }
}

extension DashboardComponent: HasAuthorsService {

    var authorsService: AuthorsService {
        return context.engine.serviceRegistry.resolve(type: AuthorsService.self)
    }
}

extension DashboardComponent: HasGitService {

    var gitService: GitService {
        return context.engine.serviceRegistry.resolve(type: GitService.self)
    }
}
