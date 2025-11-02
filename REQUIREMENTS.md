# Tokyo Roulette App - Requirements & Dependencies

## Overview
This document lists all requirements, dependencies, and configurations needed to run the Tokyo Roulette Predictor app today.

## System Requirements

### Operating System
- **Development**: Windows 10+, macOS 10.14+, or Linux (Ubuntu 18.04+)
- **Target Device**: Android 7.0 (API 24) to Android 15 (API 35)

### Hardware Requirements
- **Development Machine**:
  - 8 GB RAM minimum (16 GB recommended)
  - 10 GB free disk space
  - Processor: Intel Core i5 or equivalent
  
- **Target Device**:
  - Android device with camera
  - 2 GB RAM minimum
  - 100 MB free storage
  - Internet connection (optional - offline mode available)

## Software Dependencies

### 1. Flutter SDK
- **Version**: 3.0.0 or higher (3.16.0+ recommended)
- **Download**: https://flutter.dev/docs/get-started/install
- **Installation**:
  ```bash
  # Linux/macOS
  git clone https://github.com/flutter/flutter.git -b stable
  export PATH="$PATH:`pwd`/flutter/bin"
  flutter doctor
  
  # Windows
  # Download from flutter.dev and add to PATH
  ```

### 2. Development IDE
Choose one:
- **Android Studio** (Recommended)
  - Version: 2022.1 or higher
  - Flutter plugin installed
  - Dart plugin installed
  - Download: https://developer.android.com/studio
  
- **Visual Studio Code**
  - Version: 1.70 or higher
  - Extensions:
    - Flutter
    - Dart
    - Flutter Widget Snippets (optional)

### 3. Java Development Kit (JDK)
- **Version**: JDK 11 or higher (JDK 17 recommended)
- **Download**: https://adoptium.net/
- **Verification**:
  ```bash
  java -version
  ```

### 4. Android SDK
- **API Levels Required**:
  - Minimum: API 24 (Android 7.0)
  - Target: API 35 (Android 15)
  - Compile: API 34
- **Tools**:
  - Android SDK Build-Tools 34.0.0
  - Android SDK Platform-Tools
  - Android Emulator (for testing)

### 5. Git
- **Version**: 2.0 or higher
- **Download**: https://git-scm.com/downloads

## Flutter Package Dependencies

### Core Dependencies (from pubspec.yaml)

#### Firebase Services
```yaml
firebase_core: ^2.24.2          # Firebase initialization
firebase_auth: ^4.16.0          # User authentication
cloud_firestore: ^4.15.3        # Cloud database
firebase_remote_config: ^4.3.12 # Remote configuration
firebase_storage: ^11.6.0       # Cloud storage
```

#### Payment Processing
```yaml
flutter_stripe: ^10.1.1         # Stripe payment integration
```

#### Machine Learning & OCR
```yaml
google_mlkit_text_recognition: ^0.11.0  # Text recognition from camera
```

#### Camera & Image
```yaml
camera: ^0.10.5+9               # Camera access
image_picker: ^1.0.7            # Gallery image selection
```

#### Permissions
```yaml
permission_handler: ^11.2.0     # Android/iOS permissions
```

#### State Management
```yaml
provider: ^6.1.1                # MVVM state management
```

#### Local Storage
```yaml
shared_preferences: ^2.2.2      # Key-value storage
sqflite: ^2.3.2                 # SQL database
path_provider: ^2.1.2           # File system paths
```

#### UI & Charts
```yaml
fl_chart: ^0.66.0               # 3D animated charts
animations: ^2.0.11             # Smooth animations
```

#### Utilities
```yaml
intl: ^0.18.1                   # Internationalization
uuid: ^4.3.3                    # Unique ID generation
vibration: ^1.8.4               # Haptic feedback
geolocator: ^11.0.0             # Location services
http: ^1.2.0                    # HTTP requests
```

#### Development Dependencies
```yaml
flutter_test: sdk: flutter      # Testing framework
flutter_lints: ^3.0.1           # Linting rules
```

## Third-Party Service Accounts

