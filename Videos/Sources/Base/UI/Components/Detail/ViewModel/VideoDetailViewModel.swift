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

protocol VideoDetailViewModelInput {
    var videoMetaData: VideoMetaData { get }
}

protocol VideoDetailViewModelOutput {
    var videoDetail: BehaviorRelay<VideoDetail?> { get set }
    var authorViewModel: BehaviorRelay<AuthorViewModel?> { get set }
    var previewVideoImage: BehaviorRelay<UIImage?> { get set }
}

protocol VideoDetailViewModelApi {
    func loadData()
}

protocol VideoDetailViewModelType {
    var inputs: VideoDetailViewModelInput { get }
    var outputs: VideoDetailViewModelOutput { get }
    var apis: VideoDetailViewModelApi { get }
}

extension VideoDetailViewModelType where Self: VideoDetailViewModelInput & VideoDetailViewModelOutput & VideoDetailViewModelApi {

    var inputs: VideoDetailViewModelInput {
        return self
    }

    var outputs: VideoDetailViewModelOutput {
        return self
    }

    var apis: VideoDetailViewModelApi {
        return self
    }
}

class VideoDetailViewModel: CoordinatedDIViewModel<VideosRoute, VideosDependency>, VideoDetailViewModelType, VideoDetailViewModelInput, VideoDetailViewModelOutput, VideoDetailViewModelApi {

    // MARK: Properties

    // Public

    var videoDetail = BehaviorRelay<VideoDetail?>(value: nil)
    var authorViewModel = BehaviorRelay<AuthorViewModel?>(value: nil)
    var previewVideoImage = BehaviorRelay<UIImage?>(value: nil)

    var toogleStateView = PublishSubject<StandardStateViewContext?>()
    var notification = PublishSubject<SuperArcNotificationBanner.Notification?>()

    // Internal

    var videoMetaData: VideoMetaData

    // Private

    // MARK: Initialization

    init(router: AnyRouter<VideosRoute>, dependency: VideosDependency, videoMetaData: VideoMetaData) {
        self.videoMetaData = videoMetaData
        super.init(router: router, dependency: dependency)
    }

    // MARK: APIs

    func loadData() {
        fetchVideoDetail()
        fetchPreviewImage()
    }

    // MARK: Private helpers

    private func fetchVideoDetail() {
        dependency.videosService.fetchVideo(metaData: videoMetaData)
            .done { [weak self] videoDetail in
                guard let self = self else { return }
                self.videoDetail.accept(videoDetail)
                self.authorViewModel.accept(AuthorViewModel(authorMetaData: videoDetail.metaData.authors.first!, authorsService: self.dependency.authorsService))
            }
            .catch { [weak self] _ in
                guard let self = self else { return }

                let fallbackVideoDetail = VideoDetail(metaData: self.videoMetaData, description: nil, resources: nil)
                self.videoDetail.accept(fallbackVideoDetail)
                self.authorViewModel.accept(AuthorViewModel(authorMetaData: self.videoMetaData.authors.first!, authorsService: self.dependency.authorsService))

            }
    }

    private func fetchPreviewImage() {
        guard let previewImageURL = dependency.videosService.previewImageURL(for: videoMetaData) else {
            return
        }

        guard let previewImage = UIImage(contentsOfFile: previewImageURL.path) else {
            return
        }

        previewVideoImage.accept(previewImage)
    }
}
