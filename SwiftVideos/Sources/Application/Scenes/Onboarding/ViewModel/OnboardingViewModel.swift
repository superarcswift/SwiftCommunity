//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import XCoordinator
import RxSwift
import RxCocoa

protocol OnboardingViewModelInput {}

protocol OnboardingViewModelOutput {
    var isReady: PublishSubject<Bool> { get set }
    var isUpdated: PublishSubject<Bool> { get set }
    var isCloned: PublishSubject<Bool> { get set }
}

protocol OnboardingViewModelApi {
    func prepareLocalRepository()
}

protocol OnboardingViewModelType {
    var inputs: OnboardingViewModelInput { get }
    var outputs: OnboardingViewModelOutput { get }
    var apis: OnboardingViewModelApi { get }
}

extension OnboardingViewModelType where Self: OnboardingViewModelType & OnboardingViewModelInput & OnboardingViewModelOutput & OnboardingViewModelApi {

    var inputs: OnboardingViewModelInput {
        return self
    }

    var outputs: OnboardingViewModelOutput {
        return self
    }

    var apis: OnboardingViewModelApi {
        return self
    }
}

class OnboardingViewModel: CoordinatedDIViewModel<OnboardingRoute, OnboardingDependency>, OnboardingViewModelType, OnboardingViewModelInput, OnboardingViewModelOutput, OnboardingViewModelApi {

    // MARK: Properties

    // Public

    var isReady = PublishSubject<Bool>()
    var isUpdated = PublishSubject<Bool>()
    var isCloned = PublishSubject<Bool>()

    // Private

    private let disposeBag = DisposeBag()

    // MARK: Initialization

    override init(router: AnyRouter<OnboardingRoute>, dependency: OnboardingDependency) {
        super.init(router: router, dependency: dependency)

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

        // Check if localRepository is existing.
        guard !dependency.gitService.open() else {
            updateLocalRepository()
            return
        }

        // If localRepository doesn't exist, clone it.
        cloneRemoteRepository()
    }

    // MARK: Private helpers

    private func updateLocalRepository() {
        isReady.onNext(true)
//        gitService.update()
//            .done { [weak self] _ in
//                self?.isUpdated.onNext(true)
//            }.ensure { [weak self] in
//                self?.isReady.onNext(true)
//            }.catch { error in
//                print(error)
//            }
    }

    private func cloneRemoteRepository() {
        dependency.gitService.clone()
            .done { [weak self] _ in
                self?.isReady.onNext(true)
            }.catch { error in
                print(error)
            }
    }
}
