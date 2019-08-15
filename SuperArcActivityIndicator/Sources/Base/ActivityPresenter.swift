//
//  Copyright © 2019 An Tran. All rights reserved.
//

import UIKit

public class ActivityPresenter: ActivitySink {

    // MARK: Properties

    // Private

    private let view: UIView?
    private let animated: Bool
    private let style: ActivityViewStyle

    private var activityView: ActivityView?

    // MARK: Initialization

    public init(view: UIView? = nil, animated: Bool = false, style: ActivityViewStyle = ActivityViewStyle.standard) {
        self.view = view
        self.animated = animated
        self.style = style
    }

    // MARK: APIs

    public func showActivity() {
        if let view = view {
            activityView = ActivityView.showInView(view, animated: animated, style: style)
        } else {
            activityView = ActivityView.showInMainWindow(animated, style: style)
        }
    }

    public func hideActivity() {
        activityView?.hide(animated)
    }
}
