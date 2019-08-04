//
//  Copyright © 2019 An Tran. All rights reserved.
//

import UIKit

extension UITableView {

    public func registerNib(_ cellClass: UITableViewCell.Type) {
        let identifier = cellClass.className
        registerNib(identifier, bundle: Bundle(for: cellClass))
    }

    public func registerNib(_ identifierAndNibName: String, bundle: Bundle) {
        let nib = UINib(nibName: identifierAndNibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: identifierAndNibName)
    }
}
