//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import UIKit

class ConferencesDetailViewController: ViewController {
    
    @IBOutlet weak var titleLabel: UILabel!

    var viewModel: ConferencesDetailViewModel {
        return storedViewModel as! ConferencesDetailViewModel
    }

    override func setupViewModel() -> ViewModel! {
        return ConferencesDetailViewModel(engine: context.engine)
    }
}

