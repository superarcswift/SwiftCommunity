//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import RxSwift
import UIKit

/// The base class for all UIViewControllers.
open class ViewController: UIViewController, CommonViewControllerProtocol {


    // MARK: Properties

    // Public

    public var context: ViewControllerContextProtocol!
    public var storedViewModel: ViewModel!

    // IBInspectable

    @IBInspectable open var hasRightCloseButton: Bool = false
    @IBInspectable open var hasLeftCloseButton: Bool = false
    @IBInspectable open var prefersLargeTitles: Bool = true

    // MARK: Lifecycles

    open override func viewDidLoad() {
        super.viewDidLoad()
        commonViewDidLoad()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        commonViewWillAppear()
    }

    // MARK: Setup

    open func setupViewModel() -> ViewModel! {
        return nil
    }

    /// Setup ViewController after loading.
    open func setupViews() {
        commonSetupView()
    }

    open func setupBindings() {}

    open func loadData() {}
}
