//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcFoundation
import RxCocoa
import RxSwift

// MARK: - View

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

// MARK: - Binding

extension Reactive where Base: AuthorView {

    var author: Binder<AuthorMetaData> {
        return Binder<AuthorMetaData>(self.base) { authorView, authorMetaData in
            authorView.nameLabel.text = authorMetaData.name
        }
    }
}