//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore

public protocol HasActivitySink {
    var activitySink: ActivitySink { get }
}

extension ViewController: HasActivitySink {
    public var activitySink: ActivitySink {
        return viewControllerContext.resolve(type: ActivityPresenter.self)
    }
}

extension CollectionViewController: HasActivitySink {
    public var activitySink: ActivitySink {
        return viewControllerContext.resolve(type: ActivityPresenter.self)
    }
}

extension TableViewController: HasActivitySink {
    public var activitySink: ActivitySink {
        return viewControllerContext.resolve(type: ActivityPresenter.self)
    }
}
