//
//  Copyright © 2019 An Tran. All rights reserved.
//

/// Protocol defining routes that a component can navigate to.
public protocol ComponentRoute {}

/// A special route type which has no route.
public enum EmptyComponentRoute: ComponentRoute {}
