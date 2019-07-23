//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCoordinator
import SuperArcCoreUI
import SuperArcCore

class DashboardViewModel: ViewModel {

    // MARK: Properties

    // Private

    private let router: AnyRouter<AppRoute>

    init(router: AnyRouter<AppRoute>, engine: Engine) {
        self.router = router
        super.init(engine: engine)
    }

}
