# Environment Verification Checklist

Use this checklist to verify your development environment is properly configured for the Tokyo Roulette app.

## System Requirements

### Development Machine
- [ ] Operating System: Windows 10+, macOS 10.14+, or Linux Ubuntu 18.04+
- [ ] RAM: 8 GB minimum (16 GB recommended)
- [ ] Free Disk Space: 10 GB minimum
- [ ] Internet connection (for initial setup)

### Target Device
- [ ] Android device with API 24+ (Android 7.0+)
- [ ] Device has camera (for OCR feature)
- [ ] 2 GB RAM minimum
- [ ] 100 MB free storage

## Software Installation

### Core Development Tools

#### 1. Flutter SDK ✅
```bash
# Check Flutter version
flutter --version

# Expected: Flutter 3.0.0 or higher
```
- [ ] Flutter SDK installed and in PATH
- [ ] Flutter version is 3.0.0 or higher

#### 2. Dart SDK ✅
```bash
# Check Dart version
dart --version

# Expected: Dart 3.0.0 or higher (included with Flutter)
```
- [ ] Dart SDK available
- [ ] Dart version compatible with Flutter

#### 3. Java JDK ✅
```bash
# Check Java version
java -version

# Expected: Java 11 or higher
```
- [ ] Java JDK installed
- [ ] Java version is 11 or higher
- [ ] JAVA_HOME environment variable set (optional but recommended)

#### 4. Android SDK ✅
```bash
# Check Android SDK
flutter doctor -v | grep "Android SDK"

# Should show installed location and API levels
```
- [ ] Android SDK installed
- [ ] API Level 24 (Android 7.0) installed
- [ ] API Level 34 (Android 14) installed
- [ ] API Level 35 (Android 15) installed
- [ ] Android SDK Build-Tools installed
- [ ] Android SDK Platform-Tools installed

#### 5. Git ✅
```bash
# Check Git version
git --version

# Expected: Git 2.0 or higher
```
- [ ] Git installed and accessible

### Development IDE

Choose one (or both):

#### Option A: Android Studio
- [ ] Android Studio 2022.1+ installed
- [ ] Flutter plugin installed
- [ ] Dart plugin installed
- [ ] Android Virtual Device (AVD) Manager configured

#### Option B: Visual Studio Code
- [ ] VS Code 1.70+ installed
- [ ] Flutter extension installed
- [ ] Dart extension installed

## Flutter Doctor Check

### Run Complete Diagnostic
```bash
flutter doctor -v
```

### Flutter Doctor Checklist
- [ ] Flutter (Channel stable, 3.0.0+) ✓
- [ ] Android toolchain ✓
- [ ] Android Studio / VS Code ✓
- [ ] Connected device(s) ✓

**Note**: Some warnings (like iOS setup on non-Mac machines) are acceptable.

### Critical Issues to Fix
If `flutter doctor` shows any ✗ marks, fix these issues:

1. **✗ Android toolchain**
   ```bash
   flutter doctor --android-licenses
   # Accept all licenses
   ```

2. **✗ Android Studio not found**
   - Install Android Studio from https://developer.android.com/studio
   - Or set ANDROID_HOME environment variable

3. **✗ No devices available**
   - Start an emulator or connect a physical device

## Android Device/Emulator

### Physical Device Setup
- [ ] USB debugging enabled in Developer Options
- [ ] Device connected via USB
- [ ] Device appears in `flutter devices` output
- [ ] Device has Android 7.0 (API 24) or higher

### Emulator Setup
- [ ] At least one AVD created
- [ ] AVD has API 24+ system image
- [ ] Emulator starts successfully
- [ ] Emulator appears in `flutter devices` output

### Test Device Connection
```bash
flutter devices

# Expected output:
# 1 connected device:
# Android SDK built for x86 (mobile) • emulator-5554 • android-x86 • Android 11 (API 30)
```
- [ ] At least one device shown
- [ ] Device status is "connected" or "running"

## Project Setup

### Clone Repository ✅
```bash
git clone https://github.com/Melampe001/Tokyoapps.git
cd Tokyoapps
```
- [ ] Repository cloned successfully
- [ ] Currently in Tokyoapps directory

### Install Dependencies ✅
```bash
flutter pub get
```
- [ ] All packages downloaded
- [ ] No dependency conflicts
- [ ] pubspec.yaml is valid

### Verify Project Structure ✅
```bash
ls -la
```
Expected files/folders:
- [ ] `lib/` directory exists
- [ ] `android/` directory exists
- [ ] `pubspec.yaml` exists
- [ ] `README.md` exists
- [ ] `assets/` directory exists

## Firebase Configuration (Optional)

### Firebase Project
- [ ] Firebase project created at https://console.firebase.google.com
- [ ] Project name noted
- [ ] Authentication enabled
- [ ] Firestore Database created

