//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcFoundation

@IBDesignable class AuthorView: View, ClassNameDerivable {

    // MARK: Properties

    // IBOutlet

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    // MARK: Overrides
    
    override func setup() {
        if let authorView = AuthorView.instantiateFromNib(owner: self) {
            addAndStretchSubView(authorView)
        }
    }
}
