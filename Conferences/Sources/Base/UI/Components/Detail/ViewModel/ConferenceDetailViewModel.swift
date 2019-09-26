//
//  Copyright © 2019 An Tran. All rights reserved.
//

import CoreUX
import Core
import DataModels
import SuperArcNotificationBanner
import SuperArcStateView
import SuperArcCoreUI
import SuperArcCore
import XCoordinator
import Action
import RxSwift
import RxCocoa
import Foundation

protocol ConferenceDetailViewModelInput {
    var conferenceMetaData: ConferenceMetaData { get }
    var didSelectVideoTrigger: AnyObserver<VideoViewModel> { get }
}

protocol ConferenceDetailViewModelOutput {
    var conferenceEditions: BehaviorRelay<[ConferenceDetailSectionModel]> { get set }
}

protocol ConferenceDetailViewModelApi {
    func loadData()
    func sectionTitle(for index: Int) -> String
}

protocol ConferenceDetailViewModelType {
    var inputs: ConferenceDetailViewModelInput { get }
    var outputs: ConferenceDetailViewModelOutput { get }
    var apis: ConferenceDetailViewModelApi { get }
}

extension ConferenceDetailViewModelType where Self: ConferenceDetailViewModelInput & ConferenceDetailViewModelOutput & ConferenceDetailViewModelApi {

    var inputs: ConferenceDetailViewModelInput {
        return self
    }

    var outputs: ConferenceDetailViewModelOutput {
        return self
    }

    var apis: ConferenceDetailViewModelApi {
        return self
    }
}

public class ConferenceDetailViewModel: CoordinatedDIViewModel<ConferencesRoute, ConferencesDependency>, ConferenceDetailViewModelType, ConferenceDetailViewModelInput, ConferenceDetailViewModelOutput, ConferenceDetailViewModelApi {

    // MARK: Properties

    // Public

    public let conferenceMetaData: ConferenceMetaData
    public var conferenceEditions = BehaviorRelay<[ConferenceDetailSectionModel]>(value: [])
    public lazy var didSelectVideoTrigger: AnyObserver<VideoViewModel> = showVideoAction.inputs

    public var toogleStateView = PublishSubject<StandardStateViewContext?>()
    public var notification = PublishSubject<SuperArcNotificationBanner.Notification?>()

    // Private

    private lazy var showConferenceEditionAction = Action<ConferenceEdition, Void> { [unowned self] conferenceEdition in
        self.router.rx.trigger(.conferenceEditionDetail(self.conferenceMetaData, conferenceEdition))
    }

    private lazy var showVideoAction = Action<VideoViewModel, Void> { [unowned self] video in
        self.router.rx.trigger(.video(video.videoMetaData))
    }

    // MARK: Initialization

    init(conferenceMetaData: ConferenceMetaData, router: UnownedRouter<ConferencesRoute>, dependency: ConferencesDependency) {
        self.conferenceMetaData = conferenceMetaData
        super.init(router: router, dependency: dependency)
    }

    // MARK: APIs

    func loadData() {
        dependency.conferencesService.fetchVideos(conferenceMetaData: conferenceMetaData)
            .mapValues { videos -> ConferenceDetailSectionModel in
                let videoModels = videos.compactMap { VideoViewModel(videoMetaData: $0, videosService: self.dependency.videosService, authorsService: self.dependency.authorsService) }
                return .videosSection(items: videoModels)
            }.done { [weak self] sectionModel in
                self?.conferenceEditions.accept(sectionModel)
            }.catch { [weak self] error in
                self?.toogleStateView.on(.next(StandardStateViewContext(headline: error.localizedDescription)))
            }
    }

    func sectionTitle(for index: Int) -> String {
        guard index < conferenceEditions.value.count else {
            fatalError("index is out of bound")
        }

        return String(conferenceEditions.value[index].items.first!.conferenceEditionYear)
    }
}
