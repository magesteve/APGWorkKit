// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "APGWorkKit",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "APGWorkKit",
            targets: ["APGWorkKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/magesteve/APGCantripKit.git", from: "0.5.1"),
        .package(url: "https://github.com/magesteve/APGIntentKit.git", from: "0.5.4"),
        .package(url: "https://github.com/magesteve/APGWidgetKit.git", from: "0.1.3")
    ],
    targets: [
        .target(
            name: "APGWorkKit",
            dependencies: [
                "APGCantripKit", "APGWidgetKit", "APGIntentKit"
            ]
        ),
        .testTarget(
            name: "APGWorkKitTests",
            dependencies: ["APGWorkKit"]
        ),
    ]
)
