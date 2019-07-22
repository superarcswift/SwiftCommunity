//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import SuperArcFoundation
import UIKit

class ConferencesDetailViewController: ViewController, StoryboardInitiable {

    // MARK: Properties

    // Static
    static var storyboardName = "Conferences"

    // IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!

    var viewModel: ConferencesDetailViewModel {
        return storedViewModel as! ConferencesDetailViewModel
    }

    // MARK: Lifecycles

    override func setupViewModel() -> ViewModel! {
        return ConferencesDetailViewModel(engine: context.engine)
    }
}

