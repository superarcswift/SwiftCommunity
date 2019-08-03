//
//  Copyright © 2019 An Tran. All rights reserved.
//

#if canImport(RxSwift) && canImport(RxCocoa)

import SuperArcCoreUI
import SuperArcCore
import RxCocoa
import RxSwift

// MARK: - StateViewDisplayable binding

/// Convenience binding to show and hide the state view.
extension Reactive where Base: UIViewController {

    public var notification: Binder<Notification?> {
        return Binder<Notification?>(self.base) { viewController, notification in
            guard let notificationSinkHolder = viewController as? HasNotificationSink else {
                return
            }

            let notificationSink = notificationSinkHolder.notificationSink

            if let notification = notification {
                notificationSink.showNotification(notification, source: nil, context: [:])
            } else {
                notificationSink.clearNotifications()
            }
        }
    }
}

#endif
