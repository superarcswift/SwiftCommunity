//
//  Copyright © 2019 An Tran. All rights reserved.
//


public protocol StateViewContext {
    var headline: String { get }
    var subline: String? { get }
}

public class StandardStateViewContext: StateViewContext {
    public var headline: String
    public var subline: String?

    public init(headline: String, subline: String? = nil) {
        self.headline = headline
        self.subline = subline
    }
}
