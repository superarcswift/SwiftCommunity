//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Conferences
import CoreNavigation
import Core
import SuperArcCoreComponent
import XCoordinator

extension ComponentsInteractor: ConferencesComponentRoutable {

    func trigger(_ route: NavigationRoute) -> Presentable {
        switch route {
        case .videoDetail(let videoMetaData):
            return videosInterface.showVideo(videoMetaData: videoMetaData, dependency: self, context: context)
        default:
            fatalError("should not happen")
        }
    }
}

// MARK: - Dependencies

extension ComponentsInteractor: HasVideosService {

    var videosService: VideosServiceProtocol {
        return context.engine.serviceRegistry.resolve(type: VideosServiceProtocol.self)
    }
}

extension ComponentsInteractor: HasAuthorsService {

    var authorsService: AuthorsServiceProtocol {
        return context.engine.serviceRegistry.resolve(type: AuthorsServiceProtocol.self)
    }
}
