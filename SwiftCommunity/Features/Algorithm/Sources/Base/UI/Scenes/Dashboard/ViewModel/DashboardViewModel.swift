//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import SuperArcNotificationBanner
import SuperArcStateView
import SuperArcCoreUI
import SuperArcCore
import XCoordinator
import XCoordinatorRx
import Action
import RxCocoa
import RxSwift

protocol ContentViewModelInput {}

protocol ContentViewModelOutput {
    var section: BehaviorRelay<Section?> { get set }
}

protocol ContentViewModelApi {

    func loadData(sectionID: String?)
}

protocol ContentViewModelType {
    var inputs: ContentViewModelInput { get }
    var outputs: ContentViewModelOutput { get }
    var apis: ContentViewModelApi { get }
}

extension ContentViewModelType where Self: ContentViewModelInput & ContentViewModelOutput & ContentViewModelApi {

    var inputs: ContentViewModelInput {
        return self
    }

    var outputs: ContentViewModelOutput {
        return self
    }

    var apis: ContentViewModelApi {
        return self
    }
}

public class ContentViewModel: DIViewModel<AlgorithmDependency>, ContentViewModelType, ContentViewModelInput, ContentViewModelOutput, ContentViewModelApi {

    // MARK: Properties

    // Private

    // Public

    var section = BehaviorRelay<Section?>(value: nil)

    var notification = PublishSubject<SuperArcNotificationBanner.Notification?>()

    // MARK: APIs

    func loadData(sectionID: String?) {
        let service = AlgorithmService(context: dependency.serviceContext)
        service.fetchSection(with: sectionID)
            .done { [weak self] section in
                self?.section.accept(section)
            }
            .catch { [weak self] error in
                self?.notification.onNext(StandardNotification(error: error))
            }
    }
}
