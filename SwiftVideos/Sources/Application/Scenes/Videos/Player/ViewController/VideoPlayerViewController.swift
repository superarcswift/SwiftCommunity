//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import YoutubeKit
import Player

class VideoPlayerViewController: ViewController<VideoPlayerViewModel>, StoryboardInitiable {

    // MARK: Properties

    // Static

    static var storyboardName: String = "Videos"

    // IBOutlet

    @IBOutlet weak var playerContainerView: UIView!

    // Public

    private var youtubePlayer: YTSwiftyPlayer!
    private var streamingPlayer: Player!

    // MARK: Overrides

    override func setupViews() {

        super.setupViews()

        switch viewModel.videoMetaData.source {
        case .youtube(let id):
            setupYoutubePlayer(withVideoID:  id)
        case .wwdc(let url):
            setupStreamingPlayer(withVideoURL: url)
        default:
            fatalError("video source not supported")
        }

        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    // MARK: Actions

    @IBAction func didTapClose(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    //  MARK: Private helpers

    private func setupYoutubePlayer(withVideoID id: String) {
        youtubePlayer = YTSwiftyPlayer(frame: view.frame, playerVars: [.videoID(id)])
        youtubePlayer.autoplay = false
        playerContainerView.addAndStretchSubView(youtubePlayer)
        youtubePlayer.delegate = self
        youtubePlayer.loadPlayer()
    }

    private func setupStreamingPlayer(withVideoURL urlString: String)  {
        streamingPlayer = Player()
        playerContainerView.addAndStretchSubView(streamingPlayer.view)
        streamingPlayer.didMove(toParent: self)

        if let url = URL(string: urlString) {
            streamingPlayer.url = url
            streamingPlayer.playFromBeginning()
        }
    }
}

extension VideoPlayerViewController: YTSwiftyPlayerDelegate {}
