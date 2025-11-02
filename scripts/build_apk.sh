#!/bin/bash

# Tokyo Roulette App - APK Build Script
# Builds a release APK for Android

set -e  # Exit on error

echo "============================================"
echo "Tokyo Roulette App - Building Release APK"
echo "============================================"
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Error: Flutter is not installed or not in PATH"
    exit 1
fi

echo "✅ Flutter found: $(flutter --version | head -n1)"
echo ""

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean
echo ""

# Get dependencies
echo "📦 Fetching dependencies..."
flutter pub get
echo ""

# Run tests
echo "🧪 Running tests..."
if flutter test; then
    echo "✅ All tests passed"
else
    echo "❌ Tests failed. Fix tests before building."
    exit 1
fi
echo ""

# Run analyzer
echo "🔍 Running code analysis..."
if flutter analyze; then
    echo "✅ No analysis issues"
else
    echo "⚠️  Warning: Analysis found issues. Consider fixing them."
fi
echo ""

# Check for keystore
if [ ! -f "android/key.properties" ]; then
    echo "⚠️  Warning: android/key.properties not found"
    echo "    Building with debug keystore"
    echo "    For production, create key.properties with your release keystore"
    echo ""
fi

# Build APK
echo "🔨 Building release APK..."
if flutter build apk --release; then
    echo ""
    echo "============================================"
    echo "✅ Build Successful!"
    echo "============================================"
    echo ""
    echo "📦 APK Location:"
    echo "   build/app/outputs/flutter-apk/app-release.apk"
    echo ""
    
    # Show APK size
    APK_SIZE=$(du -h build/app/outputs/flutter-apk/app-release.apk | cut -f1)
    echo "📊 APK Size: $APK_SIZE"
    echo ""
    
    echo "📲 Next Steps:"
    echo "   1. Test on multiple devices"
    echo "   2. Upload to Play Console for testing"
    echo "   3. Complete manual testing checklist"
    echo ""
else
    echo ""
    echo "❌ Build failed. Check errors above."
    exit 1
fi
