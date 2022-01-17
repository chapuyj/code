// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "async-await",
    platforms: [
        .macOS(.v12), .iOS(.v15)
    ],
    products: [
        .library(
            name: "async-await",
            targets: ["async-await"]),
    ],
    targets: [
        .target(
            name: "async-await",
            dependencies: []),
        .testTarget(
            name: "async-await-tests",
            dependencies: ["async-await"]),
    ]
)
