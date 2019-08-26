// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LicensesManager",
    dependencies: [
        .package(url: "https://github.com/JohnSundell/Files.git", from: "3.1.0"),
        .package(url: "https://github.com/mtynior/ColorizeSwift.git", .branch("master")),
        .package(url: "https://github.com/eneko/CommandRegistry.git", from: "0.0.1"),
        .package(url: "https://github.com/apple/swift-package-manager.git", from: "0.1.0"),
    ],
    targets: [
        .target(
            name: "LicensesManager",
            dependencies: ["Files", "ColorizeSwift", "CommandRegistry", "SwiftPM"],
            path: ".")
    ]
)
