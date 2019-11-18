//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import SuperArcActivityIndicator
import SuperArcNotificationBanner
import SuperArcStateView
import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import Action
import RxCocoa
import RxSwift

protocol OpenConferencesViewModelInput {
}

protocol OpenConferencesViewModelOutput {
    var conferences: BehaviorRelay<[OpenConferenceSectionModel]> { get set }
}

protocol OpenConferencesViewModelApi {
    func loadData()
}

protocol OpenConferencesViewModelType {
    var inputs: OpenConferencesViewModelInput { get }
    var outputs: OpenConferencesViewModelOutput { get }
    var apis: OpenConferencesViewModelApi { get }
}

extension OpenConferencesViewModelType where Self: OpenConferencesViewModelInput & OpenConferencesViewModelOutput & OpenConferencesViewModelApi {

    var inputs: OpenConferencesViewModelInput {
        return self
    }

    var outputs: OpenConferencesViewModelOutput {
        return self
    }

    var apis: OpenConferencesViewModelApi {
        return self
    }
}

public class OpenConferencesViewModel: DIViewModel<OpenConferencesDependency>, OpenConferencesViewModelType, OpenConferencesViewModelInput, OpenConferencesViewModelOutput, OpenConferencesViewModelApi {

    // MARK: Properties

    // Private

    private let service: OpenConferencesService

    // Public

    var conferences = BehaviorRelay<[OpenConferenceSectionModel]>(value: [])

    var toogleStateView = PublishSubject<StandardStateViewContext?>()
    var notification = PublishSubject<SuperArcNotificationBanner.Notification?>()

    // MARK: Initialization

    public override init(dependency: OpenConferencesDependency) {
        service = OpenConferencesService(context: dependency.engine.serviceContext)
        super.init(dependency: dependency)
    }

    // MARK: APIs

    func loadData() {
        activity.start()
        service.getList()
            .mapValues {
                OpenConferenceSectionModel(year: $0.key, items: $0.value)
            }
            .done { [weak self] sectionModel in
                self?.conferences.accept(sectionModel)
            }
            .ensure { [weak self] in
                self?.activity.stop()
            }
            .catch { [weak self] error in
                self?.toogleStateView.on(.next(StandardStateViewContext(headline: error.localizedDescription)))
            }
    }

}
