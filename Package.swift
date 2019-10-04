// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "auto-layout-sugar-ios",
    platforms: [.iOS(.v10)],
    products: [
        .library(name: "AutoLayoutSugar", targets: ["AutoLayoutSugar"]),
    ],
    targets: [
        .target(
            name: "AutoLayoutSugar",
            path: "Sources"
        ),
    ]
)
