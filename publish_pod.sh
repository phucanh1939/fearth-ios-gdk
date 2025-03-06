#!/bin/bash

# Set variables
PODSPEC_FILE="FearthGdk.podspec"

# Ensure CocoaPods is installed
if ! command -v pod &> /dev/null; then
    echo "❌ Error: CocoaPods (pod) is not installed."
    exit 1
fi

# Validate the podspec file
echo "🔍 Validating podspec file: $PODSPEC_FILE..."
if pod spec lint "$PODSPEC_FILE" --allow-warnings --verbose; then
    echo "✅ Podspec validation passed!"
else
    echo "❌ Podspec validation failed. Fix the issues before publishing."
    exit 1
fi

# Publish the pod package
echo "🚀 Publishing CocoaPod package..."
if pod trunk push "$PODSPEC_FILE" --allow-warnings --verbose; then
    echo "✅ CocoaPod published successfully!"
else
    echo "❌ Failed to publish the pod."
    exit 1
fi
