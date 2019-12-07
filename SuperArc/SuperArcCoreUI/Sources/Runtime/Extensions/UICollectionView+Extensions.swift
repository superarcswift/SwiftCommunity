//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation
import UIKit

extension UICollectionView {

    public func registerNib(_ cellClass: UICollectionViewCell.Type) {
        let identifier = cellClass.className
        registerNib(identifier, bundle: Bundle(for: cellClass))
    }

    public func registerNib(_ identifierAndNibName: String, bundle: Bundle) {
        let nib = UINib(nibName: identifierAndNibName, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: identifierAndNibName)
    }

    public func registerReusableView(_ viewClass: UICollectionReusableView.Type, forSupplementaryViewOfKind kind: String) {
        let identifier = viewClass.className
        registerReusableView(identifier, bundle: Bundle(for: viewClass), forSupplementaryViewOfKind: kind)
    }

    public func registerReusableView(_ identifierAndNibName: String, bundle: Bundle, forSupplementaryViewOfKind kind: String) {
        let nib = UINib(nibName: identifierAndNibName, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifierAndNibName)
    }

    public func dequeueReusableCell<T: UICollectionViewCell & ClassNameDerivable>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellClass.className, for: indexPath) as? T else {
            fatalError("invalid type cell")
        }

        return cell
    }

}
