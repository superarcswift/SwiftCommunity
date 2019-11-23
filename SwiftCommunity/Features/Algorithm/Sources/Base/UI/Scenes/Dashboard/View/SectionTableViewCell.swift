//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation
import UIKit

class SectionTableViewCell: UITableViewCell, ClassNameDerivable {

    @IBOutlet weak var titleLabel: UILabel!

    var section: Section? {
        didSet {
            titleLabel.text = section?.title
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        section = nil
    }
}
