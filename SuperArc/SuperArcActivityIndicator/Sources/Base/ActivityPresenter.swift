//
//  Copyright © 2019 An Tran. All rights reserved.
//

import UIKit

public class ActivityPresenter: ActivitySink {

    // MARK: Properties

    // Private

    private let animated: Bool
    private let style: ActivityViewStyle

    private var activityView: ActivityView?

    // MARK: Initialization

    public init(animated: Bool = false, style: ActivityViewStyle = .standard) {
        self.animated = animated
        self.style = style
    }

    // MARK: APIs

    public func showActivity(in view: UIView? = nil) {
        if let view = view {
            activityView = ActivityView.showInView(view, animated: animated, style: style)
        } else {
            activityView = ActivityView.showInMainWindow(animated, style: style)
        }
    }

    public func hideActivity() {
        activityView?.hide(animated)
        activityView = nil
    }
}
