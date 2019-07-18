//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import SuperArcFoundation
import RxSwift

open class BaseCoordinator<ResultType>: ClassNameDerivable {

    // MARK: Properties

    // Public

    // Internal

    public var viewControllerContext: ViewControllerContextProtocol

    /// Utility `DisposeBag` used by the subclasses.
    let disposeBag = DisposeBag()

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
        store(coordinator: coordinator)
        return coordinator.start()
            .do(onNext: { [weak self] _ in
                self?.free(coordinator: coordinator)
            })
    }

    /// Starts the coordinator
    ///
    /// - Returns: Result of coordinator.
    open func start() -> Observable<ResultType> {
        fatalError("Start method should be implmented by subclasses")
    }

    // MARK: Private helpers

    private func store<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[name] = coordinator
    }

    private func free<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[name] = nil
    }
}
