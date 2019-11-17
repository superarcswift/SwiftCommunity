//
//  Copyright © 2019 An Tran. All rights reserved.
//

#if canImport(RxSwift) && canImport(RxCocoa)

import SuperArcCoreUI
import SuperArcCore
import RxCocoa
import RxSwift

// MARK: - Activity binding

/// Convenience binding to show and hide the activity indicator.
extension Reactive where Base: UIViewController {

    public var activity: Binder<Bool> {
        return Binder<Bool>(self.base) { viewController, isBusy in
            guard let activitySinkHolder = viewController as? HasActivitySink else {
                return
            }

            let activitySink = activitySinkHolder.activitySink

            isBusy ? activitySink.showActivity(in: self.base.view) : activitySink.hideActivity()
        }
    }
}

#endif
