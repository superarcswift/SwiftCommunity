//
//  Copyright © 2019 An Tran. All rights reserved.
//

/// The tagging protocol for objects that serve as dependencies for components.
public protocol Dependency: AnyObject {}

/// The special dependency protocol which is empty.
public protocol EmptyDependency: Dependency {}
