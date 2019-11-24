//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation
import UIKit
import MarkdownView

class MarkdownContentTableViewCell: UITableViewCell, ClassNameDerivable {

    @IBOutlet weak var mainContentView: MarkdownView!
    @IBOutlet weak var mainContentViewHeightConstraint: NSLayoutConstraint!

    var onRendered: (() -> Void)?

    var content: Content? {
        didSet {
            guard let content = content else {
                return
            }

            let description = load(content)
            mainContentView.load(markdown: description)
            mainContentView.isScrollEnabled = false
            mainContentView.onRendered = { [unowned self] num in
                self.mainContentViewHeightConstraint.constant = num
                self.mainContentViewHeightConstraint.isActive = true
                self.onRendered?()
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        content = nil
        mainContentView.load(markdown: nil)
        mainContentViewHeightConstraint.isActive = false
    }

    // MARK: Private helpers

    private func load(_ content: Content) -> String? {
        switch content {
            case .local(_, let value):
                return value
            case .url(_, let value):
                let url = URL(string: value)!
                let data = try! Data(contentsOf: url)
                return String(data: data, encoding: .utf8)
        }
    }
}
