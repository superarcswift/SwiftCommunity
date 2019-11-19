//
//  Copyright © 2019 An Tran. All rights reserved.
//

import CoreUX
import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore

class AboutViewModel: ViewModel, MarkdownViewModelProtocol {

    var resourceURL: URL? {
        get {
            guard let path = Bundle.main.path(forResource: "README", ofType: "md") else {
                return nil
            }

            return URL(fileURLWithPath: path)
        }
        // swiftlint:disable:next unused_setter_value
        set {
            // Do nothing
        }
    }
}
