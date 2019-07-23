//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import UIKit

class ConferenceDetailViewController: ViewController, StoryboardInitiable {

    // MARK: Properties

    // Static

    static var storyboardName = "Conferences"

    // IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!

    // Private

    var viewModel: ConferenceDetailViewModel {
        return storedViewModel as! ConferenceDetailViewModel
    }
}

