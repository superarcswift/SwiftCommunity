//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import MarkdownView

class AboutViewController: ViewController<AboutViewModel>, StoryboardInitiable {

    // MARK: Properties

    // Static

    static var storyboardName = "More"

    var markdownView: MarkdownView!

    // MARK: Setup

    override func setupViews() {
        super.setupViews()

        markdownView = MarkdownView()
        view.addSubview(markdownView)
        markdownView.translatesAutoresizingMaskIntoConstraints = false
        markdownView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        markdownView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        markdownView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        markdownView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    override func loadData() {
        let description = viewModel.readProjectDescription()
        markdownView.load(markdown: description)
    }
}
