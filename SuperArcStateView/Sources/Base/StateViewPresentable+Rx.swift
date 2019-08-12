//
//  Copyright © 2019 An Tran. All rights reserved.
//

#if canImport(RxCocoa) && canImport(RxSwift)

import SuperArcCoreUI
import RxCocoa
import RxSwift

// MARK: - StateViewDisplayable binding

/// Convenience binding to show and hide the state view.
extension Reactive where Base: UIViewController {

    public var toogleStateView: Binder<StandardStateViewContext?> {
        return Binder<StandardStateViewContext?>(self.base) { viewController, stateViewContext in
            guard let stateViewPresentable = viewController as? StateViewDisplayable else {
                return
            }

            stateViewContext.isEmpty ? stateViewPresentable.showStateView(stateViewContext!) : stateViewPresentable.hideStateView()
        }
    }
}

// MARK: - Optional extension

extension Optional where Wrapped: StateViewContext {

    public var isEmpty: Bool {
        switch self {
        case .some:
            return true
        case .none:
            return false
        }
    }
}

#endif
