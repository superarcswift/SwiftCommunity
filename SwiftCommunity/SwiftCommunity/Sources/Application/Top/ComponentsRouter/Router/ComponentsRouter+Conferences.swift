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

    let navigator: Navigator

    // MARK: Initialization

    init(navigator: Navigator, context: ApplicationContextProtocol) {
        self.navigator = navigator
        self.context = context
    }

    // MARK: APIs

    func trigger(_ route: ConferencesComponentRoute) -> ComponentPresentable? {
        switch route {
        case .videos(let conferenceMetaData, let conferenceEdition):
            let presentable = navigator.videosInterface.showVideo(conferenceMetaData: conferenceMetaData,
                                                                  conferenceEdition: conferenceEdition,
                                                                  dependency: navigator,
                                                                  router: navigator.videosRouter)
            return ComponentPresentableWrapper(presentable: presentable)

        case .video(let videoMetaData):
            let presentable = navigator.videosInterface.showVideo(videoMetaData: videoMetaData,
                                                                  dependency: navigator,
                                                                  router: navigator.videosRouter)
            return ComponentPresentableWrapper(presentable: presentable)
        }
    }
}
