//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Conferences
import Core
import SuperArcCoreComponent
import SuperArcCore
import XCoordinator

class ConferencesComponentRouter: ConferencesComponentRouterProtocol {

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

    func trigger(_ route: ConferencesComponentRoute) -> ComponentPresentable? {
        switch route {
        case .videos(let conferenceMetaData, let conferenceEdition):
            let presentable = componentsRouter.videosInterface.showVideo(conferenceMetaData: conferenceMetaData, conferenceEdition: conferenceEdition, dependency: componentsRouter, componentsRouter: componentsRouter.videosRouter)
            return ComponentPresentableWrapper(presentable: presentable)

        case .video(let videoMetaData):
            let presentable = componentsRouter.videosInterface.showVideo(videoMetaData: videoMetaData, dependency: componentsRouter, componentsRouter: componentsRouter.videosRouter)
            return ComponentPresentableWrapper(presentable: presentable)
        }
    }
}
