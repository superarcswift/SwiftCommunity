//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import SuperArcActivityIndicator
import SuperArcNotificationBanner
import SuperArcStateView
import SuperArcCoreUI
import SuperArcCore
import RxCocoa
import RxSwift

protocol ContentTableViewModelInput {}

protocol ContentTableViewModelOutput {
    var section: BehaviorRelay<Section?> { get set }
    var isReady: BehaviorSubject<Bool> { get set }
}

protocol ContentTableViewModelApi {

    func loadData(sectionID: String?)
}

protocol ContentViewModelType {
    var inputs: ContentTableViewModelInput { get }
    var outputs: ContentTableViewModelOutput { get }
    var apis: ContentTableViewModelApi { get }
}

extension ContentViewModelType where Self: ContentTableViewModelInput & ContentTableViewModelOutput & ContentTableViewModelApi {

    var inputs: ContentTableViewModelInput {
        return self
    }

    var outputs: ContentTableViewModelOutput {
        return self
    }

    var apis: ContentTableViewModelApi {
        return self
    }
}

class ContentTableViewModel: ViewModel, ContentViewModelType, ContentTableViewModelInput, ContentTableViewModelOutput, ContentTableViewModelApi {

    // MARK: Properties

    // Private

    private var algortihmService: AlgorithmService

    // Public

    var section = BehaviorRelay<Section?>(value: nil)

    var isReady = BehaviorSubject<Bool>(value: false)
    var isUpdated = BehaviorSubject<Bool>(value: false)
    var isCloned = BehaviorSubject<Bool>(value: false)

    var activity = Activity()
    var toggleEmptyState = PublishSubject<StandardStateViewContext?>()
    var notification = PublishSubject<SuperArcNotificationBanner.Notification?>()

    // Private

    private let disposeBag = DisposeBag()

    // MARK: Initialization

    public init(algorithmService: AlgorithmService) {
        self.algortihmService = algorithmService
    }

    // MARK: APIs

    func loadData(sectionID: String?) {
        activity.start()
        algortihmService.fetchSection(with: sectionID)
            .done { [weak self] section in
                self?.section.accept(section)
            }
            .ensure { [weak self] in
                self?.activity.stop()
            }
            .catch { [weak self] error in
                self?.notification.onNext(StandardNotification(error: error))
            }
    }

    func prepareLocalRepository(shouldResetBeforeCloning: Bool) {

        // Check if the local repository is existing.
        guard !algortihmService.open() else {
            updateLocalRepository()
            return
        }

        // If the local repository doesn't exist, clone it.
        if shouldResetBeforeCloning {
            algortihmService.reset()
                .done { [weak self] _ in
                    self?.cloneRemoteRepository()
                }
                .catch { [weak self] error in
                    self?.notification.onNext(StandardNotification(error: error))
                }
        } else {
            cloneRemoteRepository()
        }
    }

    func contentViewModel(for content: Content) -> ContentViewModel {
        ContentViewModel(content: content, algorithmService: algortihmService)
    }

    // MARK: Private helpers

    private func updateLocalRepository() {
        activity.start()
        algortihmService.update()
            .done { [weak self] _ in
                self?.isUpdated.onNext(true)
            }
            .ensure { [weak self] in
                self?.activity.stop()
                self?.isReady.onNext(true)
            }
            .catch { [weak self] error in
                self?.notification.onNext(StandardNotification(error: error))
            }
    }

    private func cloneRemoteRepository() {
        activity.start()
        algortihmService.clone(progressHandler: { _, _ in
            //print(progress)
            })
            .done { [weak self] _ in
                self?.isReady.onNext(true)
            }
            .ensure { [weak self] in
                self?.activity.stop()
            }
            .catch { [weak self] error in
                self?.notification.onNext(StandardNotification(error: error))
            }
    }

}
