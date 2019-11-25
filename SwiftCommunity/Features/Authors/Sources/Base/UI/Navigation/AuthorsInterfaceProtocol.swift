//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import DataModels
import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import XCoordinator

public protocol AuthorsInterfaceProtocol: OnDemandInterface {
    func showAuthor(authorMetaData: AuthorMetaData, dependency: AuthorsDependency, anyAuthorsRouter: AnyComponentRouter<AuthorsComponentRoute>) -> Presentable
}
