//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import DataModels
import SuperArcCore
import XCoordinator

public protocol AuthorsNavigationDelegate {
    func showVideo(videoMetaData: VideoMetaData, dependency: VideosDependency, context: ApplicationContextProtocol) -> Presentable
}
