//
//  Copyright © 2019 An Tran. All rights reserved.
//

import UIKit

/// Unified template to initialize an UIView.
open class View: UIView {

    // MARK: Initialization

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: APIs

    open func setup() {
        fatalError("needed to be subclassed")
    }
}
