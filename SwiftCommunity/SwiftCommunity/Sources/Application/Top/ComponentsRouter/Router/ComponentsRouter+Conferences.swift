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

    let context: ApplicationContextProtocol

    let componentsRouter: Navigator

    // MARK: Initialization

    init(componentsRouter: Navigator, context: ApplicationContextProtocol) {
        self.componentsRouter = componentsRouter
        self.context = context
    }

    // MARK: APIs

    func trigger(_ route: ConferencesComponentRoute) -> ComponentPresentable? {
        switch route {
        case .videos(let conferenceMetaData, let conferenceEdition):
            let presentable = componentsRouter.videosInterface.showVideo(conferenceMetaData: conferenceMetaData,
                                                                         conferenceEdition: conferenceEdition,
                                                                         dependency: componentsRouter,
                                                                         router: componentsRouter.videosRouter)
            return ComponentPresentableWrapper(presentable: presentable)

        case .video(let videoMetaData):
            let presentable = componentsRouter.videosInterface.showVideo(videoMetaData: videoMetaData,
                                                                         dependency: componentsRouter,
                                                                         router: componentsRouter.videosRouter)
            return ComponentPresentableWrapper(presentable: presentable)
        }
    }
}
