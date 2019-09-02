//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcFoundation
import RxCocoa
import RxSwift

// MARK: - View

@IBDesignable public class AuthorView: View, ClassNameDerivable, ViewModelBindable {

    // MARK: Properties

    // IBOutlet

    @IBOutlet public weak var avatarImageView: UIImageView!
    @IBOutlet public weak var nameLabel: UILabel!

    // Public

    public var viewModel: AuthorViewModel! {
        didSet {
            nameLabel.text = viewModel.name
            avatarImageView.image = viewModel.avatarImage
        }
    }

    // MARK: Overrides

    override public func setup() {
        if let authorView = AuthorView.instantiateFromNib(owner: self) {
            authorView.backgroundColor = .clear
            addAndStretchSubView(authorView)
        }
    }

    public func setupBindings() {}
}
