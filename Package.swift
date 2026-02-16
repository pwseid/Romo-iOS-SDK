// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Romo",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "Romo",
            targets: ["Romo"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/CocoaLumberjack/CocoaLumberjack.git", from: "3.8.0"),
        .package(url: "https://github.com/facebookincubator/SocketRocket.git", from: "0.7.1")
    ],
    targets: [
        .target(
            name: "Romo",
            dependencies: [
                .product(name: "CocoaLumberjack", package: "CocoaLumberjack"),
                .product(name: "SocketRocket", package: "SocketRocket")
            ],
            path: ".",
            exclude: [
                ".github",
                "docs",
                "RMCharacter/Examples",
                "RMCore/Examples",
                "RMShared/Examples",
                "RMVision",
                "RMCharacter/Classes/RMCharacter-Prefix.pch",
                "RMCore/Classes/RMCore-Prefix.pch",
                "RMCore/Classes/Supporting Files",
                "RMShared/Classes/RMShared-Prefix.pch"
            ],
            sources: [
                "RMShared/Classes",
                "RMCore/Classes",
                "RMCharacter/Classes"
            ],
            resources: [
                .process("RMCharacter/Assets")
            ],
            publicHeadersPath: "SPM/include",
            cSettings: [
                .headerSearchPath("SPM/include"),
                .headerSearchPath("RMCharacter/Classes"),
                .headerSearchPath("RMCharacter/Classes/Categories"),
                .headerSearchPath("RMCharacter/Classes/Face"),
                .headerSearchPath("RMCharacter/Classes/Nervous System"),
                .headerSearchPath("RMCharacter/Classes/Utilities"),
                .headerSearchPath("RMCharacter/Classes/Voice"),
                .headerSearchPath("RMCore/Classes"),
                .headerSearchPath("RMCore/Classes/Actuation"),
                .headerSearchPath("RMCore/Classes/Actuation/Driving"),
                .headerSearchPath("RMCore/Classes/Actuation/Driving/DriveController"),
                .headerSearchPath("RMCore/Classes/Actuation/Head Tilt"),
                .headerSearchPath("RMCore/Classes/Communication"),
                .headerSearchPath("RMCore/Classes/Communication/FirmwareCommon"),
                .headerSearchPath("RMCore/Classes/Communication/FirmwareUpdate"),
                .headerSearchPath("RMCore/Classes/LEDs"),
                .headerSearchPath("RMCore/Classes/Robot"),
                .headerSearchPath("RMCore/Classes/Robot/Functionality"),
                .headerSearchPath("RMCore/Classes/Sensing/Bump"),
                .headerSearchPath("RMCore/Classes/Sensing/Inertial"),
                .headerSearchPath("RMCore/Classes/Sensing/Stasis"),
                .headerSearchPath("RMCore/Classes/Utilities/Controllers"),
                .headerSearchPath("RMCore/Classes/Utilities/DSP"),
                .headerSearchPath("RMCore/Classes/Utilities/IMU"),
                .headerSearchPath("RMShared/Classes"),
                .headerSearchPath("RMShared/Classes/Data Structures"),
                .headerSearchPath("RMShared/Classes/Math"),
                .headerSearchPath("RMShared/Classes/lib/Categories"),
                .headerSearchPath("RMShared/Classes/lib/Loggers"),
                .headerSearchPath("RMShared/Classes/lib/Web Socket")
            ],
            linkerSettings: [
                .linkedFramework("AVFoundation"),
                .linkedFramework("CoreMotion"),
                .linkedFramework("ExternalAccessory"),
                .linkedFramework("MediaPlayer"),
                .linkedFramework("QuartzCore"),
                .linkedFramework("UIKit")
            ]
        )
    ]
)
