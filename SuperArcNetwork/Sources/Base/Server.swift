//
//  Copyright © 2019 An Tran. All rights reserved.
//

import SuperArcFoundation

public protocol CommunicationInterface {
    var channels: Container<ChannelProtocol> { get }
}

protocol Server: CommunicationInterface {
    associatedtype ChannelType = ChannelProtocol
    associatedtype ConfigurationType = ServerConfiguration
}