### Firebase Configuration Files
- [ ] `android/app/google-services.json` exists (if using Firebase)
- [ ] `lib/firebase_options.dart` exists

### FlutterFire CLI (Recommended)
```bash
dart pub global activate flutterfire_cli
flutterfire configure
```
- [ ] FlutterFire CLI installed
- [ ] Firebase project selected
- [ ] Configuration files generated

**Note**: App works in offline mode without Firebase.

## Third-Party Services (Optional)

### Stripe Configuration
- [ ] Stripe account created (for payments)
- [ ] Test API keys obtained
- [ ] Keys added to `lib/utils/constants.dart` (or use demo mode)

### Google Cloud Platform
- [ ] ML Kit Text Recognition API enabled (for OCR)
- [ ] Billing enabled (required for production)

**Note**: Demo mode works without real API keys.

## Build & Test Verification

### Run Analysis ✅
```bash
flutter analyze
```
- [ ] No critical errors
- [ ] Warnings are acceptable

### Run Tests ✅
```bash
flutter test
```
- [ ] All tests pass
- [ ] No test failures

### Build Debug APK ✅
```bash
flutter build apk --debug
```
- [ ] Build completes successfully
- [ ] APK created at `build/app/outputs/flutter-apk/app-debug.apk`

### Run App ✅
```bash
flutter run
```
- [ ] App launches on device/emulator
- [ ] Main screen appears
- [ ] No immediate crashes
- [ ] Manual spin works
- [ ] Predictions display

## Permissions

### Android Manifest Permissions
Check `android/app/src/main/AndroidManifest.xml`:
- [ ] `android.permission.CAMERA` declared
- [ ] `android.permission.VIBRATE` declared
- [ ] `android.permission.INTERNET` declared
- [ ] `android.permission.ACCESS_NETWORK_STATE` declared

### Runtime Permissions
When running the app:
- [ ] Camera permission requested (on first camera use)
- [ ] Camera permission granted
- [ ] Vibration works on spin

## Performance Check

### Development Build Performance
- [ ] App launches in < 5 seconds (debug mode)
- [ ] UI is responsive
- [ ] Animations are smooth
- [ ] No visible lag

### Memory Usage
```bash
# While app is running
flutter run --profile
# Press 'P' to see performance overlay
```
- [ ] Memory usage < 200 MB (debug mode)
- [ ] No memory leaks during normal use

## Final Verification

### Complete Feature Test
- [ ] Manual spin generates numbers (0-36)
- [ ] Predictions panel shows recommendations
- [ ] Stats chart displays and animates
- [ ] Camera button accessible (camera spin)
- [ ] Subscription dialog opens
- [ ] App works in portrait orientation
- [ ] App works in landscape orientation
- [ ] History saves and persists

### Code Quality
```bash
flutter analyze
flutter test
flutter test --coverage
```
- [ ] No errors in analysis
- [ ] All tests pass
- [ ] Code coverage > 80% (optional)

## Troubleshooting

### Common Issues & Quick Fixes

**Issue**: Flutter command not found
```bash
# Add Flutter to PATH
export PATH="$PATH:/path/to/flutter/bin"
```

**Issue**: Android licenses not accepted
```bash
flutter doctor --android-licenses
```

**Issue**: No devices found
```bash
# Start emulator
emulator -list-avds
emulator -avd <avd-name>
```

**Issue**: Build fails
```bash
flutter clean
flutter pub get
flutter run
```

**Issue**: Gradle error
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

## Environment Ready ✅

Once all critical checkboxes (✅) are checked, your environment is ready!

### Summary
- Total checks: ~60
- Required checks: ~40 (critical ones)
- Optional checks: ~20 (Firebase, Stripe, advanced features)

### Next Steps
1. If all checks pass: Start developing! See [QUICK_START.md](QUICK_START.md)
2. If some checks fail: See [REQUIREMENTS.md](REQUIREMENTS.md) for detailed setup
3. If issues persist: Check [TROUBLESHOOTING.md] or open an issue

## Quick Reference

### Essential Commands
```bash
# Verify environment
flutter doctor -v

# Install dependencies
flutter pub get

# Run app
flutter run

# Run tests
flutter test

# Build release
flutter build apk --release

# Clean project
flutter clean
```

### Documentation Links
- [Flutter Installation](https://flutter.dev/docs/get-started/install)
- [Android Studio Setup](https://developer.android.com/studio)
- [Firebase Setup](https://firebase.google.com/docs/flutter/setup)
- [Stripe Flutter](https://stripe.com/docs/payments/accept-a-payment?platform=flutter)

---

**Last Updated**: November 2025  
**Status**: Active  

Print this checklist and verify each item before starting development!
