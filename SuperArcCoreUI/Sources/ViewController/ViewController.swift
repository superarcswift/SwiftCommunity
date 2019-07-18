//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import UIKit

open class ViewController: UIViewController, CommonViewControllerProtocol {

    // MARK: Properties

    // Public

    public var context: ViewControllerContextProtocol!
    public var storedViewModel: ViewModel?

    // MARK: Lifecycles

    open override func viewDidLoad() {
        super.viewDidLoad()
        commonViewDidLoad()
    }

    // MARK: Setup

    open func setupViewModel() -> ViewModel! {
        return nil
    }

    open func setupViews() {}

    open func setupBindings() {}

    open func loadData() {}
}
