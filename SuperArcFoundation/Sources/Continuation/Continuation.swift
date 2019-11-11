//
//  Copyright © 2019 An Tran. All rights reserved.
//

extension Result {
    public typealias Continuation = (Result<Success, Failure>) -> Void
}
