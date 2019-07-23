//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore

public protocol CommonViewControllerProtocol: ViewModelBindable, HasViewControllerContext {

    // MARK: Properties

    var storedViewModel: ViewModel? { get set }

    // MARK: Lifecycles

    func commonViewDidLoad()

    // MARK: Setup

    func setupViewModel() -> ViewModel!
    func setupViews()
    func setupBindings()
    func loadData()
}

extension CommonViewControllerProtocol where Self: UIViewController {

    public func commonViewDidLoad() {

        if storedViewModel == nil {
            storedViewModel = setupViewModel()
        }

        setupViews()

        setupBindings()

        loadData()
    }
}
