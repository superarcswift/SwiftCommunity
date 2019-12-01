//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore

public protocol HasConferencesGitService {
    var conferencesGitService: ConferencesGitService { get }
}

public class ConferencesGitService: BaseGitService {

    // MARK: Properties

    public lazy var baseContentPath = {
        baseLocalRepositoryPath.combinePath("content")
    }()

    // MARK: Initialization

    public convenience init(context: ServiceContext) {
        let repositoryURL = try! context.configurations.container.resolve(GitRepositoryConfigurationProtocol.self).conferencesRepositoryURL
        self.init(context: context, remoteRepositoryURL: repositoryURL)
    }
}
