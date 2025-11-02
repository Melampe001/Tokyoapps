#!/bin/bash

# Tokyo Roulette App - Quick Setup Script
# This script automates the initial setup process

set -e  # Exit on error

echo "======================================"
echo "Tokyo Roulette App - Quick Setup"
echo "======================================"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}ℹ $1${NC}"
}

# Check if Flutter is installed
echo "Step 1: Checking Flutter installation..."
if command -v flutter &> /dev/null; then
    FLUTTER_VERSION=$(flutter --version | head -n 1)
    print_success "Flutter is installed: $FLUTTER_VERSION"
else
    print_error "Flutter is not installed"
    echo "Please install Flutter from: https://flutter.dev/docs/get-started/install"
    exit 1
fi

# Check Flutter doctor
echo ""
echo "Step 2: Running Flutter doctor..."
flutter doctor

# Check Flutter doctor exit code for critical issues
flutter doctor > /dev/null 2>&1
DOCTOR_EXIT_CODE=$?
if [ $DOCTOR_EXIT_CODE -ne 0 ]; then
    print_info "There are some issues reported by Flutter doctor"
    read -p "Do you want to continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Install dependencies
echo ""
echo "Step 3: Installing Flutter dependencies..."
if flutter pub get; then
    print_success "Dependencies installed successfully"
else
    print_error "Failed to install dependencies"
    exit 1
fi

# Check for Firebase configuration
echo ""
echo "Step 4: Checking Firebase configuration..."
if [ -f "android/app/google-services.json" ]; then
    print_success "Firebase google-services.json found"
else
    print_info "Firebase is not configured"
    echo ""
    echo "To configure Firebase, you have two options:"
    echo ""
    echo "Option 1: Using FlutterFire CLI (Recommended)"
    echo "  dart pub global activate flutterfire_cli"
    echo "  flutterfire configure"
    echo ""
    echo "Option 2: Manual Setup"
    echo "  1. Create Firebase project at https://console.firebase.google.com"
    echo "  2. Download google-services.json"
    echo "  3. Place it in android/app/google-services.json"
    echo ""
    read -p "Do you want to run FlutterFire CLI now? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Installing FlutterFire CLI..."
        dart pub global activate flutterfire_cli
        echo "Running FlutterFire configure..."
        flutterfire configure
    else
        print_info "Skipping Firebase configuration. App will run in offline mode."
    fi
fi

# Check for Android device/emulator
echo ""
echo "Step 5: Checking for Android devices..."
if flutter devices | grep -q "android"; then
    print_success "Android device/emulator detected"
    flutter devices
else
    print_info "No Android device/emulator detected"
    echo "Please connect an Android device or start an emulator"
fi

# Check for assets directories
echo ""
echo "Step 6: Checking assets directories..."
if [ ! -d "assets/images" ]; then
    mkdir -p assets/images
    print_info "Created assets/images directory"
fi
if [ ! -d "assets/icons" ]; then
    mkdir -p assets/icons
    print_info "Created assets/icons directory"
fi
print_success "Assets directories verified"

# Run analysis
echo ""
echo "Step 7: Running Flutter analyze..."
if flutter analyze; then
    print_success "Code analysis passed"
else
    print_info "There are some analysis warnings"
fi

# Summary
echo ""
echo "======================================"
echo "Setup Complete!"
echo "======================================"
echo ""
echo "Next steps:"
echo ""
echo "1. To run the app in debug mode:"
echo "   flutter run"
echo ""
echo "2. To run tests:"
echo "   flutter test"
echo ""
echo "3. To build release APK:"
echo "   flutter build apk --release"
echo ""
echo "4. For more information, see:"
echo "   - README.md - Project overview"
echo "   - REQUIREMENTS.md - All dependencies and setup"
echo "   - IMPLEMENTATION.md - Technical details"
echo "   - TESTING_GUIDE.md - Testing procedures"
echo "   - DEPLOYMENT.md - Deployment guide"
echo ""
print_success "Ready to develop!"
