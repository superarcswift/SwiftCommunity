//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCoordinator
import SuperArcCoreUI
import SuperArcCore
import RxSwift
import UIKit

class DashboardCoordinator: TabBarCoordinator<DashboardRoute> {

    // MARK: Properties

    // Private

    private let conferencesRouter: AnyRouter<ConferencesRoute>

    // MARK: Initialization

    convenience init() {
        let conferencesCoordinator = ConferencesCoordinator()
        self.init(conferencesRouter: conferencesCoordinator.anyRouter)
    }

    init(conferencesRouter: AnyRouter<ConferencesRoute>) {
        self.conferencesRouter = conferencesRouter

        super.init(tabs: [conferencesRouter], select: conferencesRouter)
    }

    // MARK: Overrides

    override func prepareTransition(for route: DashboardRoute) -> TabBarTransition {
        switch route {
        case .conferences:
            return .select(conferencesRouter)
        }
    }

}

enum DashboardRoute: Route {
    case conferences
//    case videos
//    case authors
//    case more
}
