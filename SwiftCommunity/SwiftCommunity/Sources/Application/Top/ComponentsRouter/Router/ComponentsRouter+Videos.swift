//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Videos
import Core
import SuperArcCoreComponent
import SuperArcCore
import XCoordinator

class VideosComponentRouter: VideosComponentRouterProtocol {

    // MARK: Properties

    let context: ApplicationContextProtocol

    let navigator: Navigator

    // MARK: Initialization

    init(navigator: Navigator, context: ApplicationContextProtocol) {
        self.navigator = navigator
        self.context = context
    }

    // MARK: APIs

    func trigger(_ route: VideosComponentRoute) -> ComponentPresentable? {
        switch route {
        case .author(let authorMetaData):
            let presentable = navigator.authorsInterface.showAuthor(authorMetaData: authorMetaData,
                                                                           dependency: navigator,
                                                                           anyAuthorsRouter: navigator.authorsRouter)
            return ComponentPresentableWrapper(presentable: presentable)
        }
    }
}
