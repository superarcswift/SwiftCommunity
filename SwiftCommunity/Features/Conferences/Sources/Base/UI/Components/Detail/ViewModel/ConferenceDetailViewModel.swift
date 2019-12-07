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
    var conferenceViewModel: ConferenceViewModel { get }
    var didSelectVideoTrigger: AnyObserver<VideoViewModel> { get }
}

protocol ConferenceDetailViewModelOutput {
    var conferenceEditions: BehaviorRelay<[ConferenceDetailSectionModel]> { get set }
}

protocol ConferenceDetailViewModelApi {
    func loadData()
    func sectionTitle(for sectionIndex: Int) -> String?
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

    public var conferenceEditions = BehaviorRelay<[ConferenceDetailSectionModel]>(value: [])
    public lazy var didSelectVideoTrigger: AnyObserver<VideoViewModel> = showVideoAction.inputs

    public var toogleStateView = PublishSubject<StandardStateViewContext?>()
    public var notification = PublishSubject<SuperArcNotificationBanner.Notification?>()

    // Private

    private lazy var showVideoAction = Action<VideoViewModel, Void> { [unowned self] video in
        self.router.rx.trigger(.video(video.videoMetaData))
    }

    let conferenceViewModel: ConferenceViewModel

    // MARK: Initialization

    init(conferenceMetaData: ConferenceMetaData, router: UnownedRouter<ConferencesRoute>, dependency: ConferencesDependency) {
        conferenceViewModel = ConferenceViewModel(conferenceMetaData: conferenceMetaData, conferencesService: dependency.conferencesService)
        super.init(router: router, dependency: dependency)
    }

    // MARK: APIs

    func loadData() {
        dependency.conferencesService.fetchVideos(conferenceMetaData: conferenceViewModel.conferenceMetaData)
            .mapValues { videos -> ConferenceDetailSectionModel in
                let videoSectionDataModels = videos.compactMap { ConferenceDetailSectionDataModel.video(VideoViewModel(videoMetaData: $0, videosService: self.dependency.videosService, authorsService: self.dependency.authorsService)) }

                return ConferenceDetailSectionModel(items: videoSectionDataModels)
            }
            .done { [weak self] sectionModel in
                self?.conferenceEditions.accept(sectionModel)
            }
            .catch { [weak self] error in
                self?.toogleStateView.on(.next(StandardStateViewContext(headline: error.localizedDescription)))
            }
    }

    func sectionTitle(for sectionIndex: Int) -> String? {
        guard sectionIndex < conferenceEditions.value.count else {
            fatalError("index is out of bound")
        }

        let sectionModel = conferenceEditions.value[sectionIndex].items.first!
        switch sectionModel {
            case .video(let videoViewModel):
                return videoViewModel.conferenceEditionYear.asString
            default:
                return nil
        }
    }
}
