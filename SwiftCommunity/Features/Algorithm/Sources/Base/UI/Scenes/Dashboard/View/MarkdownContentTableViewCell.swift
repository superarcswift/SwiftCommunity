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

    var content: Content? {
        didSet {
            guard let content = content else {
                return
            }

            mainContentView.isScrollEnabled = false
            mainContentView.onRendered = { [unowned self] num in
                self.mainContentViewHeightConstraint.constant = num
                self.mainContentViewHeightConstraint.isActive = true
                self.onRendered?()
            }

            load(content)
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

        content = nil
        mainContentView.load(markdown: nil)
        mainContentViewHeightConstraint.isActive = false
    }

    // MARK: Private helpers

    private func load(_ content: Content) -> Promise<String?> {
        switch content {
            case .local(_, let value):
                return Promise.value(value)
            case .url(_, let path):
                return loadContent(from: path)
        }
    }

    private func loadContent(from path: String) -> Promise<String?> {
        return Promises.asyncOnGlobalQueue {
            let remotePath = AlgorithmService.baseRemoteRepositoryURL.combinePath(path)
            guard let url = URL(string: remotePath) else {
                throw AlgorithmServiceError.invalidPath
            }

            let data = try Data(contentsOf: url)
            return String(data: data, encoding: .utf8)
        }
    }
}
