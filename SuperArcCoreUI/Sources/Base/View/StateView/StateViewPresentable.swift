//
//  Copyright © 2019 An Tran. All rights reserved.
//

import UIKit

// MAKR: - StateViewContext

public protocol StateViewContext {
    var headline: String { get }
    var subline: String? { get }
}

public struct StandardStateViewContext: StateViewContext {
    public var headline: String
    public var subline: String?

    public init(headline: String, subline: String?) {
        self.headline = headline
        self.subline = subline
    }
}

// MARK: - StateViewDisplayable

public protocol StateViewDisplayable {
    func showStateView()
    func hideStateView()

    func makeStateView() -> UIView
    func setStateView(_ view: UIView?)
}

// MARK: - Default implementations

extension StateViewDisplayable {

    public func showStateView() {
        hideStateView()
        setStateView(makeStateView())
    }

    public func hideStateView() {
        setStateView(nil)
    }

    public func makeStateView() -> UIView {
        return StateView()
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
