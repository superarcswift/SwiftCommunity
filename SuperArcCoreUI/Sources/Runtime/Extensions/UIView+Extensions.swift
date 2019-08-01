//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation
import UIKit

// MARK: - Properties

public extension UIView {

    ///     Border color of view.
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            layer.borderColor = color.cgColor
        }
    }

    /// Border width of view.
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    /// Corner radius of view.
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }

    /// Shadow color of view.
    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }

    /// Shadow offset of view.
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    /// Shadow opacity of view. also inspectable from Storyboard.
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    /// Shadow radius of view.
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
}

// MARK: - Methods

public extension UIView {

    /// Add a subview and stretch the subview to cover the current view.
    func addAndStretchSubView(_ subView: UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subView)
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: topAnchor),
            subView.leftAnchor.constraint(equalTo: leftAnchor),
            subView.rightAnchor.constraint(equalTo: rightAnchor),
            subView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

public extension ClassNameDerivable where Self: UIView {

    /// Instantiate a view from its nib.
    static func instantiateFromNib<ViewClass: UIView>(owner: AnyObject? = nil) -> ViewClass? {
        guard let nibName = self.className.components(separatedBy: ".").last else {
            return nil
        }

        let nib = UINib(nibName: nibName, bundle: Bundle(for: self))
        return nib.instantiate(withOwner: owner, options: nil).first as? ViewClass
    }
}

