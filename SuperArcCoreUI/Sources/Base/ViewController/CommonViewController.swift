//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore

public protocol CommonViewControllerProtocol: HasViewControllerContext, ViewModelBindable {

    // MARK: Properties

    // ViewModel

    var viewModel: ViewModelType! { get set }

    // View Configuration

    var hasRightCloseButton: Bool { get }
    var hasLeftCloseButton: Bool { get }

    var prefersLargeTitles: Bool { get }

    // MARK: Lifecycles

    func commonViewDidLoad()
    func commonViewWillAppear()

    func close()

    // MARK: Setup

    func commonSetupView()

    func setupViews()
    func setupBindings()
    func loadData()
    
}

extension CommonViewControllerProtocol where Self: UIViewController {

    public func commonViewDidLoad() {

        setupViews()

        setupBindings()

        loadData()
    }

    public func commonViewWillAppear() {
        navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
        if !prefersLargeTitles {
            navigationController?.navigationItem.largeTitleDisplayMode = .never
        }
    }

    public func commonSetupView() {}
}
