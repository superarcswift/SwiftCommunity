//
//  Copyright © 2019 An Tran. All rights reserved.
//

public protocol JSONResponse: Decodable {}

public struct EmptyResponse: JSONResponse {}

open class JSONRequest<ResponseType: JSONResponse>: RawJSONRequest<ResponseType> {

    open var cancellable: Bool {
        return true
    }

    open var headers: [String: String]?
}

open class RawJSONRequest<ResponseType: JSONResponse>: Encodable {

    public let httpMethod: HTTPMethod
    public let components: URLComponents

    public init(httpMethod: HTTPMethod, components: URLComponents) {
        self.httpMethod = httpMethod
        self.components = components
    }
}

/// Error objects can adopt this protocol to get configured about the request path used for error handling.
public protocol ErrorResponse: class {

    /// Informs self about the `path` used for the failing request.
    func configure(withPath path: String)
}
