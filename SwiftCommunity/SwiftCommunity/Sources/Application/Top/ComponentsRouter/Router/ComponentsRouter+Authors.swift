//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Authors
import Core
import SuperArcCoreComponent
import SuperArcCore
import XCoordinator

class AuthorsComponentRouter: AuthorsComponentRouterProtocol {

    // MARK: Properties

    let context: ApplicationContextProtocol

    let componentsRouter: ComponentsRouter

    // MARK: Initialization

    init(componentsRouter: ComponentsRouter, context: ApplicationContextProtocol) {
        self.componentsRouter = componentsRouter
        self.context = context
    }

    // MARK: APIs

    func trigger(_ route: AuthorsComponentRoute) -> ComponentPresentable? {
        switch route {
        case .video(let videoMetaData):
            let presentable = componentsRouter.videosInterface.showVideo(videoMetaData: videoMetaData,
                                                                         dependency: componentsRouter,
                                                                         router: componentsRouter.videosRouter)
            return ComponentPresentableWrapper(presentable: presentable)
        }
    }
}
