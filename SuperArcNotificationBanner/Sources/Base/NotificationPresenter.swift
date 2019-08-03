//
//  Copyright © 2019 An Tran. All rights reserved.
//

import NotificationBanner

public final class NotificationPresenter: NotificationSink {

    // MARK: Properties

    // Private

    private var currentBanner: GrowingNotificationBanner?
    private let notificationQueue = NotificationBannerQueue()

    // MARK: Initialization

    public init() {}

    // MARK: APIs

    public func showNotification(_ notification: Notification, source: NotificationSource?, context: NotificationContext) {

        currentBanner = makeBanner(for: notification)
        currentBanner?.show()
    }

    public func clearNotifications() {
        currentBanner?.dismiss()
    }

    // MARK: Private helpers

    private func makeBanner(for notification: Notification) -> GrowingNotificationBanner? {

        guard notification.style != .silent else {
            return nil
        }

        var title = ""
        var subtitle = ""
        let style = notification.style.toBannerStyle()

        switch notification.type {
        case .text(let message):
            title = message
        case .error(let error):
            title = "Error"
            subtitle = error.localizedDescription
        }
        

        return GrowingNotificationBanner(title: title, subtitle: subtitle, leftView: nil, rightView: nil, style: style, colors: nil)

    }
}

extension NotificationStyle {

    func toBannerStyle() -> BannerStyle {
        switch self {
        case .error:
            return .danger
        case .info:
            return .info
        case .hint:
            return .info
        case .success:
            return .success
        case .debug:
            return .info
        case .silent:
            return .info
        }
    }
}
