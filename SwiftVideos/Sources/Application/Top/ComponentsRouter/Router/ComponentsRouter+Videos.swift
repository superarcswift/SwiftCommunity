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

    var context: ApplicationContextProtocol

    lazy var componentsRouter: ComponentsRouter = {
        self.context.viewControllerContext.resolve(type: ComponentsRouter.self)
    }()

    // MARK: Initialization

    init(context: ApplicationContextProtocol) {
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
