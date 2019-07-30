//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import Action
import UIKit

class VideoDetailViewController: ViewController, StoryboardInitiable {

    // MARK: Properties

    // Static

    static var storyboardName = "Videos"

    // IBOutlets

    @IBOutlet weak var startVideoPlayerButton: UIButton!

    // Private

    private var viewModel: VideoDetailViewModel {
        return storedViewModel as! VideoDetailViewModel
    }

    // MARK: Overrides

    override func setupBindings() {
        super.setupBindings()

        startVideoPlayerButton.rx.bind(to: viewModel.showVideoPlayerAction, input: viewModel.videoMetaData)
    }
}
