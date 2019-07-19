//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import RxSwift

class VideosCoordinator: BaseCoordinator<Void> {

    override func start() -> Observable<Void> {
        return Observable.just(())
    }
}
