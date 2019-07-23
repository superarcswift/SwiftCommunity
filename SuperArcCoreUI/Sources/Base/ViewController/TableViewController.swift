//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore
import RxSwift
import UIKit

open class TableViewController: UITableViewController, CommonViewControllerProtocol {

    // MARK: Properties

    // Public

    public var context: ViewControllerContextProtocol!
    public var storedViewModel: ViewModel!

    // Private

    private let disposeBag = DisposeBag()

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
