//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation
import UIKit

extension UITableView {

    public func registerNib<T: UITableViewCell & ClassNameDerivable>(_ cellClass: T.Type) {
        let identifier = cellClass.className
        registerNib(identifier, bundle: Bundle(for: cellClass))
    }

    public func registerNib(_ identifierAndNibName: String, bundle: Bundle) {
        let nib = UINib(nibName: identifierAndNibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: identifierAndNibName)
    }

    public func dequeueReusableCell<T: UITableViewCell & ClassNameDerivable>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellClass.className, for: indexPath) as? T else {
            fatalError("invalid type cell")
        }

        return cell
    }
}
