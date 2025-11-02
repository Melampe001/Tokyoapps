# Tokyo Roulette App - Deployment Guide

## Prerequisites

### Development Environment
- Flutter SDK 3.0.0 or higher
- Android Studio or VS Code with Flutter extensions
- Java JDK 11 or higher
- Android SDK with API 24-35
- Git

### Third-Party Services
1. **Firebase Project**
   - Authentication enabled
   - Firestore database
   - Storage (optional)
   
2. **Stripe Account**
   - Test and production API keys
   - Product IDs configured
   
3. **Google Cloud Platform**
   - ML Kit API enabled
   - Billing enabled

## Initial Setup

### 1. Clone Repository
```bash
git clone https://github.com/Melampe001/Tokyoapps.git
cd Tokyoapps
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Configure Firebase

#### Option A: Using FlutterFire CLI (Recommended)
```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase
flutterfire configure
```

#### Option B: Manual Configuration
1. Create Firebase project at https://console.firebase.google.com
2. Add Android app with package name: `com.tokyo.roulette_app`
3. Download `google-services.json`
4. Place in `android/app/google-services.json`
5. Update `lib/firebase_options.dart` with your configuration

### 4. Configure Stripe

Update `lib/utils/constants.dart`:
```dart
class AppConstants {
  static const String stripePublishableKey = 'pk_live_YOUR_KEY';
  static const String stripeSecretKey = 'sk_live_YOUR_KEY'; // Keep secure!
  
  // ... rest of constants
}
```

**Security Note**: Never commit secret keys to Git. Use environment variables or secure key management.

### 5. Set Up Environment Variables

Create `.env` file (already in `.gitignore`):
```env
STRIPE_PUBLISHABLE_KEY=pk_test_...
STRIPE_SECRET_KEY=sk_test_...
FIREBASE_API_KEY=AIza...
```

## Building for Android

### Development Build
```bash
flutter build apk --debug
```

### Release Build
```bash
flutter build apk --release
```

### App Bundle (for Google Play)
```bash
flutter build appbundle --release
```

## Code Signing

### Generate Keystore
```bash
keytool -genkey -v -keystore ~/upload-keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias upload
```

### Configure Signing

Create `android/key.properties`:
```properties
storePassword=<password>
keyPassword=<password>
keyAlias=upload
storeFile=/path/to/upload-keystore.jks
```

Update `android/app/build.gradle`:
```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

## Testing Before Release

### Run Tests
```bash
flutter test
flutter test --coverage
```

### Integration Tests
```bash
flutter drive --target=test_driver/app.dart
```

### Manual Testing
Follow the comprehensive checklist in `TESTING_GUIDE.md`:
- [ ] 500 manual spins
- [ ] 500 camera spins
- [ ] All numbers (0-36/00)
- [ ] Horizontal orientation
- [ ] Permissions
- [ ] Android 15+ compatibility
- [ ] Offline mode
- [ ] Freemium features

## Publishing to Google Play Store

### 1. Prepare Store Listing

**App Details**:
- App name: Tokyo Roulette Predictor
- Short description: AI-powered roulette prediction app
- Full description: (See template below)
- Category: Casino
- Content rating: Mature 17+ (Simulated Gambling)

**Graphics**:
- Icon: 512x512 PNG
- Feature graphic: 1024x500 PNG
- Screenshots: 2-8 phone screenshots (1080x1920)
- Screenshots: 2-8 tablet screenshots (1536x2048)

### 2. Create App Release

```bash
# Build release bundle
flutter build appbundle --release

# Output will be at:
# build/app/outputs/bundle/release/app-release.aab
```

### 3. Upload to Play Console

1. Go to https://play.google.com/console
2. Create new application
3. Upload app bundle
4. Complete store listing
5. Set up pricing & distribution
6. Submit for review

### 4. Configure In-App Products

**Product IDs**:
- `advanced_plan` - $199.00 (one-time purchase)
- `premium_plan` - $299.00 (one-time purchase)

**Descriptions**:
- Advanced: "Unlock Voisins du Zéro predictions and neighbor analysis"
- Premium: "Full access to all sectors and advanced strategies"

## Post-Deployment

### 1. Monitor Crashes

Use Firebase Crashlytics:
```bash
# Add to pubspec.yaml
firebase_crashlytics: ^3.4.9

# Initialize in main.dart
await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
```

### 2. Analytics

Track key metrics:
- Daily Active Users (DAU)
- Spin counts (manual vs camera)
- Subscription conversion rates
- Crash-free users percentage
- Average session duration

### 3. Update Strategy

**Regular Updates**:
- Bug fixes: As needed
- Feature updates: Monthly
- Major versions: Quarterly

**Version Numbering**:
- Format: MAJOR.MINOR.PATCH+BUILD
- Example: 1.2.3+45

### 4. User Support

Set up support channels:
- Email: support@example.com (configured in app)
- FAQ section in app
- GitHub Issues (for bugs)

## Continuous Integration/Deployment

### GitHub Actions Workflow

Create `.github/workflows/flutter-ci.yml`:

```yaml
name: Flutter CI/CD

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
      - run: flutter pub get
      - run: flutter analyze
      - run: flutter test --coverage
      
  build:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter build apk --release
      - uses: actions/upload-artifact@v3
        with:
          name: release-apk
          path: build/app/outputs/flutter-apk/app-release.apk
```

## Troubleshooting

### Common Issues

**Issue**: Build fails with "Firebase not configured"
**Solution**: Run `flutterfire configure` or manually add `google-services.json`

**Issue**: Camera permission denied
**Solution**: Ensure AndroidManifest.xml has camera permissions declared

**Issue**: Stripe payment fails
**Solution**: Check API keys are correct and not expired

**Issue**: App crashes on Android 15
**Solution**: Update targetSdk to 35 and test thoroughly

### Debug Commands
```bash
# View connected devices
flutter devices

# Run in debug mode
flutter run --debug

# View logs
flutter logs

# Build verbose output
flutter build apk --release --verbose
```

## Security Checklist

Before deployment:
- [ ] No API keys in source code
- [ ] Obfuscate code with `--obfuscate`
- [ ] Enable ProGuard/R8 for Android
- [ ] Secure Firebase database rules
- [ ] Use HTTPS for all network calls
- [ ] Validate all user inputs
- [ ] Implement rate limiting
- [ ] Use secure storage for sensitive data

## Compliance

### Legal Requirements
- Terms of Service
- Privacy Policy
- Cookie Policy (if web version)
- GDPR compliance (EU users)
- COPPA compliance (if targeting minors)
- Gambling regulations (by region)

### Age Rating
- Mature 17+ (due to simulated gambling)
- Not available in restricted regions

## Maintenance

### Regular Tasks
- [ ] Weekly: Review crash reports
- [ ] Weekly: Monitor analytics
- [ ] Monthly: Update dependencies
- [ ] Monthly: Security patches
- [ ] Quarterly: Feature releases
- [ ] Annually: Major version updates

## Rollback Plan

If issues occur post-deployment:

1. **Immediate**: Pause release in Play Console
2. **Quick Fix**: Deploy hotfix version
3. **Major Issue**: Revert to previous version
4. **Communication**: Notify users via release notes

## Success Metrics

Track these KPIs:
- Install rate
- Retention rate (Day 1, Day 7, Day 30)
- Subscription conversion rate
- Average revenue per user (ARPU)
- Customer satisfaction (ratings/reviews)

## Contact & Support

- GitHub: https://github.com/Melampe001/Tokyoapps
- Email: support@example.com
- Documentation: See README.md and IMPLEMENTATION.md

---

**Last Updated**: November 2025
**Version**: 1.0.0
