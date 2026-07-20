// swift-tools-version: 6.1
import PackageDescription

let featureFlags: [SwiftSetting] = [
    .enableExperimentalFeature("StrictConcurrency=complete"),
    .enableUpcomingFeature("ExistentialAny"),
]

let package = Package(
    name: "elementary-alpine",
    platforms: [
        .macOS(.v14),
        .iOS(.v15),
        .tvOS(.v17),
        .watchOS(.v10),
    ],
    products: [
        .library(name: "ElementaryAlpine", targets: ["ElementaryAlpine"]),
        .library(name: "ElementaryAlpinePlugins", targets: ["ElementaryAlpinePlugins"]),
    ],
    dependencies: [
        .package(url: "https://github.com/elementary-swift/elementary.git", from: "0.8.0")
    ],
    targets: [
        .target(
            name: "ElementaryAlpine",
            dependencies: [
                .product(name: "Elementary", package: "elementary")
            ],
            swiftSettings: featureFlags
        ),
        .target(
            name: "ElementaryAlpinePlugins",
            dependencies: [
                .product(name: "Elementary", package: "elementary")
            ],
            swiftSettings: featureFlags
        ),
        .testTarget(
            name: "ElementaryAlpineTests",
            dependencies: [
                .target(name: "ElementaryAlpine"),
                .target(name: "TestUtilities"),
            ],
            exclude: ["SnapshotFixtures"],
            swiftSettings: featureFlags
        ),
        .testTarget(
            name: "ElementaryAlpinePluginsTests",
            dependencies: [
                .target(name: "ElementaryAlpinePlugins"),
                .target(name: "TestUtilities"),
            ],
            exclude: [
                "Anchor/SnapshotFixtures",
                "Collapse/SnapshotFixtures",
                "Focus/SnapshotFixtures",
                "Intersect/SnapshotFixtures",
                "Mask/SnapshotFixtures",
                "Morph/SnapshotFixtures",
                "Resize/SnapshotFixtures",
                "Sort/SnapshotFixtures",
            ],
            swiftSettings: featureFlags
        ),
        .target(
            name: "TestUtilities",
            dependencies: [
                .product(name: "Elementary", package: "elementary")
            ],
            path: "Tests/TestUtilities",
            swiftSettings: featureFlags
        ),
    ]
)
