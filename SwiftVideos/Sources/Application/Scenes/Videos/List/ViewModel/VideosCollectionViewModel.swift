//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import RxSwift
import RxCocoa

class VideosCollectionViewModel: ViewModel {

    // MARK: Properties

    var videos = BehaviorRelay<[Video]>(value: [])
    var didSelect = PublishSubject<Video>()

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

    func selectAt(_ index: Int) {
        guard index < videos.value.count else {
            print("no element found at \(index)")
            return
        }

        let video = videos.value[index]

        didSelect.on(.next(video))
    }
}

// MARK: - Dependencies

extension VideosCollectionViewModel {

    var videosService: VideosService {
        return engine.serviceRegistry.resolve(type: VideosService.self)
    }
}
