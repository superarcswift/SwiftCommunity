import SwiftShell
import Files
import Rainbow

// From the root project folder
// swift run --package-path Tools/Bootstrap/ Bootstrap .

func runCarthage(in folder: Folder) {
    do {
        try runAndPrint(bash: "pushd \(folder.path) && carthage update --platform iOS && popd")
    } catch {
        print("\(error)")
    }
}

let arguments = CommandLine.arguments
guard arguments.count == 2 else {
    exit(errormessage: "Usage: swift run Bootstrap <<path_to_root_project>>")
}

let rootProjectPath = arguments[1]

print("🏃‍♂️ Starting at \(rootProjectPath) ...")

do {
    let folder = try Folder(path: rootProjectPath)
    folder.makeSubfolderSequence(recursive: false).forEach { folder in
        if folder.containsFile(named: "Cartfile") {
            print("\n---------\n\n⚙️  Running in \(folder.path)")
            runCarthage(in: folder)
        }
    }


} catch {
    exit(error)
}

print("👍 Finished!")
