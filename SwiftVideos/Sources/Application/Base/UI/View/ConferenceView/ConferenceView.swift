//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcFoundation

@IBDesignable class ConferenceView: View, ClassNameDerivable, ViewModelBindable {

    // MARK: Properties

    // IBOutlet

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var backgroundView: UIView!

    // Private

    var viewModel: ConferenceViewModel! {
        didSet {
            titleLabel.text = viewModel.name
            previewImageView.image = viewModel.bannerImage
        }
    }

    // MARK: Setup

    override func setup() {
        if let conferenceView = ConferenceView.instantiateFromNib(owner: self) {
            addAndStretchSubView(conferenceView)
        }
    }

    func setupBindings() {}
}
