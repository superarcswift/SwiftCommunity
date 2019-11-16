//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore

public protocol HasNotificationSink {
    var notificationSink: NotificationSink { get }
}

extension ViewController: HasNotificationSink {
    public var notificationSink: NotificationSink {
        return viewControllerContext.resolve(type: NotificationPresenter.self)
    }
}

extension CollectionViewController: HasNotificationSink {
    public var notificationSink: NotificationSink {
        return viewControllerContext.resolve(type: NotificationPresenter.self)
    }
}

extension TableViewController: HasNotificationSink {
    public var notificationSink: NotificationSink {
        return viewControllerContext.resolve(type: NotificationPresenter.self)
    }
}
