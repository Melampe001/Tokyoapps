# Tokyo Roulette App - Quick Start Guide

Get up and running with the Tokyo Roulette Predictor app in 5 minutes!

## Prerequisites Checklist

Before you begin, make sure you have:

- [ ] **Flutter SDK 3.0.0+** installed ([Download](https://flutter.dev/docs/get-started/install))
- [ ] **Android Studio** or **VS Code** with Flutter extensions
- [ ] **Java JDK 11+** installed
- [ ] **Android device** connected OR **Android emulator** running
- [ ] **Git** installed

### Quick Verification

```bash
flutter doctor -v
```

This command will show you what's missing. Fix any critical issues (marked with ✗).

## 5-Minute Setup

### Option 1: Automated Setup (Recommended)

```bash
# Clone the repository
git clone https://github.com/Melampe001/Tokyoapps.git
cd Tokyoapps

# Run the automated setup script
./setup.sh

# Run the app
flutter run
```

The setup script will:
- Check Flutter installation
- Install all dependencies
- Verify your environment
- Guide you through Firebase setup (optional)

### Option 2: Manual Setup

```bash
# 1. Clone the repository
git clone https://github.com/Melampe001/Tokyoapps.git
cd Tokyoapps

# 2. Install dependencies
flutter pub get

# 3. Check for devices
flutter devices

# 4. Run the app
flutter run
```

## First Run

When you first run the app:

1. **Choose a device**: Flutter will ask which device to use
   ```
   Multiple devices found:
   [1]: Android SDK (mobile)
   [2]: Chrome (web)
   ```
   Select the Android device number.

2. **Wait for build**: First build takes 2-3 minutes
   
3. **Grant permissions**: When prompted, allow:
   - Camera access (for OCR feature)
   - Vibration (for haptic feedback)

4. **Start using**: The app is now running in debug mode!

## Firebase Setup (Optional)

Firebase enables cloud sync and authentication. You can skip this for local testing.

### Quick Firebase Setup

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase (follow the prompts)
flutterfire configure
```

### Manual Firebase Setup

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Create a new project (or use existing)
3. Add an Android app with package name: `com.tokyo.roulette_app`
4. Download `google-services.json`
5. Place it in `android/app/google-services.json`

**Without Firebase**: The app works in offline mode with local storage only.

## Testing the App

### Quick Functional Test

1. **Tap "MANUAL SPIN"**: Generates a random roulette number
2. **View prediction**: See AI-powered predictions below
3. **Check stats**: Tap the chart icon to see statistics
4. **Try camera**: Tap "CAMERA SPIN" to scan numbers (requires camera permission)

### Running Automated Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

## Common First-Run Issues

### Issue: "No devices found"

**Solution**: Start an Android emulator or connect a device

```bash
# List available emulators
emulator -list-avds

# Start an emulator
emulator -avd <avd-name>

# Or connect a physical device via USB with USB debugging enabled
```

### Issue: "Flutter not found"

**Solution**: Add Flutter to your PATH

```bash
# Linux/macOS
export PATH="$PATH:/path/to/flutter/bin"

# Add to ~/.bashrc or ~/.zshrc for permanent effect
echo 'export PATH="$PATH:/path/to/flutter/bin"' >> ~/.bashrc
```

### Issue: "Android licenses not accepted"

**Solution**: Accept Android SDK licenses

```bash
flutter doctor --android-licenses
```

Press `y` to accept all licenses.

### Issue: "Camera permission denied"

**Solution**: 
- Manually grant camera permission in device Settings > Apps > Tokyo Roulette > Permissions
- Or uninstall and reinstall to see permission prompt again

### Issue: "Gradle build failed"

**Solution**: Clean and rebuild

```bash
flutter clean
flutter pub get
flutter run
```

## Basic Usage

### Manual Spin Mode
1. Tap **"MANUAL SPIN"** button
2. A random number is generated (0-36 for European, +00 for American)
3. View the prediction panel for:
   - Recommended next numbers
   - Hot/cold number analysis
   - Confidence scores

### Camera OCR Mode
1. Tap **"CAMERA SPIN"** button
2. Point camera at roulette wheel or number display
3. App automatically recognizes the number
4. Or tap gallery icon to select an image

### Subscription Tiers
- **Free**: Basic predictions (hot/cold numbers)
- **Advanced ($199)**: Voisins du Zéro sector + neighbor analysis
- **Premium ($299)**: All 4 sectors + advanced strategies

*Demo mode auto-upgrades for testing*

### View Statistics
- Tap the **chart icon** to see:
  - Number frequency bar chart (animated 3D style)
  - Hot/cold number grid
  - Color distribution (Red/Black/Green)

### Switch Roulette Type
- Tap the settings icon
- Choose between:
  - European (0-36)
  - American (0-36 + 00)

## What's Next?

Now that you have the app running:

1. **Explore features**: Try all the buttons and screens
2. **Read documentation**: 
   - [README.md](README.md) - Project overview
   - [REQUIREMENTS.md](REQUIREMENTS.md) - All dependencies
   - [IMPLEMENTATION.md](IMPLEMENTATION.md) - Technical architecture
   - [TESTING_GUIDE.md](TESTING_GUIDE.md) - How to test
   - [DEPLOYMENT.md](DEPLOYMENT.md) - Build for production

3. **Test thoroughly**: See [TESTING_GUIDE.md](TESTING_GUIDE.md) for the complete testing checklist

4. **Customize**: Modify colors, features, or add your own enhancements

## Development Mode Features

When running in debug mode, you get:

- **Hot reload**: Press `r` in terminal to reload code changes instantly
- **Hot restart**: Press `R` to restart the app
- **Debug overlay**: See performance metrics
- **Error messages**: Detailed error descriptions

### Hot Reload Example

1. Make a code change (e.g., change a color in `lib/utils/constants.dart`)
2. Save the file
3. Press `r` in the terminal
4. See changes instantly without restarting the app!

## Building for Release

When you're ready to build a production APK:

```bash
# Build release APK
flutter build apk --release

# Output location
# build/app/outputs/flutter-apk/app-release.apk
```

For complete deployment instructions, see [DEPLOYMENT.md](DEPLOYMENT.md).

## Getting Help

- **Documentation**: Check the docs folder and markdown files
- **Issues**: https://github.com/Melampe001/Tokyoapps/issues
- **Flutter Docs**: https://flutter.dev/docs
- **Stack Overflow**: Tag your questions with `flutter`

## Summary Commands

```bash
# Setup
git clone https://github.com/Melampe001/Tokyoapps.git
cd Tokyoapps
flutter pub get

# Run
flutter run

# Test
flutter test

# Build
flutter build apk --release

# Clean (if issues occur)
flutter clean
flutter pub get
```

## Time Estimates

- **Setup**: 5 minutes (with Flutter already installed)
- **First build**: 2-3 minutes
- **Subsequent builds**: 10-30 seconds
- **Hot reload**: < 1 second

---

**Ready to start?** Run `./setup.sh` or `flutter run` and enjoy! 🎰

For detailed requirements, see [REQUIREMENTS.md](REQUIREMENTS.md).
