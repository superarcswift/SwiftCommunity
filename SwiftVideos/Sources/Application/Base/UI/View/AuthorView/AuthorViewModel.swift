//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SwiftVideos_Core
import SwiftVideos_DataModels
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

    private var authorsService: AuthorsServiceProtocol

    private var defaultAuthorImage = UIImage(imageLiteralResourceName: "author_default").withRenderingMode(.alwaysTemplate)

    // MARK: Initialization

    init(authorMetaData: AuthorMetaData, authorsService: AuthorsServiceProtocol) {
        self.authorMetaData = authorMetaData
        self.authorsService = authorsService
        super.init()
    }
}
