// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyNetwork",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "MyNetwork",
            targets: ["MyNetwork"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "7.0.0")),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", .upToNextMajor(from: "10.0.0")),
    ],
    targets: [
        .target(
            name: "MyNetwork",
            dependencies: [
                "Kingfisher",
                .product(name: "FirebasePerformance", package: "firebase-ios-sdk")
            ]
        ),
        .testTarget(
            name: "MyNetworkTests",
            dependencies: ["MyNetwork"]
        ),
    ]
)
