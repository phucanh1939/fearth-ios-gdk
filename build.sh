#!/bin/bash

# Set build configuration (default to Debug if not provided)
BUILD_CONFIG=${1:-Debug}

# Generate Xcode project
sh ./gen_xcode.sh

# Build for iOS (Device: arm64)
cmake --build build/ --config "$BUILD_CONFIG" -- -sdk iphoneos

# Build for iOS Simulator (arm64 & x86_64)
cmake --build build/ --config "$BUILD_CONFIG" -- -sdk iphonesimulator

# shellcheck disable=SC2086
# Create the .xcframework
xcodebuild -create-xcframework \
  -framework build/${BUILD_CONFIG}-iphoneos/FearthGdk.framework \
  -framework build/${BUILD_CONFIG}-iphonesimulator/FearthGdk.framework \
  -output build/FearthGdk.xcframework