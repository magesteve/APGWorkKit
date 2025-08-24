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
    dependencies: [
        .package(url: "https://github.com/magesteve/APGIntentKit.git", from: "0.3.0"),    ],
    targets: [
        .target(
            name: "APGWorkKit",
            dependencies: [
                "APGIntentKit"
            ]
        ),
        .testTarget(
            name: "APGWorkKitTests",
            dependencies: ["APGWorkKit"]
        ),
    ]
)
