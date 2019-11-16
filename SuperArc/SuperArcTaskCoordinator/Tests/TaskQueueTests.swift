//
//  Copyright © 2019 An Tran. All rights reserved.
//

@testable import SuperArcTaskCoordinator
import PromiseKit
import XCTest

class TaskQueueTests: XCTestCase {

    func testRunTasksInQueue() {
        let expectationTask1 = self.expectation(description: #function)
        let expectationTask2 = self.expectation(description: #function)

        let taskQueue = TaskQueue()

        let task1 = {
            expectationTask1.fulfill()
        }

        let task2 = {
            expectationTask2.fulfill()
        }

        taskQueue.run(task1)
        taskQueue.run(task2)

        wait(for: [expectationTask1, expectationTask2], timeout: 5.0, enforceOrder: true)
    }

    func testStartAndFinishTasksInQueue() {
        let expectationTask1 = self.expectation(description: #function)
        let expectationTask2 = self.expectation(description: #function)
        let finalExpectation = self.expectation(description: #function)

        var value = 0
        let taskQueue = TaskQueue {
            XCTAssertEqual(value, 2)
            finalExpectation.fulfill()
        }

        let task1 = {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                expectationTask1.fulfill()
                taskQueue.finish()
            }
        }

        let task2 = {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                value = 2
                expectationTask2.fulfill()
                taskQueue.finish()
            }
        }

        taskQueue.start(task1)
        taskQueue.start(task2)

        wait(for: [expectationTask1, expectationTask2, finalExpectation], timeout: 5.0, enforceOrder: true)
    }

    func testPromise() {
        let finalExpectation = self.expectation(description: #function)

        var value = 0
        let taskQueue = TaskQueue {
            XCTAssertEqual(value, 5)
            finalExpectation.fulfill()
        }

        for i in 1...5 {
            taskQueue.run {
                Promise<Void> { resolver in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        value = i
                        resolver.fulfill(())
                    }
                }
            }
        }

        wait(for: [finalExpectation], timeout: 5.0, enforceOrder: true)
    }
}
