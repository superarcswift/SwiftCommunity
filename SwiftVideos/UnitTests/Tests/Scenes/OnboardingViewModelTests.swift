//
//  Copyright © 2019 An Tran. All rights reserved.
//

@testable import SwiftVideos
@testable import Core
import XCoordinator
import RxTest
import RxSwift
import PromiseKit
import XCTest

class OnboardingViewModelTests: UnitTestCase {

    // MARK: Properties

    var viewModel: OnboardingViewModel!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!

    // MARK: Setup

    override func setUp() {
        super.setUp()
        let router = AnyRouter<OnboardingRoute>(RouterMock())
        viewModel = OnboardingViewModel(router: router, dependency: DependencyMock() )

        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        scheduler = nil
        disposeBag = nil
        super.tearDown()
    }

    // MARK: Tests

    func testIntialState() {
        XCTAssertFalse(try viewModel.isReady.value())
        XCTAssertFalse(try viewModel.isUpdated.value())
        XCTAssertFalse(try viewModel.isCloned.value())
    }

    func testPrepareLocalRepositoryWithoutResetShouldCloneAndTriggerIsReady() {
        let expectation = self.expectation(description: #function)

        let gitService = viewModel.dependency.gitService as! GitServiceMock
        gitService.openResult = false

        viewModel.isReady
            .asObserver()
            .skip(1)
            .subscribe { event in
                XCTAssertEqual(.next(true), event)
                expectation.fulfill()
            }.disposed(by: disposeBag)

        viewModel.prepareLocalRepository(shouldResetBeforeCloning: false)

        wait(for: [expectation], timeout: Timeout.short)
    }

    func testPrepareLocalRepositoryWithResetShouldCloneAndTriggerIsReady() {
        let expectation = self.expectation(description: #function)

        let gitService = viewModel.dependency.gitService as! GitServiceMock
        gitService.openResult = false

        viewModel.isReady
            .asObserver()
            .skip(1)
            .subscribe { event in
                XCTAssertEqual(.next(true), event)
                expectation.fulfill()
            }.disposed(by: disposeBag)

        viewModel.prepareLocalRepository(shouldResetBeforeCloning: true)

        wait(for: [expectation], timeout: Timeout.short)
    }

    func testPrepareLocalRepositoryWithoutResetShouldUpdateAndTriggerIsReady() {
        let expectation = self.expectation(description: #function)

        viewModel.isReady
            .asObserver()
            .skip(1)
            .subscribe { event in
            XCTAssertEqual(.next(true), event)
            expectation.fulfill()
        }.disposed(by: disposeBag)

        viewModel.prepareLocalRepository(shouldResetBeforeCloning: false)

        wait(for: [expectation], timeout: Timeout.short)
    }

    func testPrepareLocalRepositoryWithResetShouldUpdateAndTriggerIsReady() {
        let expectation = self.expectation(description: #function)

        viewModel.isReady
            .asObserver()
            .skip(1)
            .subscribe { event in
                XCTAssertEqual(.next(true), event)
                expectation.fulfill()
            }.disposed(by: disposeBag)

        viewModel.prepareLocalRepository(shouldResetBeforeCloning: true)

        wait(for: [expectation], timeout: Timeout.short)
    }

    func testPrepareLocalRepositoryWithResetTriggersErrorNotification() {
        let gitService = viewModel.dependency.gitService as! GitServiceMock
        gitService.updateResult = Result.rejected(ErrorMock.someError)

        let expectation = self.expectation(description: #function)

        viewModel.notification.subscribe(onNext: { notification in
            XCTAssertNotNil(notification)
            expectation.fulfill()
        }).disposed(by: disposeBag)

        viewModel.prepareLocalRepository(shouldResetBeforeCloning: true)

        wait(for: [expectation], timeout: Timeout.debug)
    }

}

// MARK: Mocking helpers

class RouterMock: Router {

    typealias RouteType = OnboardingRoute

    func contextTrigger(_ route: OnboardingRoute, with options: TransitionOptions, completion: ContextPresentationHandler?) {
    }
    var viewController: UIViewController!
}

class DependencyMock: OnboardingDependency {

    var gitService: GitServiceProtocol = GitServiceMock()

    init() {}
}

enum ErrorMock: Error {
    case someError
}
