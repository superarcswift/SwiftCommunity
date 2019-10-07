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

    var context: ApplicationContextProtocol

    lazy var componentsRouter: ComponentsRouter = {
        self.context.viewControllerContext.resolve(type: ComponentsRouter.self)
    }()

    // MARK: Initialization

    init(context: ApplicationContextProtocol) {
        self.context = context
    }

    // MARK: APIs

    func trigger(_ route: AuthorsComponentRoute) -> ComponentPresentable? {
        switch route {
        case .video(let videoMetaData):
            let presentable = componentsRouter.videosInterface.showVideo(videoMetaData: videoMetaData, dependency: componentsRouter, componentsRouter: componentsRouter.videosRouter)
            return ComponentPresentableWrapper(presentable: presentable)
        }
    }
}
