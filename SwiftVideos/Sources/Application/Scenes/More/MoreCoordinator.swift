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

    init(context: ApplicationContext) {
        component = MoreComponent(dependency: EmptyComponent(), context: context)
        super.init(initialRoute: .list)
    }

    // MARK: Overrides

    override func prepareTransition(for route: MoreRoute) -> NavigationTransition {
        switch route {
        case .list:
            let viewController = component.makeMoreTableViewController()
            return .push(viewController)

        case .close:
            return .dismissToRoot()
        }
    }

}

enum MoreRoute: Route {
    case list
    case close
}
