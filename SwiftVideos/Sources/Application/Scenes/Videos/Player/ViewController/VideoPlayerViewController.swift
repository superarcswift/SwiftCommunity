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

    // IBOutlet

    @IBOutlet weak var playerContainerView: UIView!

    // Public

    // Private

    private var viewModel: VideoPlayerViewModel {
        return storedViewModel as! VideoPlayerViewModel
    }

    private var player: YTSwiftyPlayer!

    // MARK: Overrides

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeLeft
    }

    override func setupViews() {

        super.setupViews()

        // Load the video.
        if case let .youtube(id) = viewModel.videoMetaData.source {
            print(id)
            player = YTSwiftyPlayer(frame: view.frame, playerVars: [.videoID("pn7Gr9zn3cs")])
            player.autoplay = false
            playerContainerView.addAndStretchSubView(player)
            player.delegate = self
            player.loadPlayer()

            navigationController?.setNavigationBarHidden(true, animated: false)
//            let value = UIInterfaceOrientation.landscapeLeft.rawValue
//            UIDevice.current.setValue(value, forKey: "orientation")
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    @IBAction func didTapClose(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension VideoPlayerViewController: YTSwiftyPlayerDelegate {

}
