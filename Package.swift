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
    dependencies: [
    ],
    targets: [
        .binaryTarget(
                    name: "NetPaySDK",
                    url: "https://github.com/daniel-garcia-ca/xcframework-netpay/releases/tag/1.0.0/NetPaySDK.xcframework.zip",
                    checksum: "ff0627b7ae1db0d7277363b7d68f001c6b572e08dcbe71591871434d2c65925b"
                ),
        .binaryTarget(
                    name: "TMXProfiling",
                    url: "https://github.com/daniel-garcia-ca/xcframework-tmx-profile/releases/tag/1.0.0/TMXProfiling.xcframework.zip",
                    checksum: "b4f285d7005da07e2224e43bb068bcdf17dcacb2e2e7583de0c9116ebb8fecd9"
                ),
        .binaryTarget(
                    name: "TMXProfilingConnections",
                    url: "https://github.com/daniel-garcia-ca/xcframework-tmx-profile-communication/releases/tag/1.0.0/TMXProfilingConnections.xcframework.zip",
                    checksum: "b71a3171edb8bbfcb928e5c9df19bca357b392a64b7ef213569062117e2724ec"
                ),
    ]
)
