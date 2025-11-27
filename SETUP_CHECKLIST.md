# Tokyo Roulette App - Setup Checklist

Print this checklist and mark off each step as you complete it.

## Pre-Setup Verification

- [ ] **Computer Requirements**
  - [ ] 8 GB RAM (16 GB recommended)
  - [ ] 10 GB free disk space
  - [ ] Internet connection

- [ ] **Operating System**
  - [ ] Windows 10+, macOS 10.14+, or Linux Ubuntu 18.04+

## Step 1: Install Required Software

- [ ] **Flutter SDK 3.0.0+**
  - [ ] Downloaded from https://flutter.dev
  - [ ] Extracted to a permanent location
  - [ ] Added to PATH
  - [ ] Verified: `flutter --version` works

- [ ] **Java JDK 11+**
  - [ ] Downloaded from https://adoptium.net
  - [ ] Installed
  - [ ] Verified: `java -version` shows 11 or higher

- [ ] **Android Studio OR VS Code**
  - [ ] Android Studio 2022.1+ installed, OR
  - [ ] VS Code 1.70+ installed
  - [ ] Flutter plugin/extension installed
  - [ ] Dart plugin/extension installed

- [ ] **Android SDK**
  - [ ] Android SDK installed (comes with Android Studio)
  - [ ] API Level 24 installed
  - [ ] API Level 34 installed
  - [ ] API Level 35 installed
  - [ ] Android licenses accepted: `flutter doctor --android-licenses`

- [ ] **Git**
  - [ ] Git 2.0+ installed
  - [ ] Verified: `git --version` works

## Step 2: Verify Flutter Installation

- [ ] **Run Flutter Doctor**
  ```bash
  flutter doctor -v
  ```
  - [ ] Flutter: ✓ (green checkmark)
  - [ ] Android toolchain: ✓
  - [ ] IDE: ✓ (Android Studio or VS Code)
  - [ ] Connected device: ✓ (or will add later)

## Step 3: Setup Android Device or Emulator

**Choose One:**

### Option A: Physical Device
- [ ] Android device with API 24+ (Android 7.0+)
- [ ] USB debugging enabled in Developer Options
- [ ] Device connected via USB
- [ ] Device appears in `flutter devices`

### Option B: Emulator
- [ ] Created AVD in Android Studio
- [ ] AVD has API 24+ system image
- [ ] Emulator started successfully
- [ ] Emulator appears in `flutter devices`

## Step 4: Clone Repository

- [ ] **Clone the Repository**
  ```bash
  git clone https://github.com/Melampe001/Tokyoapps.git
  cd Tokyoapps
  ```
  - [ ] Repository cloned successfully
  - [ ] Currently in Tokyoapps directory

## Step 5: Run Setup Script (Recommended)

### Linux/macOS Users
- [ ] **Run Automated Setup**
  ```bash
  ./setup.sh
  ```
  - [ ] Script completed successfully
  - [ ] No critical errors reported

### Windows Users (Manual Setup)
- [ ] **Install Dependencies**
  ```bash
  flutter pub get
  ```
  - [ ] All packages downloaded
  - [ ] No dependency conflicts

## Step 6: Firebase Configuration (Optional)

**Choose Your Approach:**

### Option A: Use Firebase (Recommended)
- [ ] **Create Firebase Project**
  - [ ] Go to https://console.firebase.google.com
  - [ ] Create new project
  - [ ] Project name noted: ________________

- [ ] **Configure with FlutterFire CLI**
  ```bash
  dart pub global activate flutterfire_cli
  flutterfire configure
  ```
  - [ ] FlutterFire CLI installed
  - [ ] Firebase project selected
  - [ ] `google-services.json` created in `android/app/`
  - [ ] `firebase_options.dart` created in `lib/`

### Option B: Skip Firebase (Offline Mode)
- [ ] Understand the app will work in offline mode only
- [ ] No cloud sync available
- [ ] Continue without Firebase setup

## Step 7: Stripe Configuration (Optional)

**Choose Your Approach:**

### Option A: Use Demo Mode (Recommended for Testing)
- [ ] Leave default demo keys
- [ ] Subscriptions will auto-upgrade in demo mode
- [ ] No real payments processed

### Option B: Configure Real Stripe
- [ ] Stripe account created at https://stripe.com
- [ ] Test API keys obtained
- [ ] Keys added to `lib/utils/constants.dart`

## Step 8: Verify Installation

- [ ] **Run Analysis**
  ```bash
  flutter analyze
  ```
  - [ ] No critical errors

- [ ] **Run Tests**
  ```bash
  flutter test
  ```
  - [ ] All tests pass

## Step 9: Build Debug Version

- [ ] **Build APK**
  ```bash
  flutter build apk --debug
  ```
  - [ ] Build completed successfully
  - [ ] APK created at `build/app/outputs/flutter-apk/app-debug.apk`

## Step 10: Run the App

