//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import RxCocoa
import RxSwift
import YoutubeKit
import AVKit
import UIKit

class VideoDetailViewController: ViewController<VideoDetailViewModel>, StoryboardInitiable {

    // MARK: Properties

    // Static

    static var storyboardName = "Videos"

    enum SegueIdentifier: String {
        case showEmbeddedVideoPlayer
    }

    // IBOutlets

    @IBOutlet weak var videoPlayerContainerView: UIView!
    @IBOutlet weak var startVideoPlayerButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var conferenceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    // Public

    weak var videosComponent: VideosComponent!

    // Private

    private var youtubePlayer: YTSwiftyPlayer!
    private var streamingPlayer: AVPlayer!

    private let disposeBag = DisposeBag()

    // MARK: Setup

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
    }

    override func setupBindings() {
        super.setupBindings()

        viewModel.notification
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.notification)
            .disposed(by: disposeBag)

        viewModel.toogleStateView
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.toogleStateView)
            .disposed(by: disposeBag)

        viewModel.outputs.videoDetail.subscribe { [weak self] event in
            guard let video = event.element else {
                return
            }

            self?.nameLabel.text = video?.metaData.name
            self?.conferenceLabel.text = video?.metaData.conference.metaData.name
            self?.descriptionLabel.text = video?.description

        }.disposed(by: disposeBag)
    }

    // MARK: APIs

    override func loadData() {
        viewModel.apis.loadData()
    }

    // MARK: Private helpers

    private func setupYoutubePlayer(withVideoID id: String) {
        youtubePlayer = YTSwiftyPlayer(frame: view.frame, playerVars: [.videoID(id)])
        youtubePlayer.autoplay = false
        videoPlayerContainerView.addAndStretchSubView(youtubePlayer)
//        youtubePlayer.delegate = self
        youtubePlayer.loadPlayer()
    }

    private func setupStreamingPlayer(withVideoURL urlString: String)  {

        if let url = URL(string: urlString) {
            streamingPlayer = AVPlayer(url: url)
            let streamingPlayerController = AVPlayerViewController()
            streamingPlayerController.player = streamingPlayer
            streamingPlayerController.view.frame = videoPlayerContainerView.bounds
            addChild(streamingPlayerController)
            videoPlayerContainerView.addAndStretchSubView(streamingPlayerController.view)
            streamingPlayerController.didMove(toParent: self)
        }
    }
}
