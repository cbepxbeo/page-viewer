// swift-tools-version:5.3
//
// Created by: Egor Boyko

import PackageDescription

let package = Package(
    name: "PageViewer",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "PageViewer",targets: ["PageViewer"])
    ],
    targets: [
        .target(
            name: "PageViewer",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "PageViewerTests",
            dependencies: ["PageViewer"]
        ),
    ],
    swiftLanguageVersions: [ .version("5.1") ]
)
