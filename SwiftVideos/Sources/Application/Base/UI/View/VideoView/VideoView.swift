//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcFoundation

@IBDesignable class VideoView: View, ClassNameDerivable, ViewModelBindable {

    // MARK: Properties

    // IBOutlet

    @IBOutlet weak var previewImageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var conferenceTitleLabel: UILabel!

    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!

    // Private

    var viewModel: VideoViewModel! {
        didSet {
            titleLabel.text = viewModel.name
            conferenceTitleLabel.text = viewModel.conferenceName
            authorNameLabel.text = viewModel.authors.first!.name
            authorImageView.image = viewModel.authors.first!.avatarImage
            previewImageView.image = viewModel.previewImage.image
            previewImageView.contentMode = viewModel.previewImage.contentMode
        }
    }

    // MARK: Setup

    override func setup() {
        if let videoView = VideoView.instantiateFromNib(owner: self) {
            videoView.backgroundColor = .clear
            addAndStretchSubView(videoView)
        }
    }

    func setupBindings() {}
}
