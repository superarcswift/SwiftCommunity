//
//  Copyright © 2019 An Tran. All rights reserved.
//

/// Tagging protocol for objects that serve as dependencies for components.
public protocol Dependency: class {}

/// A special dependency protocol which is empty.
public protocol EmptyDependency: Dependency {}
