//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation
import UIKit
import MarkdownView
import PromiseKit

class MarkdownContentTableViewCell: UITableViewCell, ClassNameDerivable {

    @IBOutlet weak var mainContentView: MarkdownView!
    @IBOutlet weak var mainContentViewHeightConstraint: NSLayoutConstraint!

    var onRendered: (() -> Void)?

    var contentViewModel: ContentViewModel? {
        didSet {
            guard let contentViewModel = contentViewModel else {
                return
            }

            mainContentView.isScrollEnabled = false
            mainContentView.onRendered = { [unowned self] num in
                self.mainContentViewHeightConstraint.constant = num
                self.mainContentViewHeightConstraint.isActive = true
                self.onRendered?()
            }

            contentViewModel.load()
                .done { [weak self] stringContent in
                    self?.mainContentView.load(markdown: stringContent)
                }
                .catch { error in
                    print(error)
                }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        contentViewModel = nil
        mainContentView.load(markdown: nil)
        mainContentViewHeightConstraint.isActive = false
    }
}
