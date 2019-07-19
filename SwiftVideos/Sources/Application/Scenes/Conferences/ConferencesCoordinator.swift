//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import RxSwift

class ConferencesCoordinator: BaseCoordinator<Void> {

    // MARK: Properties

    private var navigationController: NavigationController

    // MARK: Initialization

    init(navigationController: NavigationController) {
        self.navigationController = navigationController
        super.init(viewControllerContext: navigationController.context)
    }

    // MARK: APIs

    override func start() -> Observable<Void> {
        return Observable.never()
    }
}
