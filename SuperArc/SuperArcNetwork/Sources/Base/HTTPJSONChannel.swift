//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation
import PromiseKit

open class HTTPJSONChannel: Channel {

    // MARK: Constants

    static let acceptApplicationJSON = ["Accept": "application/json; charset=utf-8"]

    // MARK: Properties

    // MARK: Interface

    public func sendRequest<ResponseType>(_ request: JSONRequest<ResponseType>) -> Promise<ResponseType> {
        if isCancelling && request.cancellable {
            return Promise(error: ChannelError.canceled)
        }

        return jsonToData(request).then { requestData -> Promise<Data> in
            var headers = HTTPJSONChannel.acceptApplicationJSON
            headers.merge(with: request.headers ?? [:])
            return self.http(method: request.httpMethod, components: request.components, headers: headers, requestData: requestData)
        }.then { responseData -> Promise<ResponseType> in
            self.printResponse(http: request.httpMethod, components: request.components, data: responseData)

            guard responseData.isEmpty else {
                return self.dataToJSON(responseData, type: ResponseType.self)
            }
            assert(ResponseType.self == EmptyResponse.self)
            guard let emptyResponse = EmptyResponse() as? ResponseType else {
                return Promise(error: ResultError.unexpectedResult)
            }
            return Promise.value(emptyResponse)
        }
    }

    // MARK: Private helpers

    private func http(method: HTTPMethod, components: URLComponents, headers: [String: String], requestData: Data?) -> Promise<Data> {

        printRequest(http: method, path: components.path, header: headers, body: requestData)

        var newComponents = components
        newComponents.scheme = configuration.baseURL.scheme
        newComponents.host = configuration.baseURL.host
        newComponents.port = configuration.baseURL.port
        newComponents.path = configuration.baseURL.path.combinePath(components.path)

        var urlRequest = URLRequest(url: newComponents.url!)
        urlRequest.httpMethod = method.rawValue
        if method != .get {
            urlRequest.httpBody = requestData
        }
        urlRequest.setValue("application/json; charset=utf8", forHTTPHeaderField: "Content-Type")

        for (key, value) in headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        return sendURLRequest(urlRequest)
    }

    private func sendURLRequest(_ urlRequest: URLRequest) -> Promise<Data> {
        let (promise, resolver) = Promise<Data>.pending()
        let urlString = urlRequest.url?.absoluteString

        let task = session.dataTask(with: urlRequest) { responseData, urlResponse, error in
            if let error = error {
                resolver.reject(NetworkError(error, path: urlString) ?? error)
                return
            }

            let httpURLResponse = urlResponse as! HTTPURLResponse
            let statusCode = httpURLResponse.statusCode

            // Handle success cases 200/201
            if statusCode == 200 || statusCode == 201 {

                guard let responseData = responseData else {
                    resolver.reject(NetworkError.missingData(urlString))
                    return
                }

                resolver.fulfill(responseData)
                return
            }

            // Handle success case no data (204)
            if statusCode == 204 {
                resolver.fulfill(Data())
                return
            }

            // Handle failure cases
            resolver.reject(NetworkError.wrongHTTPStatusCode(statusCode, urlString))
        }

        task.taskDescription = urlRequest.description
        task.resume()

        return promise
    }

    private func jsonToData<T: Encodable>(_ json: T) -> Promise<Data> {
        return Promises.asyncOnGlobalQueue {
            return try JSONEncoder().encode(json)
        }
    }

    private func dataToJSON<T: Decodable>(_ data: Data, type: T.Type) -> Promise<T> {
        guard data.count > 0 else {
            return Promise(error: ChannelError.dataCorrupted)
        }

        return Promises.asyncOnGlobalQueue {
            return try JSONDecoder().decode(type, from: data)
        }
    }

    // MARK: Error handling

    private func handleErrorResponse<T>(_ error: Error, for request: JSONRequest<T>) {
        handleErrorResponse(error, for: request.components)
    }

    private func handleErrorResponse(_ error: Error, for components: URLComponents) {
        guard let path = components.string else {
            print("Could not resolve path.")
            return
        }

        if let errorResponse = error as? ErrorResponse {
            errorResponse.configure(withPath: path)
        }
    }

    // MARK: Printing

    private func printRequest(http: HTTPMethod, path: String, header: [String: String]?, body: Data?) {
        print("> \(http.rawValue): \(path)")

        if let header = header, shouldDebugPrintJSON {
            print("> header: \(header as AnyObject)")
        }

        if let body = body, let decodedBody = (try? JSONSerialization.jsonObject(with: body, options: [])) as? [String: Any], shouldDebugPrintJSON {
            print("> body: \(decodedBody as AnyObject)")
        }
    }

    private func printResponse(http: HTTPMethod, components: URLComponents, data: Data) {
        guard let path = components.string else {
            print("Could not resolve path.")
            return
        }

        let json = try? JSONSerialization.jsonObject(with: data, options: [])

        if shouldDebugPrintJSON {
            if let json = json {
                print("< \(http.rawValue): \(path): \(json as AnyObject)")
            } else {
                print("< \(http.rawValue): \(path): <empty>")
            }
        } else {
            print("< \(http): \(path): Success Data-Size: \(data.count) (debugPrintJSON == false)")
        }
    }

    private func printFailure(http: String, components: URLComponents, error: Error, isRequest: Bool) {
        guard let path = components.url?.absoluteString else {
            print("Could not resolve path.")
            return
        }

        let requestCharacter = isRequest ? ">" : "<"
        print("\(requestCharacter) \(http): \(path): " + error.localizedDescription)
    }
}
