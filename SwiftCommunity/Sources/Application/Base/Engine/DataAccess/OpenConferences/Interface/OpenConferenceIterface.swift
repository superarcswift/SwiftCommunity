//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcNetwork
import PromiseKit

extension DirectAccessJSONServer {

    func getOpenConferences(for year: Int) -> Promise<[OpenConference]> {
        let request = GetOpenConferencesRequest(httpMethod: .get, components: "\(year.asString)/ios.json".urlComponents)

        return channel.sendRequest(request).then { response -> Promise<[OpenConference]> in
            return Promise { resolver in
                resolver.fulfill(response.conferences)
            }
        }
    }
}

class GetOpenConferencesRequest: JSONRequest<GetOpenConferencesResponse> {}

class GetOpenConferencesResponse: JSONResponse {

    let conferences: [OpenConference]

    required init(from decoder: Decoder) throws {
        conferences = try [OpenConference](from: decoder)
    }
}
