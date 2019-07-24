//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import XCoordinator
import Action
import RxSwift
import RxCocoa

class VideosCollectionViewModel: ViewModel {

    // MARK: Properties

    private let router: AnyRouter<VideosRoute>
    private lazy var showVideoAction = Action<Video, Void> { [unowned self] video in
        self.router.rx.trigger(.videoDetail(video))
    }

    // Public

    lazy var didSelectVideo: AnyObserver<Video> = showVideoAction.inputs
    var videos = BehaviorRelay<[Video]>(value: [])

    // MARK: Initialization

    init(router: AnyRouter<VideosRoute>, engine: Engine) {
        self.router = router
        super.init(engine: engine)
    }

    // MARK: APIs

    func loadData() {
        videosService.fetch()
            .done { [weak self] videos in
                self?.videos.accept(videos)
            }
            .catch { error in
                print(error)
        }
    }
}

// MARK: - Dependencies

extension VideosCollectionViewModel {

    var videosService: VideosService {
        return engine.serviceRegistry.resolve(type: VideosService.self)
    }
}
