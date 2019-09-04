//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import DataModels
import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import XCoordinator

public protocol VideosNavigationDelegate: NavigationDelegate {
    func showAuthor(authorMetaData: AuthorMetaData, dependency: AuthorsDependency, context: ApplicationContextProtocol) -> Presentable
}
