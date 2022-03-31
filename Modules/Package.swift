// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Form",
            targets: [
                "Form"
            ]),
        .library(
            name: "Modules",
            targets: [
                "Home",
                "Favorites"
            ]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Extensions",
            dependencies: []),
        .target(
            name: "Core",
            dependencies: []),
        .target(
            name: "CoreUI",
            dependencies: ["Extensions"]),
        .target(
            name: "Form",
            dependencies: ["Core"]),
        .testTarget(
            name: "FormTests",
            dependencies: ["Form"]),
        .target(
            name: "Home",
            dependencies: ["FavoritesData", "Core", "CoreUI", "Extensions"]),
        .testTarget(
            name: "HomeTests",
            dependencies: ["Home"]),
        .target(
            name: "Favorites",
            dependencies: ["FavoritesData", "Core"]),
        .testTarget(
            name: "FavoritesTests",
            dependencies: ["Favorites"]),
        .target(
            name: "FavoritesData",
            dependencies: ["Core"],
            resources: [
                .copy("FavoritesRepos.xcdatamodeld")
            ]
        ),
    ]
)
