// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "SwiftCommunity",
    products: [
        .library(name: "DangerDepsSwiftCommunity", type: .dynamic, targets: ["DangerDependencies"]),
    ],
    dependencies: [
        .package(url: "https://github.com/danger/swift.git", from: "3.0.0"),
        .package(url: "https://github.com/f-meloni/danger-swift-coverage", from: "1.1.0")
    ],
    targets: [
        .target(
          name: "DangerDependencies",
          dependencies: ["Danger", "DangerSwiftCoverage"]
        ),
    ]
)
