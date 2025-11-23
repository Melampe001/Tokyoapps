#!/bin/bash

# Tokyo Roulette App - Firebase Setup Script
# Helps configure Firebase for the app

set -e  # Exit on error

echo "=============================================="
echo "Tokyo Roulette App - Firebase Setup"
echo "=============================================="
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Error: Flutter is not installed or not in PATH"
    exit 1
fi

# Check if FlutterFire CLI is installed
if ! command -v flutterfire &> /dev/null; then
    echo "📦 FlutterFire CLI not found. Installing..."
    dart pub global activate flutterfire_cli
    echo "✅ FlutterFire CLI installed"
    echo ""
else
    echo "✅ FlutterFire CLI found"
    echo ""
fi

echo "🔧 Configuring Firebase..."
echo ""
echo "This will:"
echo "1. Connect to your Firebase project"
echo "2. Generate lib/firebase_options.dart"
echo "3. Configure Android and iOS apps"
echo ""
echo "Make sure you have:"
echo "✓ Created a Firebase project at https://console.firebase.google.com/"
echo "✓ You're logged into the correct Google account"
echo ""

read -p "Press Enter to continue or Ctrl+C to cancel..."
echo ""

# Run FlutterFire configure
if flutterfire configure; then
    echo ""
    echo "✅ Firebase configuration complete!"
    echo ""
    
    # Check if google-services.json was created
    if [ -f "android/app/google-services.json" ]; then
        echo "✅ android/app/google-services.json created"
    else
        echo "⚠️  android/app/google-services.json not found"
        echo "   You may need to download it manually from Firebase Console"
    fi
    
    # Check if firebase_options.dart was created
    if [ -f "lib/firebase_options.dart" ]; then
        echo "✅ lib/firebase_options.dart generated"
    else
        echo "⚠️  lib/firebase_options.dart not found"
    fi
    
    echo ""
    echo "=============================================="
    echo "Next Steps:"
    echo "=============================================="
    echo ""
    echo "1. Enable Firebase services in Console:"
    echo "   • Authentication (Email/Password & Anonymous)"
    echo "   • Firestore Database"
    echo "   • Cloud Storage"
    echo "   • Remote Config"
    echo ""
    echo "2. Configure Firestore security rules"
    echo ""
    echo "3. Test Firebase connection:"
    echo "   flutter run"
    echo ""
    echo "See SETUP_GUIDE.md for detailed instructions"
    echo ""
else
    echo ""
    echo "❌ Firebase configuration failed"
    echo ""
    echo "Manual setup steps:"
    echo "1. Go to https://console.firebase.google.com/"
    echo "2. Create/select your project"
    echo "3. Add Android app with package: com.tokyo.rouletteApp"
    echo "4. Download google-services.json to android/app/"
    echo "5. Update lib/firebase_options.dart manually"
    echo ""
    exit 1
fi
