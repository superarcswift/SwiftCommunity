//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import UIKit

open class PageViewController: UIPageViewController, CommonViewControllerProtocol {

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
