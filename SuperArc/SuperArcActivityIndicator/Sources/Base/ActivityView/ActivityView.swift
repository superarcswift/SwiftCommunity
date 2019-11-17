//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcFoundation
import UIKit

class ActivityView: View, ClassNameDerivable {

    // MARK: Properties

    // IBOutlet

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var backgroundView: UIView!

    // MARK: Setup

    override func setup() {
        if let acitivityView = ActivityView.instantiateFromNib(owner: self) {
            addAndStretchSubView(acitivityView)
            backgroundView.cornerRadius = 7.0
            activityIndicatorView.startAnimating()
        }
    }

    // MARK: APIs

    class func showInView(_ view: UIView, animated: Bool, style: ActivityViewStyle) -> ActivityView {
        let activityView = ActivityView(frame: view.frame)
        activityView.backgroundColor = style.backdropColor
        activityView.backgroundView.backgroundColor = style.backgroundColor
        activityView.activityIndicatorView.color = style.spinnerColor

        view.addSubview(activityView)

        activityView.alpha = 0.0
        UIView.animate(withDuration: animated ? 0.5: 0) {
            activityView.alpha = 1.0
        }

        return activityView
    }

    class func showInMainWindow(_ animated: Bool, style: ActivityViewStyle) -> ActivityView {
        guard let mainWindow = UIApplication.shared.keyWindow else {
            fatalError("no key windows found")
        }

        return showInView(mainWindow, animated: animated, style: style)
    }

    func hide(_ animated: Bool) {
        activityIndicatorView.stopAnimating()

        UIView.animate(
            withDuration: animated ? 0.5 : 0,
            animations: {
                self.alpha = 0.0
            },
            completion: { _ in
                self.removeFromSuperview()
            }
        )
    }
}