- [ ] **Launch the App**
  ```bash
  flutter run
  ```
  - [ ] Build completed (first build takes 2-3 minutes)
  - [ ] App launched on device/emulator
  - [ ] Main screen appears

## Step 11: Grant Permissions

- [ ] **Camera Permission**
  - [ ] Permission prompt appears (on first camera use)
  - [ ] Permission granted

- [ ] **Vibration** (Automatic)
  - [ ] Vibration works on spin (if device supports)

## Step 12: Test Basic Functionality

- [ ] **Manual Spin**
  - [ ] Tap "MANUAL SPIN" button
  - [ ] Number appears (0-36)
  - [ ] Prediction panel shows recommendations
  - [ ] Vibration felt (if enabled)

- [ ] **View Statistics**
  - [ ] Tap chart icon
  - [ ] Statistics screen appears
  - [ ] Chart animates smoothly

- [ ] **Camera Spin** (if camera available)
  - [ ] Tap "CAMERA SPIN" button
  - [ ] Camera permission granted
  - [ ] Camera preview appears

- [ ] **Subscription Dialog**
  - [ ] Tap subscription badge
  - [ ] Upgrade dialog appears
  - [ ] Can select tier (demo mode auto-upgrades)

- [ ] **Orientation**
  - [ ] App works in portrait
  - [ ] App works in landscape
  - [ ] Layout adapts correctly

## Step 13: Verify Hot Reload (Development)

- [ ] **Test Hot Reload**
  - [ ] App is running
  - [ ] Make a small code change (e.g., change a color)
  - [ ] Save the file
  - [ ] Press `r` in terminal
  - [ ] Change appears instantly

## Troubleshooting (If Needed)

### If Flutter Doctor Shows Errors
- [ ] Review error messages
- [ ] Run suggested fix commands
- [ ] Accept Android licenses: `flutter doctor --android-licenses`
- [ ] Re-run `flutter doctor -v`

### If No Devices Found
- [ ] Check USB connection (physical device)
- [ ] Start emulator (virtual device)
- [ ] Run `flutter devices` to verify

### If Build Fails
- [ ] Run cleanup commands:
  ```bash
  flutter clean
  flutter pub get
  flutter run
  ```

### If App Crashes
- [ ] Check terminal for error messages
- [ ] Review logs: `flutter logs`
- [ ] Ensure device API level is 24+

### If Camera Doesn't Work
- [ ] Verify camera permission granted
- [ ] Check AndroidManifest.xml has camera permissions
- [ ] Test on physical device (some emulators have issues)

## Optional: Production Build

- [ ] **Create Release Keystore**
  ```bash
  keytool -genkey -v -keystore ~/upload-keystore.jks \
    -keyalg RSA -keysize 2048 -validity 10000 \
    -alias upload
  ```

- [ ] **Configure Signing**
  - [ ] Create `android/key.properties`
  - [ ] Add keystore details
  - [ ] Update `build.gradle`

- [ ] **Build Release APK**
  ```bash
  flutter build apk --release
  ```
  - [ ] Build successful
  - [ ] APK at `build/app/outputs/flutter-apk/app-release.apk`

## Documentation Reference

### Have Issues?
- [ ] **Common Issues**: See [QUICK_START.md](QUICK_START.md)
- [ ] **Requirements**: See [REQUIREMENTS.md](REQUIREMENTS.md)
- [ ] **Environment Check**: See [ENVIRONMENT_CHECK.md](ENVIRONMENT_CHECK.md)
- [ ] **All Docs**: See [DOCUMENTATION_INDEX.md](DOCUMENTATION_INDEX.md)

### Want to Learn More?
- [ ] **Architecture**: See [IMPLEMENTATION.md](IMPLEMENTATION.md)
- [ ] **Testing**: See [TESTING_GUIDE.md](TESTING_GUIDE.md)
- [ ] **Deployment**: See [DEPLOYMENT.md](DEPLOYMENT.md)

## Setup Complete! 🎉

### What You've Accomplished
- [x] Development environment configured
- [x] App running on device/emulator
- [x] Basic features tested
- [x] Ready to develop or use the app

### Next Steps

**For Developers:**
1. Read [IMPLEMENTATION.md](IMPLEMENTATION.md) to understand the architecture
2. Explore the `lib/` directory
3. Make changes and use hot reload
4. Run tests before committing

**For Testers:**
1. Follow [TESTING_GUIDE.md](TESTING_GUIDE.md)
2. Test all features systematically
3. Report issues on GitHub

**For Users:**
1. Start using the app
2. Try all features
3. Provide feedback

### Time Spent
- **Estimated Total Time**: ________________
- **Actual Time Spent**: ________________

### Notes
Record any issues or special configurations:

```
_______________________________________________
_______________________________________________
_______________________________________________
_______________________________________________
_______________________________________________
```

---

**Setup Date**: ________________  
**Completed By**: ________________  
**App Version**: 1.0.0  

**Congratulations! Your environment is ready.** 🚀
