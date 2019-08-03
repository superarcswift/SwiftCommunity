//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcNotificationBanner
import SuperArcStateView
import SuperArcCoreUI
import SuperArcCore
import XCoordinator
import Action
import RxSwift
import RxCocoa

protocol VideosCollectionViewModelInput {
    var conferenceMetaData: ConferenceMetaData? { get }
    var conferenceEdition: ConferenceEdition? { get }
    var didSelectVideoTrigger: AnyObserver<VideoMetaData> { get }
}

protocol VideosCollectionViewModelOutput {
    var videos: BehaviorRelay<[VideoMetaData]> { get set }
    var title: String { get }
}

class VideosCollectionViewModel: ViewModel, VideosCollectionViewModelInput, VideosCollectionViewModelOutput {

    // MARK: Properties

    private let router: AnyRouter<VideosRoute>
    private lazy var showVideoAction = Action<VideoMetaData, Void> { [unowned self] video in
        self.router.rx.trigger(.videoDetail(video))
    }

    // Public

    lazy var didSelectVideoTrigger: AnyObserver<VideoMetaData> = showVideoAction.inputs
    var videos = BehaviorRelay<[VideoMetaData]>(value: [])
    var title: String {
        guard let conferenceMetaData = conferenceMetaData, let conferenceEdition = conferenceEdition else {
            return "Videos"
        }
        return "\(conferenceMetaData.name) - \(conferenceEdition.year)"
    }

    var toogleStateView = PublishSubject<StandardStateViewContext?>()
    var notification = PublishSubject<SuperArcNotificationBanner.Notification?>()

    // Private

    var conferenceMetaData: ConferenceMetaData?
    var conferenceEdition: ConferenceEdition?

    // MARK: Initialization

    init(router: AnyRouter<VideosRoute>, engine: Engine, conferenceMetaData: ConferenceMetaData?, conferenceEdition: ConferenceEdition?) {
        self.router = router
        self.conferenceMetaData = conferenceMetaData
        self.conferenceEdition = conferenceEdition
        super.init(engine: engine)
    }

    // MARK: APIs

    func loadData() {
        if let conferenceMetaData = conferenceMetaData, let conferenceEdition = conferenceEdition {
            fetchVideosList(of: conferenceMetaData, in: conferenceEdition)
        } else {
            fetchVideosList()
        }
    }

    // MARK: Private helpers

    func fetchVideosList() {
        videosService.fetchList()
            .done { [weak self] videos in
                self?.videos.accept(videos)
            }
            .catch { [weak self] error in
                self?.toogleStateView.onNext(StandardStateViewContext(headline: "No videos found"))
                self?.notification.onNext(StandardNotification(error: error))
            }
    }

    func fetchVideosList(of conference: ConferenceMetaData, in edition: ConferenceEdition) {
        videosService.fetchList(of: conference, in: edition)
            .done { [weak self] videos in
                self?.videos.accept(videos)
            }
            .catch { [weak self] error in
                self?.toogleStateView.onNext(StandardStateViewContext(headline: "No videos found for conference \(conference.name)"))
                self?.notification.onNext(StandardNotification(error: error))
            }
    }

    func previewImage(for video: VideoMetaData) -> UIImage? {

        guard let previewImageURL = videosService.previewImageURL(for: video) else {
            return UIImage(named: "video_preview_default")
        }

        guard let previewImage = UIImage(contentsOfFile: previewImageURL.path) else {
            return UIImage(named: "video_preview_default")
        }

        return previewImage
    }

    func close() {
        router.trigger(.close)
    }
}

// MARK: - Dependencies

extension VideosCollectionViewModel {

    var videosService: VideosService {
        return engine.serviceRegistry.resolve(type: VideosService.self)
    }
}
