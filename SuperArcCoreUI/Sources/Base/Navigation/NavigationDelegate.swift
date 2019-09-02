//
//  Copyright © 2019 An Tran. All rights reserved.
//

public protocol NavigationDelegate: class {}

/// The special empty component.
public final class EmptyNavigationDelegate: NavigationDelegate {

    // MARK: Intialization

    public init() {}
}
