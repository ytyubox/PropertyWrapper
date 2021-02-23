// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "PropertyWrapper",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "PropertyWrapper",
            targets: ["PropertyWrapper"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "PropertyWrapper",
            dependencies: []
        ),
        .testTarget(
            name: "PropertyWrapperTests",
            dependencies: ["PropertyWrapper"],
            exclude: ["ThreadSafe/Barrier.swift.deadLock.failure"]
        ),
    ]
)
