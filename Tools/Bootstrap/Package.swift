// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Bootstrap",
    platforms: [.macOS(.v10_13)],
    dependencies: [
        .package(url: "https://github.com/kareman/SwiftShell", from: "5.0.0"),
        .package(url: "https://github.com/onevcat/Rainbow", from: "3.0.0"),
        .package(url: "https://github.com/JohnSundell/Files", from: "3.0.0")
    ],
    targets: [
        .target(
            name: "Bootstrap",
            dependencies: ["SwiftShell", "Rainbow", "Files"],
            path: "."),
    ]
)
