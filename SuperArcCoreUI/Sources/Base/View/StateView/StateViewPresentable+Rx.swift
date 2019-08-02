//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RxCocoa
import RxSwift

// MARK: - StateViewDisplayable binding

/// Convenience binding to show and hide the state view.
extension Reactive where Base: UIViewController {

    public var isEmpty: Binder<Bool> {
        return Binder<Bool>(self.base) { viewController, isEmpty in
            guard let stateViewPresentable = viewController as? StateViewDisplayable else {
                return
            }

            isEmpty ? stateViewPresentable.showStateView() : stateViewPresentable.hideStateView()
        }
    }
}

// MARK: - StateViewBindingValue

protocol StateViewBindingValue {
    var isEmpty: Bool { get }
}

extension Optional: StateViewBindingValue where Wrapped: StateViewContext {

    public var isEmpty: Bool {
        switch self {
        case .some:
            return true
        case .none:
            return false
        }
    }
}