### 1. Firebase (Required)
- **Project Setup**: https://console.firebase.google.com
- **Services Needed**:
  - Authentication (Anonymous + Email/Password)
  - Firestore Database
  - Storage (optional)
  - Remote Config (optional)
  
- **Configuration Files**:
  - `android/app/google-services.json`
  - `lib/firebase_options.dart`

- **Setup Steps**:
  ```bash
  # Install FlutterFire CLI
  dart pub global activate flutterfire_cli
  
  # Configure Firebase
  flutterfire configure
  ```

### 2. Stripe (Required for Payments)
- **Account**: https://stripe.com
- **API Keys Needed**:
  - Publishable Key (pk_test_... or pk_live_...)
  - Secret Key (sk_test_... or sk_live_...)
  
- **Products to Create**:
  - Advanced Plan: $199.00 (one-time)
  - Premium Plan: $299.00 (one-time)

- **Configuration**:
  - Update `lib/utils/constants.dart` with your keys
  - Set up backend for payment intents

### 3. Google Cloud Platform (Required for ML Kit)
- **Project**: Same as Firebase project
- **APIs to Enable**:
  - ML Kit Text Recognition API
  - Cloud Vision API (optional)
  
- **Billing**: Must be enabled for production use

## Android Manifest Permissions

Required permissions in `android/app/src/main/AndroidManifest.xml`:

```xml
<!-- Camera for OCR -->
<uses-permission android:name="android.permission.CAMERA" />
<uses-feature android:name="android.hardware.camera" android:required="false" />

<!-- Vibration for haptic feedback -->
<uses-permission android:name="android.permission.VIBRATE" />

<!-- Internet for Firebase and Stripe -->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

<!-- Storage for local database -->
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" android:maxSdkVersion="28" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" android:maxSdkVersion="32" />

<!-- Location for regional checks (optional) -->
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
```

## Installation & Setup

### Quick Start (5 minutes)

1. **Clone Repository**
   ```bash
   git clone https://github.com/Melampe001/Tokyoapps.git
   cd Tokyoapps
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase** (Choose one option)
   
   **Option A: Using FlutterFire CLI (Recommended)**
   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```
   
   **Option B: Manual Setup**
   - Create Firebase project at https://console.firebase.google.com
   - Download `google-services.json`
   - Place in `android/app/google-services.json`
   - Update `lib/firebase_options.dart`

4. **Configure Stripe** (Optional - Demo mode works without this)
   - Update `lib/utils/constants.dart` with your Stripe keys
   - Or leave as demo mode for testing

5. **Run the App**
   ```bash
   # Connect Android device or start emulator
   flutter devices
   
   # Run app
   flutter run
   ```

### Development Environment Setup (15 minutes)

1. **Install Flutter**
   ```bash
   # Verify installation
   flutter doctor -v
   ```
   Fix any issues reported by `flutter doctor`.

2. **Configure IDE**
   - **Android Studio**: Install Flutter & Dart plugins
   - **VS Code**: Install Flutter & Dart extensions

3. **Set up Android Device**
   - Enable Developer Options
   - Enable USB Debugging
   - Connect via USB or WiFi

4. **Verify Setup**
   ```bash
   flutter doctor
   flutter devices
   flutter pub get
   flutter analyze
   flutter test
   ```

## Build Requirements

### Debug Build
```bash
flutter build apk --debug
```
No additional requirements.

### Release Build
```bash
flutter build apk --release
```

**Additional Requirements**:
- Keystore file for code signing
- `android/key.properties` configuration

**Create Keystore**:
```bash
keytool -genkey -v -keystore ~/upload-keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias upload
```

**Configure Signing** (`android/key.properties`):
```properties
storePassword=<your-password>
keyPassword=<your-password>
keyAlias=upload
storeFile=/path/to/upload-keystore.jks
```

## Environment Variables (Optional)

Create `.env` file (add to `.gitignore`):
```env
STRIPE_PUBLISHABLE_KEY=pk_test_...
STRIPE_SECRET_KEY=sk_test_...
FIREBASE_API_KEY=AIza...
```

## Verification Checklist

Before running the app, ensure:

