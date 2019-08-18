//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore

class AuthorViewModel: ViewModel {

    // MARK: Properties

    // Public

    var authorMetaData: AuthorMetaData

    var name: String {
        return authorMetaData.name
    }

    var avatarImage: UIImage {
        guard let avatarImageURL = authorsService.avatar(of: authorMetaData) else {
            return defaultAuthorImage
        }

        guard let avatarImage = UIImage(contentsOfFile: avatarImageURL.path) else {
            return defaultAuthorImage
        }

        return avatarImage
    }

    // Private

    private var authorsService: AuthorsService

    private var defaultAuthorImage = UIImage(imageLiteralResourceName: "author_default").withRenderingMode(.alwaysTemplate)

    // MARK: Initialization

    init(authorMetaData: AuthorMetaData, authorsService: AuthorsService) {
        self.authorMetaData = authorMetaData
        self.authorsService = authorsService
        super.init()
    }
}
