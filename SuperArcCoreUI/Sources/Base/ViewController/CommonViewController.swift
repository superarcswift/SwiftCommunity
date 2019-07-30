//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore

public protocol CommonViewControllerProtocol: ViewModelBindable, HasViewControllerContext {

    // MARK: Properties

    // ViewModel
    var storedViewModel: ViewModel! { get set }

    // View Configuration
    var prefersLargeTitles: Bool { get }

    // MARK: Lifecycles

    func commonViewDidLoad()
    func commonSetupView()

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

    public func commonSetupView() {
        navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
        if !prefersLargeTitles {
            navigationController?.navigationItem.largeTitleDisplayMode = .never
        }
    }
}
