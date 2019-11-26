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

    let navigator: Navigator

    // MARK: Initialization

    init(navigator: Navigator, context: ApplicationContextProtocol) {
        self.navigator = navigator
        self.context = context
    }

    // MARK: APIs

    func trigger(_ route: AuthorsComponentRoute) -> ComponentPresentable? {
        switch route {
        case .video(let videoMetaData):
            let presentable = navigator.videosInterface.showVideo(videoMetaData: videoMetaData,
                                                                         dependency: navigator,
                                                                         router: navigator.videosRouter)
            return ComponentPresentableWrapper(presentable: presentable)
        }
    }
}
