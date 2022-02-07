// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Actors",
    platforms: [
        .macOS(.v12), .iOS(.v15)
    ],
    products: [
        .library(
            name: "Actors",
            targets: ["Actors"]),
    ],
    targets: [
        .target(
            name: "Actors",
            dependencies: []),
        .testTarget(
            name: "ActorsTests",
            dependencies: ["Actors"]),
    ]
)
