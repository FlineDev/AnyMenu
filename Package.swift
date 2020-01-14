// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "AnyMenu",
    platforms: [.iOS(.v10)],
    products: [
        .library(name: "AnyMenu", targets: ["AnyMenu"])
    ],
    targets: [
        .target(
            name: "AnyMenu",
            path: "Sources"
        )
    ]
)
