//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Videos
import CoreUX
import Core
import DataModels
import SuperArcCoreUI
import SuperArcCore
import XCoordinator

extension NavigationDelegateManager: ConferencesNavigationDelegate {

    public func showVideo(conferenceMetaData: ConferenceMetaData, conferenceEdition: ConferenceEdition, dependency: VideosDependency, context: ApplicationContext) -> Presentable {
        return VideosCoordinator(initialRoute: .videos(conferenceMetaData, conferenceEdition), depedency: dependency, context: context)
    }

    public func showVideo(videoMetaData: VideoMetaData, dependency: VideosDependency, context: ApplicationContext) -> Presentable {
        return VideosCoordinator(initialRoute: .videoDetail(videoMetaData, true), depedency: dependency, context: context)
    }

}
