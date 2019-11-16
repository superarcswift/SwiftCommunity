//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

/// Protocol providing ability to show/hide activity indicator.
public protocol ActivitySink: class {
    func showActivity()
    func hideActivity()
}
