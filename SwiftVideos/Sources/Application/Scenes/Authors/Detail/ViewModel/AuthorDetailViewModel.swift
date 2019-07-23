//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCoordinator
import SuperArcCoreUI
import SuperArcCore

class AuthorDetailViewModel: ViewModel {

    // MARK: Properties

    // Public

    // Private

    private var author: Author
    private let router: AnyRouter<AuthorsRoute>

    // MARK: Initialization

    init(author: Author, router: AnyRouter<AuthorsRoute>, engine: Engine) {
        self.author = author
        self.router = router
        super.init(engine: engine)
    }
}
