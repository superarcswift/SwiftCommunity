//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation

public protocol ChannelProtocol: NSObject {}

open class Channel: NSObject, ChannelProtocol {

    // MARK: Configuration

    public struct Configuration {
        let baseURL: URL
        let additionalHeaders: [String: String]? = nil
    }

    // MARK: Properties

    // Private

    // Internal

    private(set) var session: URLSession!
    let configuration: Configuration!
    private(set) var isCancelling = false

    // Public

    public var shouldDebugPrintJSON = true

    // MARK: Initialization

    public init(configuration: Configuration) {
        self.configuration = configuration
        super.init()

        self.session = setupSession()
    }

    deinit {
        session.invalidateAndCancel()
    }

    // MARK: Session Hooks

    open func setupSession() -> URLSession {
        let sessionConfiguration = makeSessionConfiguration()
        let delegate = ChannelSessionDelegate()
        let session = URLSession(configuration: sessionConfiguration, delegate: delegate, delegateQueue: OperationQueue.main)
        session.sessionDescription = Self.className

        return session
    }

    open func makeSessionConfiguration() -> URLSessionConfiguration {
        let sessionConfiguration = URLSessionConfiguration.default

        if let additionalHeaders = configuration.additionalHeaders {
            sessionConfiguration.addAdditonalHeaders(additionalHeaders)
        }

        return sessionConfiguration
    }

    // MARK: Cancelling

    func startCancelling() {
        isCancelling = true
        session.invalidateAndCancel()
        session = setupSession()
    }

    func endCancelling() {
        isCancelling = false
    }
}

open class ChannelSessionDelegate: NSObject, URLSessionDelegate {}

extension URLSessionConfiguration {

    func addAdditonalHeaders(_ headers: [String: String]) {
        var headers = httpAdditionalHeaders ?? [:]
        headers.merge(with: headers)
        httpAdditionalHeaders = headers
    }
}

/// Common errors of Channels.
public enum ChannelError: Error {
    case canceled
    case invalidArguments
    case dataCorrupted
    case decodingError(_ error: DecodingError)
    case error(_ error: Error)
}
