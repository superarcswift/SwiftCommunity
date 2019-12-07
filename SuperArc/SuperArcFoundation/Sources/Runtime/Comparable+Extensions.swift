//
//  Copyright © 2019 An Tran. All rights reserved.
//

extension Comparable {

    /// Clamp the current value between 2 lower and upper limit values.
    ///
    /// 15.clamped(to: 0...10) -> returns 10
    /// 3.0.clamped(to: 0.0...10.0) -> returns 3.0
    /// "a".clamped(to: "g"..."y") -> returns "g"
    public func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
