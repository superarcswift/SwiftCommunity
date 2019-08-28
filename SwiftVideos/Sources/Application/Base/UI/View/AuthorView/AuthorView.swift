//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcFoundation
import RxCocoa
import RxSwift

// MARK: - View

@IBDesignable class AuthorView: View, ClassNameDerivable, ViewModelBindable {

    // MARK: Properties

    // IBOutlet

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    // Private

    var viewModel: AuthorViewModel! {
        didSet {
            nameLabel.text = viewModel.name
            avatarImageView.image = viewModel.avatarImage
        }
    }

    // MARK: Overrides

    override func setup() {
        if let authorView = AuthorView.instantiateFromNib(owner: self) {
            authorView.backgroundColor = .clear
            addAndStretchSubView(authorView)
        }
    }

    func setupBindings() {}
}
