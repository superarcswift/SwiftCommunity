//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Authors
import Core
import SuperArcCoreComponent
import SuperArcCore
import XCoordinator

class AuthorsComponentRouter: AuthorsComponentRouterProtocol {

    var context: ApplicationContextProtocol

    lazy var componentsRouter: ComponentsRouter = {
        self.context.viewControllerContext.resolve(type: ComponentsRouterProtocol.self) as! ComponentsRouter
    }()

    init(context: ApplicationContextProtocol) {
        self.context = context
    }

    func trigger(_ route: AuthorsComponentRoute) -> Presentable {
        switch route {
        case .video(let videoMetaData):
            return componentsRouter.videosInterface.showVideo(videoMetaData: videoMetaData, dependency: componentsRouter, componentsRouter: componentsRouter.videosRouter, context: context)
        }
    }
}