- [ ] Flutter SDK installed and in PATH
- [ ] `flutter doctor` shows no critical issues
- [ ] Android SDK installed (API 24-35)
- [ ] Java JDK 11+ installed
- [ ] Firebase project created
- [ ] `google-services.json` in `android/app/`
- [ ] Flutter dependencies installed (`flutter pub get`)
- [ ] Android device connected or emulator running
- [ ] Camera permission will be granted (for OCR features)
- [ ] Internet connection available (for Firebase, optional)

## Testing Requirements

### Automated Testing
```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Specific test file
flutter test test/services/rng_service_test.dart
```

**Test Files**:
- `test/services/rng_service_test.dart`
- `test/services/prediction_service_test.dart`
- `test/models/spin_result_test.dart`

### Manual Testing Requirements
- 500 manual spins recorded
- 500 camera spins recorded (requires camera)
- All numbers 0-36 tested (European roulette)
- Number 00 tested (American roulette)
- Horizontal orientation tested
- Offline mode tested

See [TESTING_GUIDE.md](TESTING_GUIDE.md) for comprehensive testing procedures.

## Common Issues & Solutions

### Issue: "Flutter command not found"
**Solution**: Add Flutter to your PATH
```bash
export PATH="$PATH:/path/to/flutter/bin"
```

### Issue: "Android license status unknown"
**Solution**: Accept Android licenses
```bash
flutter doctor --android-licenses
```

### Issue: "Firebase not configured"
**Solution**: Run FlutterFire configuration
```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

### Issue: "Camera permission denied"
**Solution**: 
1. Check AndroidManifest.xml has camera permissions
2. Grant permission when app prompts
3. Or manually enable in device settings

### Issue: "Stripe payment fails"
**Solution**: 
- Verify API keys in `lib/utils/constants.dart`
- Use test keys for development
- Ensure backend is configured for payment intents

### Issue: "Build fails with Gradle error"
**Solution**:
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter build apk
```

### Issue: "ML Kit text recognition not working"
**Solution**:
- Ensure ML Kit API is enabled in Google Cloud Console
- Check camera permissions are granted
- Verify image quality is good (proper lighting)
- Test with clear, high-contrast numbers

## Minimum Viable Setup (Quick Demo)

For a quick demo without full configuration:

1. **Clone & Install**
   ```bash
   git clone https://github.com/Melampe001/Tokyoapps.git
   cd Tokyoapps
   flutter pub get
   ```

2. **Skip Firebase** (App has fallback)
   - Skip `flutterfire configure`
   - App will work in offline mode

3. **Skip Stripe** (Demo mode)
   - Leave default demo keys
   - Subscriptions will auto-upgrade in demo mode

4. **Run**
   ```bash
   flutter run
   ```

**Limitations of Quick Demo**:
- No cloud sync
- No real payments
- Camera OCR might not work without ML Kit setup

## Production Requirements

For production deployment, additionally ensure:

- [ ] Production Firebase project configured
- [ ] Production Stripe keys configured
- [ ] App signed with release keystore
- [ ] ProGuard/R8 obfuscation enabled
- [ ] Firebase Crashlytics set up
- [ ] Analytics configured
- [ ] Privacy policy and terms of service added
- [ ] Google Play Store listing prepared
- [ ] App tested on multiple devices
- [ ] Security audit completed

See [DEPLOYMENT.md](DEPLOYMENT.md) for full production deployment guide.

## Support & Documentation

- **README**: [README.md](README.md) - Project overview
- **Implementation**: [IMPLEMENTATION.md](IMPLEMENTATION.md) - Technical details
- **Testing**: [TESTING_GUIDE.md](TESTING_GUIDE.md) - Testing procedures
- **Deployment**: [DEPLOYMENT.md](DEPLOYMENT.md) - Build and deployment
- **Issues**: https://github.com/Melampe001/Tokyoapps/issues

## Version Information

- **Flutter Version**: 3.0.0+ (3.16.0+ recommended)
- **Dart Version**: >=3.0.0 <4.0.0
- **Android API**: 24 (min) to 35 (target)
- **App Version**: 1.0.0+1

---

**Last Updated**: November 2025  
**Status**: Production Ready
