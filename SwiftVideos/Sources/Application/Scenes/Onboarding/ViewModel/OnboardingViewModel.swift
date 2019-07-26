//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreUI
import SuperArcCore
import XCoordinator
import RxSwift
import RxCocoa

class OnboardingViewModel: CoordinatedViewModel<OnboardingRoute> {

    // MARK: Properties

    // Public

    var isReady = PublishSubject<Bool>()

    // Private

    let disposeBag = DisposeBag()

    // MARK: Setup

    override init(router: AnyRouter<OnboardingRoute>, engine: Engine) {
        super.init(router: router, engine: engine)

        isReady
            .observeOn(MainScheduler.instance)
            .subscribe { event in
                guard let isReady = event.element, isReady else {
                    return
                }
                self.router.trigger(.dashboard)
            }.disposed(by: disposeBag)
    }

    // MARK: APIs

    func prepareLocalRepository() {

        // Check if localRepository is existing
        guard !gitService.open() else {
            updateLocalRepository()
            return
        }

        // If localRepository doesn't exist, clone it
        cloneRemoteRepository()
    }

    // MARK: Private helpers

    private func updateLocalRepository() {
        gitService.update()
            .done { [weak self] _ in
                self?.isReady.onNext(true)
            }.catch { error in
                print(error)
            }
    }

    private func cloneRemoteRepository() {
        gitService.clone()
            .done { [weak self] _ in
                self?.isReady.onNext(true)
            }.catch { error in
                print(error)
            }
    }
}

extension OnboardingViewModel {

    var gitService: GitService {
        return engine.serviceRegistry.resolve(type: GitService.self)
    }
}
