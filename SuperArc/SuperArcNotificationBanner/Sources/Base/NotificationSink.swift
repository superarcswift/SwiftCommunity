//
//  Copyright © 2019 An Tran. All rights reserved.
//

public typealias NotificationContext = [String: String]

public protocol NotificationSource: class {}

public protocol NotificationSink {
    func showNotification(_ notification: Notification, source: NotificationSource?, context: NotificationContext)
    func clearNotifications()
}

public protocol NotificationSinkList {
    var sinks: [NotificationSink] { get }
    var context: NotificationContext { get }
}

public class StandardNotificationSinkList: NotificationSinkList, NotificationSink {

    // MARK: Properties

    public let sinks: [NotificationSink]
    public let context: NotificationContext

    // MARK: Initialization

    public init(sinks: [NotificationSink], context: NotificationContext = [:]) {
        self.sinks = sinks
        self.context = context
    }

    // MARK: APIs

    public func showNotification(_ notification: Notification, source: NotificationSource?, context: NotificationContext) {
        sinks.forEach { sink in
            sink.showNotification(notification, source: source, context: context)
        }
    }

    public func clearNotifications() {
        sinks.forEach { sink in
            sink.clearNotifications()
        }
    }

    // MARK: Helpers

    private func extendContext(with context: NotificationContext) -> NotificationContext {
        var extendedContext = self.context
        for (key, value) in context {
            extendedContext[key] = value
        }

        return extendedContext
    }
}
