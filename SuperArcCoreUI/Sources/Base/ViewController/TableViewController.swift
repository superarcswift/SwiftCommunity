//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import UIKit

open class TableViewController<VM: ViewModel>: UITableViewController, CommonViewControllerProtocol {

    // MARK: Properties

    // Public

    public var viewControllerContext: ViewControllerContext!
    public var viewModel: VM!

    // IBInspectable

    @IBInspectable public var hasRightCloseButton: Bool = false
    @IBInspectable public var hasLeftCloseButton: Bool = false
    @IBInspectable public var prefersLargeTitles: Bool = false

    // Private

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

    /// Setup ViewController after loading.
    open func setupViews() {
        commonSetupView()

        if hasLeftCloseButton {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(self.close))
        }

        if hasRightCloseButton {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(self.close))
        }
    }
    
    open func setupBindings() {}

    open func loadData() {}
}
