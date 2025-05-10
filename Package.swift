// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VinCloudKit",
	defaultLocalization: "en",
	platforms: [.macOS(.v13), .iOS(.v16)],
	products: [
		.library(
			name: "VinCloudKit",
			targets: ["VinCloudKit"]),
	],
	dependencies: [
		.package(url: "https://github.com/vincode-io/VinUtility.git", branch: "main"),
	],
	targets: [
		.target(
			name: "VinCloudKit",             
			dependencies: [
				"VinUtility",
			]
		),
		.testTarget(
			name: "VinCloudKitTests",
			dependencies: [
				"VinCloudKit",
			]
		),
	]
)
