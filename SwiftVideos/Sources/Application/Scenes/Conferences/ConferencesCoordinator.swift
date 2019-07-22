//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import RxSwift

class ConferencesCoordinator: BaseCoordinator<Void> {

    // MARK: Properties

    // MARK: Initialization

    init(rootViewController: NavigationController) {
        super.init(viewControllerContext: rootViewController.context)
        self.rootViewController = rootViewController
    }

    // MARK: APIs

    override func start() -> Observable<Void> {
        return Observable.never()
    }
}
