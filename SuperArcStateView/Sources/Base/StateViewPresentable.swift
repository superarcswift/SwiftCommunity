//
//  Copyright © 2019 An Tran. All rights reserved.
//

import UIKit

// MARK: - StateViewDisplayable

public protocol StateViewDisplayable {
    func showStateView(_ context: StateViewContext)
    func hideStateView()

    func makeStateView(_ context: StateViewContext) -> UIView
    func setStateView(_ view: UIView?)
}

// MARK: - Default implementations

extension StateViewDisplayable {

    public func showStateView(_ context: StateViewContext) {
        hideStateView()
        setStateView(makeStateView(context))
    }

    public func hideStateView() {
        setStateView(nil)
    }

    public func makeStateView(_ context: StateViewContext) -> UIView {
        let stateView = StateView()
        stateView.headlineLabel.text = context.headline

        return stateView
    }
}

// MARK: - StateViewDisplayable Views

extension StateViewDisplayable where Self: UICollectionView {

    public func setStateView(_ view: UIView?) {
        backgroundView = view
    }
}

extension StateViewDisplayable where Self: UITableView {

    public func setStateView(_ view: UIView?) {
        backgroundView = view
    }
}

extension StateViewDisplayable where Self: UIViewController {

    public func setStateView(_ view: UIView?) {
        self.view?.setStateView(view)
    }
}

extension UIView: StateViewDisplayable {

    public func setStateView(_ view: UIView?) {
        let tag = 1000

        if let view = view {
            view.frame = bounds
            view.tag = tag
            view.isUserInteractionEnabled = false

            addAndStretchSubView(view)
        } else {
            if let view = viewWithTag(tag) {
                view.removeFromSuperview()
            }
        }
    }
}
