//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import MarkdownView

open class MarkdownViewController: ViewController<MarkdownViewModel> {

    // MARK: Properties

    // Private

    private var markdownView: MarkdownView!

    // MARK: Setup

    override open func setupViews() {
        super.setupViews()

        markdownView = MarkdownView()
        view.addSubview(markdownView)
        markdownView.translatesAutoresizingMaskIntoConstraints = false
        markdownView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        markdownView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        markdownView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        markdownView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    // MARK: APIs

    override open func loadData() {
        let description = viewModel.loadContent()
        markdownView.load(markdown: description)
    }
}
