//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import UIKit

open class CollectionViewController<VM: ViewModel>: UICollectionViewController, CommonViewControllerProtocol {

    // MARK: Properties

    public var context: ApplicationContext!
    public var viewModel: VM!

    @IBInspectable public var hasRightCloseButton = false
    @IBInspectable public var hasLeftCloseButton = false
    @IBInspectable public var prefersLargeTitles = false

    // MARK: Lifecycles

    open override func viewDidLoad() {
        super.viewDidLoad()
        commonViewDidLoad()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        commonViewWillAppear()
    }

    @objc open func close() {
        dismiss(animated: true, completion: nil)
    }

    // MARK: Setup

    open func setupViewModel() -> VM! {
        return nil
    }

    open func setupViews() {}

    open func setupBindings() {}

    open func loadData() {}
    
}
