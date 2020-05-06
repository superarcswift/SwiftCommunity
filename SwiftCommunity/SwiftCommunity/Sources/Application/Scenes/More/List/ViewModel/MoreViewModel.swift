//
//Copyright © 2019 An Tran. All rights reserved.
//

import Core
import SuperArcNotificationBanner
import SuperArcStateView
import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore
import XCoordinator
import Action
import RxSwift
import RxCocoa

protocol MoreViewModelInput {}

protocol MoreViewModelOutput {}

protocol MoreViewModelApi {
    func update()
    func reset()
}

protocol MoreViewModelType {
    var inputs: MoreViewModelInput { get }
    var outputs: MoreViewModelOutput { get }
    var apis: MoreViewModelApi { get }
}

extension MoreViewModelType where Self: MoreViewModelInput & MoreViewModelOutput & MoreViewModelApi {

    var inputs: MoreViewModelInput {
        return self
    }

    var outputs: MoreViewModelOutput {
        return self
    }

    var apis: MoreViewModelApi {
        return self
    }
}

class MoreViewModel: CoordinatedDIViewModel<MoreRoute, MoreDependency>, MoreViewModelType, MoreViewModelInput, MoreViewModelOutput, MoreViewModelApi {

    // MARK: Propeties

    // Public

    var toogleStateView = PublishSubject<StandardStateViewContext?>()
    var notification = PublishSubject<SuperArcNotificationBanner.Notification?>()

    // MARK: APIs

    func reset() {
        activity.start()
        dependency.conferencesGitService.reset()
            .done { [weak self] isSuccessful in
                guard isSuccessful else {
                    self?.notification.onNext(StandardNotification(message: "Git repository can not be reseted. Please reinstall the app if the problem persists", style: .error))
                    return
                }
                self?.router.trigger(.reset)
            }.catch { [weak self] error in
                self?.notification.onNext(StandardNotification(error: error))
            }.finally { [weak self] in
                self?.activity.stop()
            }

    }

    func update() {
        activity.start()
        dependency.conferencesGitService.update()
            .done { [weak self] _ in
                self?.notification.onNext(StandardNotification(message: "Git repository is updated sucessfully", style: .success))
            }.catch { [weak self] error in
                self?.notification.onNext(StandardNotification(error: error))
            }.finally { [weak self] in
                self?.activity.stop()
            }

    }
}
