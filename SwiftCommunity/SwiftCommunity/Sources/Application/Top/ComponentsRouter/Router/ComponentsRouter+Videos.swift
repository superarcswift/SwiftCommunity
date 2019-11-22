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

    let componentsRouter: ComponentsRouter

    // MARK: Initialization

    init(componentsRouter: ComponentsRouter, context: ApplicationContextProtocol) {
        self.componentsRouter = componentsRouter
        self.context = context
    }

    // MARK: APIs

    func trigger(_ route: VideosComponentRoute) -> ComponentPresentable? {
        switch route {
        case .author(let authorMetaData):
            let presentable = componentsRouter.authorsInterface.showAuthor(authorMetaData: authorMetaData, dependency: componentsRouter, anyAuthorsRouter: componentsRouter.authorsRouter)
            return ComponentPresentableWrapper(presentable: presentable)
        }
    }
}
