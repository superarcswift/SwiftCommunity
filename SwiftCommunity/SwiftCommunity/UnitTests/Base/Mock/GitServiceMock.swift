//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import ObjectiveGit
import PromiseKit
import RxSwift

class BaseGitServiceMock: GitServiceProtocol {

    var baseLocalRepositoryPath: String = ""
    var localRepository: GTRepository?
    var didUpdate = PublishSubject<Void>()

    var openResult = true
    var cloneResult = Result.fulfilled(())
    var updateResult = Result.fulfilled(())
    var resetResult = Result.fulfilled(true)

    var isReset = false

    init() {}

    func open() -> Bool {
        return openResult
    }

    func clone(progressHandler: @escaping (Float, Bool) -> Void) -> Promise<Void> {
        return Promise { resolver in
            resolver.resolve(cloneResult)
        }
    }

    func update() -> Promise<Void> {
        return Promise { resolver in
            resolver.resolve(updateResult)
        }
    }

    func reset() -> Promise<Bool> {
        isReset = true
        return Promise { resolver in
            resolver.resolve(resetResult)
        }
    }

    func localURL(for filePath: String) -> URL? {
        return nil
    }
}

class ConferencesGitServiceMock: BaseGitServiceMock, ConferencesGitServiceProtocol {

}
