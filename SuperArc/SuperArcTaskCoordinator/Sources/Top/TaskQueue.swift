//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

///
/// A class to serialize the execution of tasks.
///
public class TaskQueue {

    public typealias Task = () -> Void
    public typealias CompletionHandler = () -> Void

    // MARK: Properties

    // Public

    public var isBusy: Bool {
        return currentTask != nil
    }

    // Private

    private var tasks = [Task]()
    private var currentTask: Task?
    private var completionHandler: CompletionHandler?

    // MARK: APIs

    public init(completionHandler: CompletionHandler? = nil) {
        self.completionHandler = completionHandler
    }

    ///
    /// Enqueue an  async task into the queue.
    /// `finish()` needs to be called manually.
    ///
    public func start(_ task: @escaping Task) {
        tasks.append(task)
        runNextTaskIfAvailable()
    }

    ///
    /// Enqueue a sync task into the queue.
    ///
    public func run(_ task: @escaping Task) {
        start {
            task()
            self.finish()
        }
    }

    ///
    /// Remove all remaining tasks from the queue.
    ///
    public func reset() {
        tasks.removeAll()
        finish()
    }

    ///
    /// Finish the current task and start the next task in the queue.
    ///
    public func finish() {
        currentTask = nil
        runNextTaskIfAvailable()
    }

    // MARK: Private helpers

    private func runNextTaskIfAvailable() {
        guard !isBusy else {
            return
        }

        guard !tasks.isEmpty else {
            completionHandler?()
            return
        }

        currentTask = tasks.removeFirst()
        currentTask!()
    }
}
