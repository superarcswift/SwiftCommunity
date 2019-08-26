//
//  Copyright © 2019 An Tran. All rights reserved.
//

import CommandRegistry
import SPMUtility
import ColorizeSwift
import Foundation

class CarthageCommand: Command {

    // MARK: Properties

    // Static

    let command = "carthage"
    let overview = "Managing licenses of 3rd party library installed using Carthage."

    // Private

    let subparser: ArgumentParser
    var subcommands: [Command] = []

    // MARK: Initialization

    required init(parser: ArgumentParser) {
        subparser = parser.add(subparser: command, overview: overview)
    }

    // MARK: APIs

    func run(with arguments: ArgumentParser.Result) throws {
        print("[Error] carthage: build".red())
    }
}
