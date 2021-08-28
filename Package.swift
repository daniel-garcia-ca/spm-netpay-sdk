// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetPayEcomm",
    platforms: [
        .iOS(.v12)
        ],
    products: [
        .library(
            name: "NetPaySDK",
            targets: ["NetPaySDK"]
        ),
        .library(
            name: "TMXProfiling",
            targets: ["TMXProfiling"]
        ),
        .library(
            name: "TMXProfilingConnections",
            targets: ["TMXProfilingConnections"]
        )
    ],
    dependencies: [],
    targets: [
        .binaryTarget(
                    name: "NetPaySDK",path: "./Sources/NetPaySDK.xcframework"
                ),
        .binaryTarget(name: "TMXProfiling", path: "./Sources/TMXProfiling.xcframework"),
        .binaryTarget(name: "TMXProfilingConnections", path: "./Sources/TMXProfilingConnections.xcframework"),
    ]
)
