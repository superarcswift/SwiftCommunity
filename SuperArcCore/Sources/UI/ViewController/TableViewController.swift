//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RxSwift
import UIKit

open class TableViewController: UITableViewController, CommonViewControllerProtocol {

    // MARK: Properties

    // Public

    public var context: ViewControllerContext!
    public var storedViewModel: ViewModel?

    // Private

    private let disposeBag = DisposeBag()

    // MARK: Lifecycles

    open override func viewDidLoad() {
        super.viewDidLoad()
        commonViewDidLoad()
    }

    // MARK: Setup

    public func setupViewModel() -> ViewModel! {
        return nil
    }

    public func setupViews() {}

    public func setupBindings() {}

    public func loadData() {}
}
