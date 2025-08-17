// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "APGWorkKit",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "APGWorkKit",
            targets: ["APGWorkKit"]),
    ],
    targets: [
        .target(
            name: "APGWorkKit"),
        .testTarget(
            name: "APGWorkKitTests",
            dependencies: ["APGWorkKit"]
        ),
    ]
)
