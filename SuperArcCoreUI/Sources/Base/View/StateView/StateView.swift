//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation
import UIKit

/// Fullscreen state view which can show error/empty state of a view controller.
class StateView: View, ClassNameDerivable {

    // MARK: Properties

    // IBOutlet

    @IBOutlet weak var headlineLabel: UILabel!

    // MARK: Setup

    override func setup() {

        if let stateView = StateView.instantiateFromNib(owner: self) {
            addAndStretchSubView(stateView)
        }
    }
}
