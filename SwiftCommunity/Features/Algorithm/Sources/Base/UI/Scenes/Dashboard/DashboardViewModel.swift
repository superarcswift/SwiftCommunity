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

protocol DashboardViewModelInput {
    var didSelectSectionTrigger: AnyObserver<Section> { get }
}

protocol DashboardViewModelOutput {
    var section: BehaviorRelay<Section?> { get set }
}

protocol DashboardViewModelApi {

    func loadData(sectionID: String?)
}

protocol DashboardViewModelType {
    var inputs: DashboardViewModelInput { get }
    var outputs: DashboardViewModelOutput { get }
    var apis: DashboardViewModelApi { get }
}

extension DashboardViewModelType where Self: DashboardViewModelInput & DashboardViewModelOutput & DashboardViewModelApi {

    var inputs: DashboardViewModelInput {
        return self
    }

    var outputs: DashboardViewModelOutput {
        return self
    }

    var apis: DashboardViewModelApi {
        return self
    }
}

public class DashboardViewModel: DIViewModel<AlgorithmDependency>, DashboardViewModelType, DashboardViewModelInput, DashboardViewModelOutput, DashboardViewModelApi {

    // MARK: Properties

    // Private

    private lazy var showSectionAction = Action<Section, Void> { [unowned self] section in
        Observable.just(())
    }

    // Public

    lazy var didSelectSectionTrigger: AnyObserver<Section> = showSectionAction.inputs

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
