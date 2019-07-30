//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import UIKit

open class CollectionViewController: UICollectionViewController, CommonViewControllerProtocol {

    // MARK: Properties

    public var context: ViewControllerContextProtocol!
    public var storedViewModel: ViewModel!

    public var prefersLargeTitles: Bool = true

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
