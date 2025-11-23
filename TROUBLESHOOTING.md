# Tokyo Roulette App - Troubleshooting Guide

This guide helps you resolve common issues encountered during development, testing, and deployment.

## 📋 Table of Contents
- [Development Issues](#development-issues)
- [Build Issues](#build-issues)
- [Firebase Issues](#firebase-issues)
- [Stripe Issues](#stripe-issues)
- [Camera/OCR Issues](#cameraocr-issues)
- [Testing Issues](#testing-issues)
- [Deployment Issues](#deployment-issues)
- [Runtime Issues](#runtime-issues)

## Development Issues

### Flutter not found
```
bash: flutter: command not found
```

**Solution:**
1. Install Flutter SDK: https://docs.flutter.dev/get-started/install
2. Add Flutter to PATH:
   ```bash
   export PATH="$PATH:`pwd`/flutter/bin"
   ```
3. Verify: `flutter --version`

### Flutter doctor issues
```
[!] Android toolchain - develop for Android devices
```

**Solution:**
1. Install Android Studio
2. Install Android SDK
3. Accept licenses: `flutter doctor --android-licenses`
4. Run: `flutter doctor -v`

### Pub get fails
```
Error: Unable to resolve dependency
```

**Solution:**
```bash
flutter clean
rm -rf .dart_tool/
rm pubspec.lock
flutter pub get
```

### IDE not recognizing Flutter
**Solution for VS Code:**
1. Install Flutter extension
2. Install Dart extension
3. Reload VS Code
4. Run: `Flutter: Get Packages` from command palette

**Solution for Android Studio:**
1. Install Flutter plugin
2. Install Dart plugin
3. Restart Android Studio
4. File → Sync Project with Gradle Files

## Build Issues

### Build fails with gradle error
```
FAILURE: Build failed with an exception
```

**Solution:**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter build apk
```

### Out of memory during build
```
Java heap space
```

**Solution:**
Edit `android/gradle.properties`:
```properties
org.gradle.jvmargs=-Xmx4096M -XX:MaxPermSize=1024m -XX:+HeapDumpOnOutOfMemoryError
```

### MultiDex error
```
Cannot fit requested classes in a single dex file
```

**Solution:**
Already configured in `android/app/build.gradle`. If still occurs:
```gradle
android {
    defaultConfig {
        multiDexEnabled true
        minSdkVersion 21  // or higher
    }
}
```

### Keystore not found
```
FileNotFoundException: key.properties
```

**Solution for development:**
Remove signing config temporarily or create dummy `key.properties`

**Solution for production:**
1. Generate keystore (see SETUP_GUIDE.md)
2. Create `android/key.properties`
3. Never commit to Git!

### Wrong package name
```
Error: Package name doesn't match
```

**Solution:**
Check `android/app/build.gradle`:
```gradle
applicationId "com.tokyo.rouletteApp"
```

Must match Firebase and Play Console configuration.

## Firebase Issues

### Firebase not initializing
```
[core/no-app] No Firebase App '[DEFAULT]' has been created
```

**Solution:**
1. Ensure `google-services.json` exists in `android/app/`
2. Check `android/app/build.gradle` has:
   ```gradle
   apply plugin: 'com.google.gms.google-services'
   ```
3. Verify Firebase initialized in `main.dart`:
   ```dart
   await Firebase.initializeApp();
   ```

### google-services.json missing
```
File google-services.json is missing
```

**Solution:**
1. Download from Firebase Console
2. Place in `android/app/google-services.json`
3. Rebuild app

### Firebase configuration incorrect
```
Error: Firebase project not configured
```

**Solution:**
```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Reconfigure Firebase
flutterfire configure
```

### Firestore permission denied
```
Missing or insufficient permissions
```

**Solution:**
Update Firestore security rules:
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

### Firebase Auth fails
```
Error: User not authenticated
```

**Solution:**
1. Enable Authentication in Firebase Console
2. Enable sign-in methods (Email/Password, Anonymous)
3. Check auth state before operations

## Stripe Issues

### Invalid publishable key
```
Error: Invalid Stripe publishable key
```

**Solution:**
1. Get key from Stripe Dashboard → Developers → API Keys
2. Update `lib/utils/constants.dart`:
   ```dart
   static const String stripePublishableKey = 'pk_test_YOUR_KEY';
   ```
3. Use test key for development, live key for production

### Payment sheet won't open
```
Error: Payment sheet initialization failed
```

**Solution:**
1. Verify Stripe SDK initialized in `main.dart`
2. Check publishable key is set before opening sheet
3. Ensure backend creates valid payment intent

### Test card declined
```
Payment failed: Card declined
```

**Solution:**
Use test cards:
- Success: `4242 4242 4242 4242`
- Decline: `4000 0000 0000 0002`
- Any future date, any CVC

### Webhook not receiving events
```
Warning: Webhook delivery failed
```

**Solution:**
1. Check webhook URL is accessible
2. Verify webhook secret matches
3. Test with Stripe CLI:
   ```bash
   stripe listen --forward-to localhost:3000/webhook
   ```

## Camera/OCR Issues

### Camera permission denied
```
Error: Camera permission not granted
```

**Solution:**
1. Check `AndroidManifest.xml` has:
   ```xml
   <uses-permission android:name="android.permission.CAMERA"/>
   ```
2. Request permission at runtime (already implemented)
3. Grant in device settings if denied

### Camera not opening
```
Error: Camera unavailable
```

**Solution:**
1. Test on real device (emulator cameras often buggy)
2. Ensure camera permission granted
3. Check another app can use camera
4. Restart device

### OCR not recognizing numbers
```
Error: No text detected
```

**Solution:**
1. Improve lighting conditions
2. Hold camera steady
3. Ensure number is clear and large
4. Try printed numbers instead of handwritten
5. Adjust camera distance (6-12 inches optimal)

### ML Kit initialization failed
```
Error: ML Kit not initialized
```

**Solution:**
1. Ensure Google Play Services updated on device
2. Check internet connection (first time download)
3. Try:
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

## Testing Issues

### Tests fail to run
```
Error: Test file not found
```

**Solution:**
```bash
flutter pub get
flutter test
```

### Tests timeout
```
Error: Test timed out
```

**Solution:**
Increase timeout in test:
```dart
test('description', () async {
  // ...
}, timeout: Timeout(Duration(seconds: 30)));
```

### Mock data issues
```
Error: Null check operator used on null value
```

**Solution:**
Ensure all required fields initialized in test mocks:
```dart
final mockSpinResult = SpinResult(
  number: 17,
  timestamp: DateTime.now(),
  // ... all required fields
);
```

### Coverage not generating
```
Error: lcov not found
```

**Solution:**
Install lcov:
```bash
# Ubuntu/Debian
sudo apt-get install lcov

# macOS
brew install lcov
```

## Deployment Issues

### App upload rejected
```
Error: Upload failed
```

**Solution:**
1. Check version code is higher than previous
2. Ensure app signed with correct key
3. Verify app bundle valid:
   ```bash
   bundletool validate --bundle=app-release.aab
   ```

### Version code conflict
```
Error: Version code already exists
```

**Solution:**
Increment version code in `pubspec.yaml`:
```yaml
version: 1.0.1+2  # version+build number
```

### ProGuard issues
```
Error: Class not found at runtime
```

**Solution:**
Add ProGuard rules in `android/app/proguard-rules.pro`:
```
-keep class com.tokyo.rouletteApp.** { *; }
-keep class io.flutter.** { *; }
```

### In-app products not found
```
Error: Product ID not found
```

**Solution:**
1. Create products in Play Console
2. Activate products
3. Wait 2-4 hours for propagation
4. Ensure product IDs match exactly in code

## Runtime Issues

### App crashes on startup
**Check crash logs:**
```bash
adb logcat | grep -i flutter
```

**Common causes:**
1. Firebase not initialized properly
2. Missing dependencies
3. Null pointer exceptions
4. Asset loading errors

**Solution:**
1. Check logs for specific error
2. Ensure all dependencies in `pubspec.yaml`
3. Run `flutter clean && flutter pub get`
4. Rebuild and test

### Memory leak
```
Warning: Growing memory usage
```

**Solution:**
1. Dispose controllers in `dispose()` method
2. Cancel stream subscriptions
3. Clear large lists when not needed
4. Use `const` constructors where possible

### Performance issues
**Symptoms:**
- Slow animations
- Laggy UI
- High battery usage

**Solution:**
1. Use DevTools performance view
2. Reduce widget rebuilds
3. Optimize images
4. Use const widgets
5. Profile in release mode

### Database locked error
```
Error: database is locked
```

**Solution:**
Ensure single database connection:
```dart
// Use singleton pattern for database
class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();
}
```

### Network timeout
```
Error: Connection timeout
```

**Solution:**
1. Check internet connection
2. Increase timeout:
   ```dart
   final response = await http.get(
     uri,
     headers: headers,
   ).timeout(Duration(seconds: 30));
   ```
3. Add retry logic
4. Handle offline gracefully

## Getting More Help

### Check Logs
```bash
# Flutter logs
flutter logs

# Android logs
adb logcat | grep flutter

# Filter by error
adb logcat | grep -i error
```

### Debug Information
When asking for help, provide:
1. Flutter version: `flutter --version`
2. Doctor output: `flutter doctor -v`
3. Error messages (full stack trace)
4. Steps to reproduce
5. Device/emulator information

### Resources
- **Flutter Documentation:** https://docs.flutter.dev/
- **Firebase Support:** https://firebase.google.com/support
- **Stripe Support:** https://support.stripe.com/
- **Stack Overflow:** Tag your questions with `flutter`, `dart`, `firebase`
- **GitHub Issues:** https://github.com/Melampe001/Tokyoapps/issues

### Community
- Flutter Discord: https://discord.gg/flutter
- Flutter Reddit: r/FlutterDev
- Firebase Discord: https://discord.gg/firebase

## Still Stuck?

1. Search GitHub issues for similar problems
2. Create a new issue with:
   - Clear description
   - Steps to reproduce
   - Error messages
   - System information
   - What you've tried

---

**Remember:** Most issues have been encountered by others. Search first, then ask!
