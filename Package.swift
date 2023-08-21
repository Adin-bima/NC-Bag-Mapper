// swift-tools-version: 5.8

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "BagMapper",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "BagMapper",
            targets: ["AppModule"],
            bundleIdentifier: "com.adin.bag-mapper",
            teamIdentifier: "2SQJ3VS7UD",
            displayVersion: "3.1",
            bundleVersion: "1",
            appIcon: .asset("AppIcon"),
            accentColor: .presetColor(.teal),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ],
            capabilities: [
                .camera(purposeString: "Allow this app to use camera"),
                .photoLibrary(purposeString: "Allow this app to use photo library")
            ],
            appCategory: .utilities
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: ".",
            swiftSettings: [
                .enableUpcomingFeature("BareSlashRegexLiterals")
            ]
        )
    ]
)