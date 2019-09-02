//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import DataModels
import SuperArcCoreUI
import SuperArcCore
import XCoordinator

public protocol ConferencesNavigationDelegate: NavigationDelegate {
    func showVideo(conferenceMetaData: ConferenceMetaData, conferenceEdition: ConferenceEdition, dependency: VideosDependency, context: ApplicationContext) -> Presentable
    func showVideo(videoMetaData: VideoMetaData, dependency: VideosDependency, context: ApplicationContext) -> Presentable
}
