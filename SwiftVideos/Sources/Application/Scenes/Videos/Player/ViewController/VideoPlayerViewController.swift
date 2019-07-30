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

    // Private

    private var player: YTSwiftyPlayer!

    // MARK: Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a new player
        player = YTSwiftyPlayer(
            frame: view.frame,
            playerVars: [.videoID("8WDzlcunouY")])

        // Enable auto playback when video is loaded
        player.autoplay = true

        // Set player view.
        view = player

        // Set delegate for detect callback information from the player.
//        player.delegate = self

        // Load the video.
        player.loadPlayer()
    }
}
