//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import DataModels
import SuperArcCoreUI
import SuperArcCore

public class AuthorViewModel: ViewModel {

    // MARK: Properties

    // Public

    public var authorMetaData: AuthorMetaData

    public var name: String {
        return authorMetaData.name
    }

    public var avatarImage: UIImage {
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

    private var defaultAuthorImage = UIImage.named("author_default", bundleClass: AuthorViewModel.self)!.withRenderingMode(.alwaysTemplate)

    // MARK: Initialization

    public init(authorMetaData: AuthorMetaData, authorsService: AuthorsServiceProtocol) {
        self.authorMetaData = authorMetaData
        self.authorsService = authorsService
        super.init()
    }
}
