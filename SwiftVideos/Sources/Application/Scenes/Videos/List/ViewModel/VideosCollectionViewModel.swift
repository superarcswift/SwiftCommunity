//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SwiftVideos_DataModels
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
    var didSelectVideoTrigger: AnyObserver<VideoViewModel> { get }
}

protocol VideosCollectionViewModelOutput {
    var videos: BehaviorRelay<[VideoViewModel]> { get set }
    var title: String { get }
}

protocol VideosCollectionViewModelApi {
    func loadData()
}

protocol VideosCollectionViewModelType {
    var inputs: VideosCollectionViewModelInput { get }
    var outputs: VideosCollectionViewModelOutput { get }
    var apis: VideosCollectionViewModelApi { get }
}

extension VideosCollectionViewModelType where Self: VideosCollectionViewModelInput & VideosCollectionViewModelOutput & VideosCollectionViewModelApi {

    var inputs: VideosCollectionViewModelInput {
        return self
    }

    var outputs: VideosCollectionViewModelOutput {
        return self
    }

    var apis: VideosCollectionViewModelApi {
        return self
    }
}

class VideosCollectionViewModel: CoordinatedDIViewModel<VideosRoute, VideosDependency>, VideosCollectionViewModelType, VideosCollectionViewModelInput, VideosCollectionViewModelOutput, VideosCollectionViewModelApi {

    // MARK: Properties

    private lazy var showVideoAction = Action<VideoViewModel, Void> { [unowned self] video in
        self.router.rx.trigger(.videoDetail(video.videoMetaData, false))
    }

    // Public

    lazy var didSelectVideoTrigger: AnyObserver<VideoViewModel> = showVideoAction.inputs
    var videos = BehaviorRelay<[VideoViewModel]>(value: [])
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

    init(router: AnyRouter<VideosRoute>, dependency: VideosDependency, conferenceMetaData: ConferenceMetaData?, conferenceEdition: ConferenceEdition?) {
        self.conferenceMetaData = conferenceMetaData
        self.conferenceEdition = conferenceEdition
        super.init(router: router, dependency: dependency)
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
        dependency.videosService.fetchList()
            .mapValues {
                VideoViewModel(videoMetaData: $0, videosService: self.dependency.videosService, authorsService: self.dependency.authorsService)
            }.done { [weak self] videos in
                self?.videos.accept(videos)
            }.catch { [weak self] error in
                self?.toogleStateView.onNext(StandardStateViewContext(headline: "No videos found"))
                self?.notification.onNext(StandardNotification(error: error))
            }
    }

    func fetchVideosList(of conference: ConferenceMetaData, in edition: ConferenceEdition) {
        dependency.videosService.fetchList(conference: conference, edition: edition)
            .mapValues {
                VideoViewModel(videoMetaData: $0, videosService: self.dependency.videosService, authorsService: self.dependency.authorsService)
            }.done { [weak self] videos in
                self?.videos.accept(videos)
            }.catch { [weak self] error in
                self?.toogleStateView.onNext(StandardStateViewContext(headline: "No videos found for conference \(conference.name)"))
                self?.notification.onNext(StandardNotification(error: error))
            }
    }

    func close() {
        router.trigger(.close)
    }
}
