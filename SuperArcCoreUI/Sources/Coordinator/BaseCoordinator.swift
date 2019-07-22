//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import SuperArcFoundation
import RxSwift

open class BaseCoordinator<ResultType>: ClassNameDerivable {

    // MARK: Properties

    // Public

    public var viewControllerContext: ViewControllerContextProtocol
    public var rootViewController: NavigationController?

    /// Utility `DisposeBag` used by the subclasses.
    public let disposeBag = DisposeBag()

    // Private

    private var childCoordinators = [String: Any]()

    // MARK: Initialization

    public init(viewControllerContext: ViewControllerContextProtocol) {
        self.viewControllerContext = viewControllerContext
    }

    // MARK: APIs

    /// 1. Stores coordinator in a dictionary of child coordinators.
    /// 2. Calls method `start()` on that coordinator.
    /// 3. On the `onNext:` of returning observable of method `start()` removes coordinator from the dictionary.
    ///
    /// - Parameter coordinator: Coordinator to start.
    /// - Returns: Result of `start()` method.
    public func coordinate<T>(to coordinator: BaseCoordinator<T>) -> Observable<T> {
        store(coordinator)
        return coordinator.start()
            .do(onNext: { [weak self, weak coordinator] _ in
                self?.free(coordinator)
            })
    }

    /// Starts the coordinator
    ///
    /// - Returns: Result of coordinator.
    open func start() -> Observable<ResultType> {
        fatalError("Start method should be implmented by subclasses")
    }

    public func store<T>(_ coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.className] = coordinator
    }

    public func free<T>(_ coordinator: BaseCoordinator<T>?) {
        guard let coordinator = coordinator else {
            return
        }
        childCoordinators[coordinator.className] = nil
    }

    public func childCoordinator<T>(with key: String) -> BaseCoordinator<T>? {
        return childCoordinators[key] as? BaseCoordinator<T>
    }
}
