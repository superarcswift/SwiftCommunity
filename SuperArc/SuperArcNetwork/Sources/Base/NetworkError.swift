//
//  Copyright © 2019 An Tran. All rights reserved.
//

/// An struct representing Network related errors.
public struct NetworkError: Error {

    public enum NetworkErrorCategory: Equatable {
        case offline
        case timeOut
        case notReachable
        case wrongHTTPStatusCode(Int)
        case invalidResponse
        case missingData
        case canceled
    }

    public let category: NetworkErrorCategory
    public let path: String?

    public init?(_ error: Error, path: String? = nil, checkDomain: Bool = false) {

        guard !checkDomain || error._domain == "NSURLErrorDomain" else {
            return nil
        }

        print("***** NetworkError.errorCode = \(error._code) - domain =  \(error._domain) - description = \(error.localizedDescription) - path = \(String(describing: path))")

        self.path = path

        switch error._code {
            case NSURLErrorNotConnectedToInternet:  self.category = .offline
            case NSURLErrorTimedOut:                self.category = .timeOut
            case NSURLErrorCancelled:               self.category = .canceled
            case NSURLErrorBadServerResponse:       self.category = .invalidResponse
            case NSURLErrorCannotParseResponse:     self.category = .invalidResponse
            case NSURLErrorZeroByteResource:        self.category = .missingData
            case let code where code <= 0 && code > -3008:  self.category = .notReachable
            default:                                return nil
        }
    }

    private init(_ error: NetworkErrorCategory, path: String? = nil) {
        self.category = error
        self.path = path
    }

    public static func offline(_ path: String? = nil) -> NetworkError {
        return NetworkError(.offline, path: path)
    }

    public static func timeOut(_ path: String? = nil) -> NetworkError {
        return NetworkError(.timeOut, path: path)
    }

    public static func notReachable(_ path: String? = nil) -> NetworkError {
        return NetworkError(.notReachable, path: path)
    }

    public static func wrongHTTPStatusCode(_ code: Int, _ path: String? = nil) -> NetworkError {
        return NetworkError(.wrongHTTPStatusCode(code), path: path)
    }

    public static func invalidResponse(_ path: String? = nil) -> NetworkError {
        return NetworkError(.invalidResponse, path: path)
    }

    public static func missingData(_ path: String? = nil) -> NetworkError {
        return NetworkError(.missingData, path: path)
    }

    public static func canceled(_ path: String? = nil) -> NetworkError {
        return NetworkError(.canceled, path: path)
    }

    /// Returns `true` iff the error occurs due to connectivity issues and not data issues.
    public var isConnectivityIssue: Bool {
        switch category {
            case .offline, .timeOut, .notReachable: return true
            default:                                return false
        }
    }
}
