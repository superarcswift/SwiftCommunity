//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import YoutubeKit

class VideoPlayerViewController: ViewController, StoryboardInitiable {

    // MARK: Properties

    // Static

    static var storyboardName: String = "Videos"

    // Public

    // Private

    private var viewModel: VideoPlayerViewModel {
        return storedViewModel as! VideoPlayerViewModel
    }

    private var player: YTSwiftyPlayer!

    // MARK: Lifecycles

    override func setupViews() {

        super.setupViews()

        // Load the video.
        if case let .youtube(id) = viewModel.videoMetaData.source {
            print(id)
            player = YTSwiftyPlayer(frame: view.frame, playerVars: [.videoID("pn7Gr9zn3cs")])
            player.autoplay = false
            view = player
            player.delegate = self
            player.loadPlayer()
        }
    }
}

extension VideoPlayerViewController: YTSwiftyPlayerDelegate {

}
