//
//  Copyright © 2019 An Tran. All rights reserved.
//

// MARK: Enums

public enum NotificationType {
    case error(error: Error)
    case text(message: String)
}

public enum NotificationStyle {
    case error
    case info
    case hint
    case success
    case debug
    case silent
}

public protocol Notification {
    var type: NotificationType { get }
    var style: NotificationStyle { get }
}

public struct StandardNotification: Notification {

    public let type: NotificationType
    public let style: NotificationStyle

    public init(error: Error) {
        type = .error(error: error)
        style = .error
    }

    public init(message: String, style: NotificationStyle) {
        type = .text(message: message)
        self.style = style
    }
}
