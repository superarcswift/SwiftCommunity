//
//  Copyright © 2019 An Tran. All rights reserved.
//

import CommandRegistry

public final class CommlandLineTool {

    // MARK: Properties

    // Private

    private var commandRegistry: CommandRegistry
    private let arguments: [String]


    // MARK: Initialization

    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
        commandRegistry = CommandRegistry(usage: "<subcommand> <options>", overview: "Tools to manage licenses of 3rd parties libraries")
        registerCommands()
    }

    // MARK: APIs

    public func run() {
        commandRegistry.run()
    }

    // MARK: Private helpers

    private func registerCommands() {

        // Carthage
        let carthageCommand = commandRegistry.register(command: CarthageCommand.self)
        commandRegistry.register(subcommand: CarthageGenerationCommand.self, parent: carthageCommand)
    }
}
