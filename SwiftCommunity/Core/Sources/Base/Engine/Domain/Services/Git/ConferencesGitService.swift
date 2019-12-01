//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCore

public protocol HasConferencesGitService {
    var conferencesGitService: ConferencesGitServiceProtocol { get }
}

public protocol ConferencesGitServiceProtocol: GitServiceProtocol {}

public class ConferencesGitService: BaseGitService, ConferencesGitServiceProtocol {

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
