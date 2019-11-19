//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcCoreComponent
import SuperArcCoreUI
import SuperArcCore

public protocol MarkdownViewModelProtocol {
    var resourceURL: URL? { get set }
    func loadContent() -> String?
}

extension MarkdownViewModelProtocol {

    public func loadContent() -> String? {
        if let url = resourceURL {
            return try? String(contentsOf: url, encoding: .utf8)
        }

        return nil
    }
}

open class MarkdownViewModel: ViewModel, MarkdownViewModelProtocol {

    // MARK: Properties

    // Public

    public var resourceURL: URL?

    // MARK: Initialization

    public init(resourceURL: URL?) {
        self.resourceURL = resourceURL
    }
}
