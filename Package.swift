// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "WhatsUp",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "WhatsUp", targets: ["WhatsUp"])
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "WhatsUp",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "WhatsUpTests",
            dependencies: ["WhatsUp"],
            path: "Tests"
        )
    ]
)