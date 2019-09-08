//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import DataModels
import SuperArcCoreComponent
import SuperArcCore
import XCoordinator

public protocol VideosInterfaceProtocol: Interface {
    func showVideo(conferenceMetaData: ConferenceMetaData, conferenceEdition: ConferenceEdition, dependency: VideosDependency, componentsRouter: AnyComponentRouter<VideosComponentRoute>, context: ApplicationContextProtocol) -> Presentable
    func showVideo(videoMetaData: VideoMetaData, dependency: VideosDependency, componentsRouter: AnyComponentRouter<VideosComponentRoute>, context: ApplicationContextProtocol) -> Presentable
}
