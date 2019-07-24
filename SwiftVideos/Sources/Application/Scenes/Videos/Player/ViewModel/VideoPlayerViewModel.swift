//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore

class VideoPlayerViewModel: ViewModel {
    var video: Video

    init(video: Video, engine: Engine) {
        self.video = video
        super.init(engine: engine)
    }
}
