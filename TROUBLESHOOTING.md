# Troubleshooting Guide / Guía de Solución de Problemas

## Common Issues / Problemas Comunes

### 1. Flutter Not Found / Flutter No Encontrado

**Error:** `flutter: command not found`

**Solution / Solución:**
```bash
# Add Flutter to PATH
export PATH="$PATH:/path/to/flutter/bin"

# For permanent setup, add to ~/.bashrc or ~/.zshrc
echo 'export PATH="$PATH:/path/to/flutter/bin"' >> ~/.bashrc
source ~/.bashrc
```

### 2. Network Issues During Installation / Problemas de Red

**Error:** `Failed to download https://storage.googleapis.com/...`

**Solutions / Soluciones:**

#### Option 1: Use Offline Mode
```bash
flutter pub get --offline
```

#### Option 2: Use China Mirror (if applicable)
```bash
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export PUB_HOSTED_URL=https://pub.flutter-io.cn
flutter pub get
```

#### Option 3: Use VPN or Proxy
Configure your network to access googleapis.com

#### Option 4: Manual Download
1. Visit https://pub.dev and download packages manually
2. Place in `~/.pub-cache/hosted/pub.dev/`
3. Run `flutter pub get --offline`

### 3. Dart SDK Issues / Problemas con Dart SDK

**Error:** `Dart SDK is not available`

**Solution / Solución:**
```bash
# Dart is included with Flutter, verify Flutter installation
flutter doctor -v

# If needed, download Dart separately
# https://dart.dev/get-dart
```

### 4. Android SDK Not Found / Android SDK No Encontrado

**Error:** `Android SDK not found`

**Solution / Solución:**
```bash
# Set ANDROID_HOME environment variable
export ANDROID_HOME=/path/to/android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Add to ~/.bashrc or ~/.zshrc for permanent setup
```

For Windows:
```
Set environment variable ANDROID_HOME to C:\Users\YourName\AppData\Local\Android\Sdk
```

### 5. Firebase Configuration Issues / Problemas de Configuración de Firebase

**Error:** `google-services.json not found`

**Solution / Solución:**
1. Create a Firebase project at https://console.firebase.google.com/
2. Add an Android app to your Firebase project
3. Download `google-services.json`
4. Place it in `android/app/google-services.json`

**Alternative / Alternativa:**
```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase automatically
flutterfire configure
```

### 6. Build Failures / Fallos de Compilación

**Error:** `Gradle build failed`

**Solutions / Soluciones:**

#### Clean and Rebuild
```bash
flutter clean
flutter pub get
flutter build apk
```

#### Check Java Version
```bash
java -version
# Should be Java 11 or higher
```

#### Update Gradle (in android/gradle/wrapper/gradle-wrapper.properties)
```properties
distributionUrl=https\://services.gradle.org/distributions/gradle-7.5-all.zip
```

### 7. Dependency Version Conflicts / Conflictos de Versiones

**Error:** `version solving failed`

**Solution / Solución:**
```bash
# Update dependencies
flutter pub upgrade

# If still failing, try
flutter pub outdated
flutter pub upgrade --major-versions

# Or manually edit pubspec.yaml to adjust version constraints
```

### 8. Camera Permission Issues / Problemas de Permisos de Cámara

**Error:** `Camera permission denied`

**Solution / Solución:**

Add to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-feature android:name="android.hardware.camera" />
```

Request permissions in code:
```dart
import 'package:permission_handler/permission_handler.dart';

await Permission.camera.request();
```

### 9. ML Kit OCR Not Working / ML Kit OCR No Funciona

**Error:** `ML Kit initialization failed`

**Solutions / Soluciones:**

1. Ensure minimum SDK version in `android/app/build.gradle`:
```gradle
minSdkVersion 24
```

2. Add ML Kit dependencies to `android/app/build.gradle`:
```gradle
dependencies {
    implementation 'com.google.mlkit:text-recognition:16.0.0'
}
```

### 10. Stripe Payment Issues / Problemas con Pagos Stripe

**Error:** `Stripe publishable key not set`

**Solution / Solución:**

In your app initialization:
```dart
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set your publishable key
  Stripe.publishableKey = 'pk_test_YOUR_KEY_HERE';
  await Stripe.instance.applySettings();
  
  runApp(MyApp());
}
```

**Note:** Never commit your secret key to version control!

### 11. iOS Build Issues (if applicable)

**Error:** `CocoaPods not installed`

**Solution / Solución:**
```bash
# Install CocoaPods
sudo gem install cocoapods

# Install pods
cd ios
pod install
cd ..
```

### 12. Hot Reload Not Working / Hot Reload No Funciona

**Solutions / Soluciones:**

1. Restart the app:
```bash
r  # Hot reload
R  # Hot restart
```

2. Full restart:
```bash
flutter run
```

3. Clear cache:
```bash
flutter clean
flutter pub get
flutter run
```

## Diagnostic Commands / Comandos de Diagnóstico

Run these commands to diagnose issues:

```bash
# Check Flutter installation
flutter doctor -v

# Check dependencies
./check_dependencies.sh

# Verify project structure
ls -la

# Check Flutter cache
flutter pub cache list

# Clear Flutter cache
flutter pub cache clean

# Repair Flutter installation
flutter doctor --android-licenses
```

## Getting Help / Obtener Ayuda

If you continue to experience issues:

1. **Check the documentation:**
   - [Flutter Documentation](https://docs.flutter.dev/)
   - [Firebase Flutter Documentation](https://firebase.flutter.dev/)
   - [Project README](README.md)
   - [Installation Guide](INSTALL.md)

2. **Run diagnostics:**
   ```bash
   ./check_dependencies.sh
   flutter doctor -v
   ```

3. **Search for similar issues:**
   - [Flutter GitHub Issues](https://github.com/flutter/flutter/issues)
   - [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)

4. **Create an issue:**
   - [Project Issues](https://github.com/Melampe001/Tokyoapps/issues)
   
   Include:
   - Error message
   - Output of `flutter doctor -v`
   - Steps to reproduce
   - OS and Flutter version

## System Requirements / Requisitos del Sistema

### Minimum Requirements
- **OS:** Windows 10/11, macOS 10.14+, Ubuntu 20.04+
- **RAM:** 4 GB (8 GB recommended)
- **Disk Space:** 3 GB (Flutter SDK + dependencies)
- **Screen:** 1280x720 minimum resolution

### Development Tools
- Flutter SDK 3.0.0+
- Dart SDK 3.0.0+
- Android Studio 2022.1+ OR VS Code 1.75+
- Java JDK 11+
- Git 2.30+

### For Android Development
- Android SDK API 24-35
- Android Build Tools 33.0.0+
- Android Emulator OR Physical device with USB debugging

### For iOS Development (Mac only)
- Xcode 14.0+
- CocoaPods 1.11+
- iOS Simulator OR Physical device

## Performance Tips / Consejos de Rendimiento

1. **Use Release Mode for Testing:**
   ```bash
   flutter run --release
   ```

2. **Enable Multidex for Android:**
   In `android/app/build.gradle`:
   ```gradle
   defaultConfig {
       multiDexEnabled true
   }
   ```

3. **Optimize Images:**
   - Use appropriate image sizes
   - Compress images before adding to assets
   - Consider using cached network images

4. **Profile Your App:**
   ```bash
   flutter run --profile
   flutter run --trace-startup
   ```

## Additional Resources / Recursos Adicionales

- [Flutter Community](https://flutter.dev/community)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)
- [Flutter YouTube Channel](https://www.youtube.com/@flutterdev)

---

**Last Updated:** November 2, 2025  
**Version:** 1.0.0
