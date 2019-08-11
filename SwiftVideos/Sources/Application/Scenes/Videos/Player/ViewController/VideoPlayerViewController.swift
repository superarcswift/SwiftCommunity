//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import YoutubeKit

class VideoPlayerViewController: ViewController<VideoPlayerViewModel>, StoryboardInitiable {

    // MARK: Properties

    // Static

    static var storyboardName: String = "Videos"

    // IBOutlet

    @IBOutlet weak var playerContainerView: UIView!

    // Public

    private var player: YTSwiftyPlayer!

    // MARK: Overrides

    override func setupViews() {

        super.setupViews()

        if case let .youtube(id) = viewModel.videoMetaData.source {
            player = YTSwiftyPlayer(frame: view.frame, playerVars: [.videoID(id)])
            player.autoplay = false
            playerContainerView.addAndStretchSubView(player)
            player.delegate = self
            player.loadPlayer()

            navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    // MARK: Actions

    @IBAction func didTapClose(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension VideoPlayerViewController: YTSwiftyPlayerDelegate {
}
