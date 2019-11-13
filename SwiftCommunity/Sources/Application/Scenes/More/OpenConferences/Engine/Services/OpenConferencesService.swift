//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Core
import SuperArcCore
import SuperArcNetwork
import PromiseKit

public class OpenConferencesService: Service {

    // MARK: Properties

    // Public

    public var context: ServiceContext

    // Private

    public init(context: ServiceContext) {
        self.context = context
    }

    // MARK: APIs

    public func getList() -> Promise<[(key: Int, value: [OpenConference])]> {
        return makeRequests()
    }

    // MARK: Private helpers

    private func makeRequests() -> Promise<[(key: Int, value: [OpenConference])]> {
        let currentYear = Date().currentYear
        let requesttingPromises = Array(currentYear...(currentYear+1)).map { makeRequest(for: $0) }

        return when(fulfilled: requesttingPromises).then { (results: [[Int: [OpenConference]]]) -> Promise<[(key: Int, value: [OpenConference])]> in
            var conferences = [Int: [OpenConference]]()
            for result in results {
                for (k, v) in result {
                    conferences[k] = v
                }
            }

            let finalConferences = conferences.sorted(by: { (left, right) -> Bool in
                return left.key > right.key
            })

            return Promise.value(finalConferences)
        }
    }

    private func makeRequest(for year: Int) -> Promise<[Int: [OpenConference]]> {
        return jsonServer.getOpenConferences(for: year)
            .map { conferences -> [Int: [OpenConference]] in
                [year: conferences.sorted(by: { (left, right) -> Bool in
                    left.startDate! > right.startDate!
                })]
        }
    }
}

extension OpenConferencesService {

    public var jsonServer: DirectAccessJSONServer {
        return context.communicationInterfaces.resolve(DirectAccessJSONServer.self)!
    }
}
