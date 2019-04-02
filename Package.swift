// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

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
