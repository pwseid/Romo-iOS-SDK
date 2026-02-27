// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Romo",
    defaultLocalization: "en",
    platforms: [.iOS(.v12)],
    products: [
        .library(name: "RMShared",    targets: ["RMShared"]),
        .library(name: "RMCore",      targets: ["RMCore"]),
        .library(name: "RMCharacter", targets: ["RMCharacter"]),
        .library(name: "RMVision",    targets: ["RMVision"]),
    ],
    dependencies: [
        .package(url: "https://github.com/CocoaLumberjack/CocoaLumberjack.git", from: "3.7.0"),
        .package(url: "https://github.com/pwseid/SocketRocket.git", branch: "main"),
        .package(url: "https://github.com/pwseid/GPUImage.git", branch: "supportSPM"),
        .package(url: "https://github.com/yeatse/opencv-spm.git", from: "4.9.0"),
    ],
    targets: [
        .target(
            name: "RMShared",
            dependencies: [
                .product(name: "CocoaLumberjack", package: "CocoaLumberjack"),
                .product(name: "SocketRocket",    package: "SocketRocket"),
            ],
            path: "RMShared",
            exclude: ["Classes/RMShared-Prefix.pch", "Examples"],
            sources: ["Classes"],
            publicHeadersPath: "include",
            cSettings: [
                .define("GLES_SILENCE_DEPRECATION"),
                .headerSearchPath("Classes"),
                .headerSearchPath("Classes/lib/Categories"),
                .headerSearchPath("Classes/lib/Loggers"),
                .headerSearchPath("Classes/lib/Web Socket"),
                .headerSearchPath("Classes/Math"),
                .headerSearchPath("Classes/Data Structures"),
            ]
        ),
        .target(
            name: "RMCore",
            dependencies: [
                "RMShared",
            ],
            path: "RMCore",
            exclude: ["Classes/RMCore-Prefix.pch", "Classes/Supporting Files", "Examples"],
            sources: ["Classes"],
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("Classes"),
                .headerSearchPath("Classes/Actuation"),
                .headerSearchPath("Classes/Actuation/Driving"),
                .headerSearchPath("Classes/Actuation/Driving/DriveController"),
                .headerSearchPath("Classes/Actuation/Head Tilt"),
                .headerSearchPath("Classes/Communication"),
                .headerSearchPath("Classes/Communication/FirmwareCommon"),
                .headerSearchPath("Classes/Communication/FirmwareUpdate"),
                .headerSearchPath("Classes/LEDs"),
                .headerSearchPath("Classes/Robot"),
                .headerSearchPath("Classes/Robot/Functionality"),
                .headerSearchPath("Classes/Sensing/Bump"),
                .headerSearchPath("Classes/Sensing/Inertial"),
                .headerSearchPath("Classes/Sensing/Stasis"),
                .headerSearchPath("Classes/Utilities/Controllers"),
                .headerSearchPath("Classes/Utilities/DSP"),
                .headerSearchPath("Classes/Utilities/IMU"),
                // RMShared headers
                .headerSearchPath("../RMShared/Classes"),
                .headerSearchPath("../RMShared/Classes/Math"),
                .headerSearchPath("../RMShared/Classes/lib/Categories"),
                .headerSearchPath("../RMShared/Classes/lib/Loggers"),
            ]
        ),
        .target(
            name: "RMCharacter",
            dependencies: [
                "RMShared",
            ],
            path: "RMCharacter",
            exclude: ["Classes/RMCharacter-Prefix.pch", "Examples"],
            sources: ["Classes"],
            resources: [.copy("Assets")],
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("Classes"),
                .headerSearchPath("Classes/Categories"),
                .headerSearchPath("Classes/Face"),
                .headerSearchPath("Classes/Nervous System"),
                .headerSearchPath("Classes/Utilities"),
                .headerSearchPath("Classes/Voice"),
                // RMShared headers
                .headerSearchPath("../RMShared/Classes"),
                .headerSearchPath("../RMShared/Classes/Math"),
                .headerSearchPath("../RMShared/Classes/lib/Categories"),
                .headerSearchPath("../RMShared/Classes/lib/Loggers"),
            ]
        ),
        .target(
            name: "RMVision",
            dependencies: [
                "RMShared",
                .product(name: "CocoaLumberjack", package: "CocoaLumberjack"),
                .product(name: "GPUImage",         package: "GPUImage"),
                .product(name: "OpenCV",           package: "opencv-spm"),
            ],
            path: "RMVision",
            exclude: ["Examples"],
            sources: ["Classes"],
            resources: [.copy("Assets")],
            publicHeadersPath: "include",
            cSettings: [
                .define("GLES_SILENCE_DEPRECATION"),
                .headerSearchPath("Classes"),
                .headerSearchPath("Classes/Debug"),
                .headerSearchPath("Classes/Debug/UI"),
                .headerSearchPath("Classes/Filters"),
                .headerSearchPath("Classes/Modules"),
                .headerSearchPath("Classes/Modules/Brightness Metering"),
                .headerSearchPath("Classes/Modules/Color Detection"),
                .headerSearchPath("Classes/Modules/Face Detection"),
                .headerSearchPath("Classes/Modules/GPUImage"),
                .headerSearchPath("Classes/Modules/Line Detection"),
                .headerSearchPath("Classes/Modules/Motion Detection"),
                .headerSearchPath("Classes/Modules/Natural Training"),
                .headerSearchPath("Classes/Modules/Object Tracking"),
                .headerSearchPath("Classes/Modules/Picture"),
                .headerSearchPath("Classes/Modules/Stasis Detection"),
                .headerSearchPath("Classes/Modules/Video"),
                .headerSearchPath("Classes/Objects"),
                .headerSearchPath("Classes/Utils"),
                // RMShared headers
                .headerSearchPath("../RMShared/Classes"),
                .headerSearchPath("../RMShared/Classes/Math"),
                .headerSearchPath("../RMShared/Classes/lib/Categories"),
                .headerSearchPath("../RMShared/Classes/lib/Loggers"),
            ]
        ),
    ]
)
