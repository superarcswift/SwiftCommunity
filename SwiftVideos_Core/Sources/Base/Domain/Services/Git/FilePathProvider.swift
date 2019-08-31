//
//  Copyright © 2019 An Tran. All rights reserved.
//

struct FilePathProvider {

    // MARK: Properties

    // Public

    var localRepositoryURL: URL!
    var origanizationName: String!
    var repositoryName: String!

    // Private

    private var baseLocalRepositoryPath: String
    private var remoteRepositoryURL: URL

    // MARK: Init

    init(baseLocalRepositoryPath: String, remoteRepositoryURL: URL) {
        self.baseLocalRepositoryPath = baseLocalRepositoryPath
        self.remoteRepositoryURL = remoteRepositoryURL

        prepareURL()
    }

    // MARK: Private helpers

    mutating func prepareURL() {
        let components = remoteRepositoryURL.pathComponents
        guard components.count == 3 else {
            fatalError("invalid remote git url")
        }

        origanizationName = components[1]
        repositoryName = components[2]
        let localRepositoryPath = baseLocalRepositoryPath.combinePath(origanizationName).combinePath(repositoryName)
        localRepositoryURL = URL(string: "file://\(localRepositoryPath)/")!
    }
}
