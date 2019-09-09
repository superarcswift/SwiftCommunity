//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Conferences
import Core
import SuperArcCoreComponent
import SuperArcCore
import XCoordinator

class ConferencesComponentRouter: ConferencesComponentRouterProtocol {

    var context: ApplicationContextProtocol

    lazy var componentsRouter: ComponentsRouter = {
        // TODO: See if we can remove this force cast
        self.context.viewControllerContext.resolve(type: ComponentsRouterProtocol.self) as! ComponentsRouter
    }()

    init(context: ApplicationContextProtocol) {
        self.context = context
    }

    func trigger(_ route: ConferencesComponentRoute) -> ComponentPresentable {
        switch route {
        case .videos(let conferenceMetaData, let conferenceEdition):
            let presentable = componentsRouter.videosInterface.showVideo(conferenceMetaData: conferenceMetaData, conferenceEdition: conferenceEdition, dependency: componentsRouter, componentsRouter: componentsRouter.videosRouter, context: context)
            return ComponentPresentableWrapper(presentable: presentable)

        case .video(let videoMetaData):
            let presentable = componentsRouter.videosInterface.showVideo(videoMetaData: videoMetaData, dependency: componentsRouter, componentsRouter: componentsRouter.videosRouter, context: context)
            return ComponentPresentableWrapper(presentable: presentable)
        }
    }
}
