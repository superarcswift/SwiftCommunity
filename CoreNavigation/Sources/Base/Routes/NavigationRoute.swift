//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import DataModels

public enum NavigationRoute: ComponentRoute {
    case videoListByConference(ConferenceMetaData, ConferenceEdition)
    case videoListByAuthor(AuthorMetaData)
    case videoDetail(VideoMetaData)
}
