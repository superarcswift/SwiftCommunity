//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

public protocol CommonViewController: HasViewControllerContext {

    var storedViewModel: ViewModel? { get set }

    func setupViewModel() -> ViewModel!
    func setupViews()
    func setupBindings()
    func loadData()

    func commonViewDidLoad()
}

extension CommonViewController where Self: UIViewController {

    public func commonViewDidLoad() {
        if storedViewModel == nil {
            storedViewModel = setupViewModel()
        }

        setupViews()

        setupBindings()

        loadData()
    }

    public func setupViewModel() -> ViewModel! {
        return nil
    }

    public func setupViews() {
    }

    public func setupBindings() {
    }

    public func loadData() {
    }

}
