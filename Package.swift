// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "AnyMenu",
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
