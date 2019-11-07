//
//  Copyright © 2019 An Tran. All rights reserved.
//

import XCTest
@testable import SuperArcTaskCoordinator

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

        let taskQueue = TaskQueue()

        let task1 = {
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
                expectationTask1.fulfill()
                taskQueue.finish()
            }
        }

        let task2 = {
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
                expectationTask2.fulfill()
                taskQueue.finish()
            }
        }

        taskQueue.start(task1)
        taskQueue.start(task2)

        wait(for: [expectationTask1, expectationTask2], timeout: 5.0, enforceOrder: true)
    }

    func testAccessingResourceFromTasks() {
        let expectation = self.expectation(description: #function)

        var value = 0
        let taskQueue = TaskQueue {
            XCTAssertEqual(value, 2)
            expectation.fulfill()
        }

        let task1 = {
            value = 1
        }

        let task2 = {
            value = 2
        }

        taskQueue.start(task1, task2)

        wait(for: [expectation], timeout: 5.0, enforceOrder: true)
    }
}
