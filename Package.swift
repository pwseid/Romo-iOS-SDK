// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Romo",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "RomoSDK",
            targets: ["Romo"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/CocoaLumberjack/CocoaLumberjack.git", from: "3.8.0"),
        .package(url: "https://github.com/pwseid/GPUImage.git", branch: "master"),
        .package(url: "https://github.com/pwseid/SocketRocket.git", branch: "main"),
        .package(url: "https://github.com/yeatse/opencv-spm.git", from: "4.13.0")
    ],
    targets: [
        .target(
            name: "Romo",
            dependencies: [
                .product(name: "GPUImage", package: "GPUImage"),
                .product(name: "CocoaLumberjack", package: "CocoaLumberjack"),
                .product(name: "SocketRocket", package: "SocketRocket"),
                .product(name: "OpenCV", package: "opencv-spm")
            ],
            path: ".",
            exclude: [
                ".github",
                "docs",
                "RMCharacter/Examples",
                "RMCore/Examples",
                "RMShared/Examples",
                "RMVision/Examples",
                "RMCharacter/Classes/RMCharacter-Prefix.pch",
                "RMCore/Classes/RMCore-Prefix.pch",
                "RMCore/Classes/Supporting Files",
                "RMShared/Classes/RMShared-Prefix.pch",
                "Vendor"
            ],
            sources: [
                "RMShared/Classes",
                "RMCore/Classes",
                "RMCharacter/Classes",
                "RMVision/Classes"
            ],
            resources: [
                .process("RMCharacter/Assets"),
                .process("RMVision/Assets")
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
                .headerSearchPath("RMShared/Classes/lib/Web Socket"),
                .headerSearchPath("RMVision/Classes"),
                .headerSearchPath("RMVision/Classes/Debug"),
                .headerSearchPath("RMVision/Classes/Debug/UI"),
                .headerSearchPath("RMVision/Classes/Filters"),
                .headerSearchPath("RMVision/Classes/Modules"),
                .headerSearchPath("RMVision/Classes/Modules/Brightness Metering"),
                .headerSearchPath("RMVision/Classes/Modules/Color Detection"),
                .headerSearchPath("RMVision/Classes/Modules/Face Detection"),
                .headerSearchPath("RMVision/Classes/Modules/GPUImage"),
                .headerSearchPath("RMVision/Classes/Modules/Line Detection"),
                .headerSearchPath("RMVision/Classes/Modules/Motion Detection"),
                .headerSearchPath("RMVision/Classes/Modules/Natural Training"),
                .headerSearchPath("RMVision/Classes/Modules/Object Tracking"),
                .headerSearchPath("RMVision/Classes/Modules/Picture"),
                .headerSearchPath("RMVision/Classes/Modules/Stasis Detection"),
                .headerSearchPath("RMVision/Classes/Modules/Video"),
                .headerSearchPath("RMVision/Classes/Objects"),
                .headerSearchPath("RMVision/Classes/Utils")
            ],
            linkerSettings: [
                .linkedFramework("AVFoundation"),
                .linkedFramework("CoreMedia"),
                .linkedFramework("CoreMotion"),
                .linkedFramework("CoreVideo"),
                .linkedFramework("ExternalAccessory"),
                .linkedFramework("MediaPlayer"),
                .linkedFramework("OpenGLES"),
                .linkedFramework("QuartzCore"),
                .linkedFramework("UIKit")
            ]
        )
    ]
)
