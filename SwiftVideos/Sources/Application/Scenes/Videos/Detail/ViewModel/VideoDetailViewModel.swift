//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCoordinator
import SuperArcCoreUI
import SuperArcCore

class VideoDetailViewModel: ViewModel {

    // MARK: Properties

    // Public

    // Private

    private var video: Video
    private let router: AnyRouter<VideosRoute>

    // MARK: Initialization

    init(video: Video, router: AnyRouter<VideosRoute>, engine: Engine) {
        self.video = video
        self.router = router
        super.init(engine: engine)
    }
}
