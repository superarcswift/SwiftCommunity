//
//  Copyright © 2019 An Tran. All rights reserved.
//

import RxCocoa
import RxSwift

public protocol ActivityState {
    var activity: Activity { get }
}

public class Activity {

    // MARK: Properties

    // Private

    private var counter =  0  {
        didSet {
            counter > 0 ? active.onNext(true) : active.onNext(false)
        }
    }

    // Public

    public var active = BehaviorSubject<Bool>(value: false)

    // MARK: Intialization

    public init() {}

    // MARK: APIs

    public func start() {
        counter += 1
    }

    public func stop() {
        counter = max(0, counter - 1)
    }
}
