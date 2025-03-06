#!/bin/bash

# Set variables
FRAMEWORK_NAME="FearthGdk"
FRAMEWORK_DIR="build/$FRAMEWORK_NAME.xcframework"  # Change to your actual framework path
LICENSE_FILE="LICENSE"  # Ensure this file exists in the project root
VERSION=$1  # Get version from the first script argument
ZIP_FILE="$FRAMEWORK_NAME-$VERSION.zip"
REPO=$(git config --get remote.origin.url | sed -E 's/.*github\.com[:\/]([^\/]+\/[^\.]+)(\.git)?/\1/')
ZIP_URL="https://github.com/$REPO/releases/download/$VERSION/$ZIP_FILE"

# Check if a version was provided
if [ -z "$VERSION" ]; then
    echo "❌ Error: No version provided."
    echo "Usage: ./upload_release.sh <version>"
    exit 1
fi

# Ensure GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo "❌ Error: GitHub CLI (gh) is not installed."
    exit 1
fi

# Check if the LICENSE file exists
if [ ! -f "$LICENSE_FILE" ]; then
    echo "❌ Error: LICENSE file not found!"
    exit 1
fi

# Create the ZIP file
echo "📦 Creating zip file: $ZIP_FILE..."
rm -f "$ZIP_FILE"
zip -r "$ZIP_FILE" "$FRAMEWORK_DIR" "$LICENSE_FILE"

# Check if the release exists
if gh release view "$VERSION" --repo "$REPO" >/dev/null 2>&1; then
    echo "🚀 Uploading $ZIP_FILE to existing release $VERSION..."
else
    echo "🆕 Release $VERSION does not exist. Creating it now..."
    gh release create "$VERSION" --repo "$REPO" --title "$VERSION" --notes "Release $VERSION"
    echo "✅ Release $VERSION created successfully!"
fi

# Upload the zip file
echo "🚀 Uploading $ZIP_FILE to release $VERSION..."
gh release upload "$VERSION" "$ZIP_FILE" --repo "$REPO" --clobber
echo "✅ File uploaded successfully!"
echo "🔗 Release ZIP URL: $ZIP_URL"

echo "🗑 Deleting local zip file: $ZIP_FILE..."
rm -f "$ZIP_FILE"
echo "✅ ZIP file deleted!"
