//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import RxSwift

class AuthorsCoordinator: BaseCoordinator<Void> {

    override func start() -> Observable<Void> {
        return Observable.just(())
    }
}
