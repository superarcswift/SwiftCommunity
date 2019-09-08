//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Videos
import Core
import SuperArcCoreComponent
import SuperArcCore
import XCoordinator

class VideosComponentRouter: VideosComponentRouterProtocol {

    var context: ApplicationContextProtocol

    lazy var componentsRouter: ComponentsRouter = {
        self.context.viewControllerContext.resolve(type: ComponentsRouterProtocol.self) as! ComponentsRouter
    }()

    init(context: ApplicationContextProtocol) {
        self.context = context
    }

    func trigger(_ route: VideosComponentRoute) -> Presentable {
        switch route {
        case .author(let authorMetaData):
            return componentsRouter.authorsInterface.showAuthor(authorMetaData: authorMetaData, dependency: componentsRouter, anyAuthorsRouter: componentsRouter.authorsRouter, context: context)
        }
    }
}
