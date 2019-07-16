//
//  Copyright © 2019 An Tran. All rights reserved.
//

import UIKit

extension UICollectionView {

    public func registerNib(_ identifierAndNibName: String, bundle: Bundle) {

        let nib = UINib(nibName: identifierAndNibName, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: identifierAndNibName)
    }
}


