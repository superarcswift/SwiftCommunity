//
//  Copyright © 2019 An Tran. All rights reserved.
//

import CommandRegistry
import SPMUtility
import ColorizeSwift
import Foundation

class CarthageGenerationCommand: Command {

    // MARK: Properties

    // Static

    let command = "generate"
    let overview = "Generate a plist containing all licenses of 3rd party libraries installed using carthage"

    // Private

    let subparser: ArgumentParser
    var subcommands: [Command] = []

    private var path: PositionalArgument<String>

    // MARK: Initialization

    required init(parser: ArgumentParser) {
        subparser = parser.add(subparser: command, overview: overview)
        path = subparser.add(positional: "path", kind: String.self, usage: "Path to carthage root folder")
    }

    // MARK: APIs

    func run(with arguments: ArgumentParser.Result) throws {

        guard let rootProjectPath = arguments.get(path) else {
            print("[Error] Content path is missing".red())
            return
        }

        let rootCarthagePath = makeCarthageFolder(from: rootProjectPath)
        print(rootCarthagePath)
        let generator = PlistCarthageLicensesGenerator(rootFolderPath: rootCarthagePath)
        try generator.generate()
    }

    func makeCarthageFolder(from rootProjectPath: String) -> String {
        return rootProjectPath.combinePath("Carthage").combinePath("Checkouts")
    }
}
