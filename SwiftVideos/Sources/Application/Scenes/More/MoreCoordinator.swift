//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import XCoordinator
import RxSwift

class MoreCoordinator: NavigationCoordinator<MoreRoute> {

    // MARK: Properties

    // Private

    private var component: MoreComponent

    // MARK: Initialization

    init(dependency: MoreDependency, context: ApplicationContext) {
        component = MoreComponent(dependency: dependency, context: context)
        super.init(initialRoute: .list)
    }

    // MARK: Overrides

    override func prepareTransition(for route: MoreRoute) -> NavigationTransition {
        switch route {
        case .list:
            let viewController = component.makeMoreTableViewController(router: anyRouter)
            return .push(viewController)

        case .about:
            let viewController = component.makeAboutViewController(router: anyRouter)
            return .push(viewController)

        case .license:
            //let viewController = component.makeLicensesViewController(router: anyRouter)
            //return .push(viewController)
            fatalError("should not used")

        case .reset:
            return .dismiss()
        }
    }

}

enum MoreRoute: Route {
    case list
    case about
    case license
    case reset
}
