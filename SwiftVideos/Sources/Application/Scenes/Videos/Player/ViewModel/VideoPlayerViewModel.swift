//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore

class VideoPlayerViewModel: ViewModel {

    // MARK: Properties

    var videoMetaData: VideoMetaData

    // MARK: Initialization

    init(videoMetaData: VideoMetaData, engine: Engine) {
        self.videoMetaData = videoMetaData
        super.init(engine: engine)
    }
}
