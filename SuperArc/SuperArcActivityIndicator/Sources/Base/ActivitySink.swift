//
//  Copyright © 2019 An Tran. All rights reserved.
//

/// Protocol providing ability to show/hide activity indicator.
public protocol ActivitySink: class {
    func showActivity(in view: UIView?)
    func hideActivity()
}
