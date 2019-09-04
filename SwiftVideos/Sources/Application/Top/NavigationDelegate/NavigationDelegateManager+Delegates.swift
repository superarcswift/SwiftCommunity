//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Conferences
import Videos
import Authors
import CoreUX
import Core
import DataModels
import SuperArcCoreUI
import SuperArcCore
import XCoordinator

extension NavigationDelegateManager: ConferencesNavigationDelegate, AuthorsNavigationDelegate {

    public func showVideo(conferenceMetaData: ConferenceMetaData, conferenceEdition: ConferenceEdition, dependency: VideosDependency, context: ApplicationContextProtocol) -> Presentable {
        return videosInterface.showVideo(conferenceMetaData: conferenceMetaData, conferenceEdition: conferenceEdition, dependency: dependency, context: context)
    }

    public func showVideo(videoMetaData: VideoMetaData, dependency: VideosDependency, context: ApplicationContextProtocol) -> Presentable {
        return videosInterface.showVideo(videoMetaData: videoMetaData, dependency: dependency, context: context)
    }

}
