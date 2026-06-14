// swift-tools-version: 6.0
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
    ],
    dependencies: [
        .package(url: "https://github.com/elementary-swift/elementary.git", from: "0.6.0")
    ],
    targets: [
        .target(
            name: "ElementaryAlpine",
            dependencies: [
                .product(name: "Elementary", package: "elementary")
            ],
            swiftSettings: featureFlags
        ),
    ]
)
