#!/bin/bash

# Tokyo Roulette App - App Bundle Build Script
# Builds a release App Bundle (.aab) for Google Play Store

set -e  # Exit on error

echo "==============================================="
echo "Tokyo Roulette App - Building Release Bundle"
echo "==============================================="
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Error: Flutter is not installed or not in PATH"
    exit 1
fi

echo "✅ Flutter found: $(flutter --version | head -n1)"
echo ""

# Check for keystore configuration
if [ ! -f "android/key.properties" ]; then
    echo "❌ Error: android/key.properties not found"
    echo ""
    echo "For Play Store release, you need a release keystore:"
    echo "1. Generate keystore:"
    echo "   keytool -genkey -v -keystore ~/tokyo-roulette-key.jks \\"
    echo "     -keyalg RSA -keysize 2048 -validity 10000 \\"
    echo "     -alias tokyo-roulette"
    echo ""
    echo "2. Create android/key.properties:"
    echo "   storePassword=YOUR_STORE_PASSWORD"
    echo "   keyPassword=YOUR_KEY_PASSWORD"
    echo "   keyAlias=tokyo-roulette"
    echo "   storeFile=/path/to/tokyo-roulette-key.jks"
    echo ""
    exit 1
fi

echo "✅ Keystore configuration found"
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

# Build App Bundle
echo "🔨 Building release App Bundle..."
if flutter build appbundle --release; then
    echo ""
    echo "==============================================="
    echo "✅ Build Successful!"
    echo "==============================================="
    echo ""
    echo "📦 App Bundle Location:"
    echo "   build/app/outputs/bundle/release/app-release.aab"
    echo ""
    
    # Show bundle size
    AAB_SIZE=$(du -h build/app/outputs/bundle/release/app-release.aab | cut -f1)
    echo "📊 Bundle Size: $AAB_SIZE"
    echo ""
    
    echo "📲 Next Steps:"
    echo "   1. Go to Play Console: https://play.google.com/console"
    echo "   2. Create a new release (Internal/Closed/Open testing or Production)"
    echo "   3. Upload app-release.aab"
    echo "   4. Fill in release notes"
    echo "   5. Review and roll out"
    echo ""
    echo "⚠️  Important:"
    echo "   - Test with internal/closed testing first"
    echo "   - Complete all Play Console requirements"
    echo "   - Ensure privacy policy is in place"
    echo "   - Complete content rating questionnaire"
    echo ""
else
    echo ""
    echo "❌ Build failed. Check errors above."
    exit 1
fi
