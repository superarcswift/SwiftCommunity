//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation
import PromiseKit

public class DirectAccessJSONServer: Server {

    // MARK: Properties

    // Public

    public var configuration: ServerConfiguration

    public var channels = Container<ChannelProtocol>()

    public var channel: HTTPJSONChannel {
        guard let channel = channels.resolve(HTTPJSONChannel.self) else {
            let channelConfiguration = Channel.Configuration(baseURL: configuration.baseURL)
            let channel = HTTPJSONChannel(configuration: channelConfiguration)
            try! channels.register(channel, for: HTTPJSONChannel.self)
            return channel
        }

        return channel
    }

    // MARK: Intialization

    public init(configurationContainer: Container<Configuration>) {
        self.configuration = try! configurationContainer.resolve(ServerConfiguration.self)

    }
}
