# Tokyo Roulette App - Complete Setup Guide

## 📋 Table of Contents
- [Prerequisites](#prerequisites)
- [Initial Setup](#initial-setup)
- [Firebase Configuration](#firebase-configuration)
- [Stripe Setup](#stripe-setup)
- [Google Play Console Setup](#google-play-console-setup)
- [Building the App](#building-the-app)
- [Testing](#testing)
- [Deployment](#deployment)
- [Troubleshooting](#troubleshooting)

## Prerequisites

### Required Software
1. **Flutter SDK** (3.0.0 or higher)
   ```bash
   # Verify installation
   flutter --version
   ```

2. **Android Studio** or **VS Code**
   - Android Studio: Includes Android SDK and emulators
   - VS Code: Install Flutter and Dart extensions

3. **Java JDK** (11 or higher)
   ```bash
   # Verify installation
   java -version
   ```

4. **Git**
   ```bash
   git --version
   ```

### Required Accounts
- [ ] Firebase account (free tier available)
- [ ] Stripe account (for payments)
- [ ] Google Play Console account (for Android deployment)
- [ ] GitHub account (for source control)

## Initial Setup

### 1. Clone the Repository
```bash
git clone https://github.com/Melampe001/Tokyoapps.git
cd Tokyoapps
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Configure Environment Variables
```bash
# Copy the environment template
cp .env.example .env

# Edit .env with your actual values
# See detailed instructions below for each service
```

## Firebase Configuration

### Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Enter project name: `tokyo-roulette-app`
4. Enable Google Analytics (optional)
5. Create project

### Step 2: Add Android App

1. In Firebase Console, click "Add app" → Android
2. Enter package name: `com.tokyo.rouletteApp`
3. Download `google-services.json`
4. Place it in: `android/app/google-services.json`
5. Follow the SDK setup instructions (already done in build.gradle)

### Step 3: Add iOS App (Optional)

1. In Firebase Console, click "Add app" → iOS
2. Enter bundle ID: `com.tokyo.rouletteApp`
3. Download `GoogleService-Info.plist`
4. Place it in: `ios/Runner/GoogleService-Info.plist`

### Step 4: Enable Firebase Services

#### Authentication
1. Go to Authentication → Sign-in method
2. Enable:
   - Email/Password
   - Anonymous (for demo mode)

#### Firestore Database
1. Go to Firestore Database
2. Click "Create database"
3. Start in production mode
4. Choose location (closest to your users)
5. Add security rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // User data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Spin history
    match /spins/{spinId} {
      allow read, write: if request.auth != null;
    }
    
    // Subscriptions
    match /subscriptions/{userId} {
      allow read: if request.auth != null && request.auth.uid == userId;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

#### Cloud Storage
1. Go to Storage
2. Click "Get started"
3. Use default security rules for now

#### Remote Config
1. Go to Remote Config
2. Add parameters as needed for feature flags

### Step 5: Update firebase_options.dart

Run FlutterFire CLI to auto-generate:
```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase for Flutter
flutterfire configure

# This will auto-update lib/firebase_options.dart
```

Or manually update `lib/firebase_options.dart` with values from Firebase Console.

### Step 6: Update .env File

Copy the values from Firebase Console to `.env`:
```
FIREBASE_ANDROID_API_KEY=<from Firebase Console>
FIREBASE_ANDROID_APP_ID=<from Firebase Console>
FIREBASE_PROJECT_ID=<from Firebase Console>
# ... etc
```

## Stripe Setup

### Step 1: Create Stripe Account

1. Go to [Stripe Dashboard](https://dashboard.stripe.com/)
2. Create an account
3. Complete business verification (required for live mode)

### Step 2: Get API Keys

1. Go to Developers → API keys
2. Copy **Publishable key** (starts with `pk_`)
3. Copy **Secret key** (starts with `sk_`)
4. Keep secret key secure - never commit to Git!

### Step 3: Create Products

1. Go to Products → Create product

**Advanced Plan:**
- Name: `Tokyo Roulette - Advanced`
- Price: `$199.00 USD`
- Recurring: No (one-time payment)
- Copy the Price ID (starts with `price_`)

**Premium Plan:**
- Name: `Tokyo Roulette - Premium`
- Price: `$299.00 USD`
- Recurring: No (one-time payment)
- Copy the Price ID (starts with `price_`)

### Step 4: Update Configuration

Update `lib/utils/constants.dart`:
```dart
class AppConstants {
  static const String stripePublishableKey = 'pk_test_YOUR_KEY'; // From Stripe Dashboard
  static const String stripeAdvancedPriceId = 'price_XXXXX'; // From Products
  static const String stripePremiumPriceId = 'price_YYYYY'; // From Products
}
```

Update `.env`:
```
STRIPE_PUBLISHABLE_KEY_TEST=pk_test_YOUR_KEY
STRIPE_SECRET_KEY_TEST=sk_test_YOUR_SECRET
STRIPE_PRODUCT_ID_ADVANCED=price_XXXXX
STRIPE_PRODUCT_ID_PREMIUM=price_YYYYY
```

### Step 5: Set Up Webhook (For Backend)

If using a backend for payment processing:

1. Go to Developers → Webhooks
2. Add endpoint: `https://your-api.com/stripe/webhook`
3. Select events:
   - `payment_intent.succeeded`
   - `payment_intent.payment_failed`
4. Copy webhook signing secret
5. Implement webhook handler in your backend

### Step 6: Test Payment Flow

Use test cards in test mode:
- Success: `4242 4242 4242 4242`
- Decline: `4000 0000 0000 0002`
- Requires auth: `4000 0025 0000 3155`

## Google Play Console Setup

### Step 1: Create Developer Account

1. Go to [Google Play Console](https://play.google.com/console/)
2. Pay one-time registration fee ($25 USD)
3. Complete account setup

### Step 2: Create App

1. Click "Create app"
2. App name: `Tokyo Roulette Predictor`
3. Default language: English (US)
4. App or game: App
5. Free or paid: Free (with in-app purchases)

### Step 3: Configure In-App Products

1. Go to Monetize → Products → In-app products
2. Create managed product:

**Advanced Plan:**
- Product ID: `advanced_plan`
- Name: `Advanced Predictions`
- Description: `Unlock Voisins du Zéro sector analysis and neighbor calculations`
- Price: `$199.00 USD`

**Premium Plan:**
- Product ID: `premium_plan`
- Name: `Premium Predictions`
- Description: `Unlock all sectors and advanced betting strategies`
- Price: `$299.00 USD`

3. Activate both products

### Step 4: Update App Configuration

Update `.env`:
```
PLAY_STORE_PRODUCT_ID_ADVANCED=advanced_plan
PLAY_STORE_PRODUCT_ID_PREMIUM=premium_plan
```

## Building the App

### Debug Build (Development)

```bash
# Run on connected device/emulator
flutter run

# Run with hot reload enabled
flutter run --debug
```

### Release Build (Production)

#### 1. Generate Keystore

```bash
keytool -genkey -v -keystore ~/tokyo-roulette-key.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias tokyo-roulette
```

Save the keystore file securely and remember the passwords!

#### 2. Create key.properties

Create `android/key.properties`:
```properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=tokyo-roulette
storeFile=/path/to/tokyo-roulette-key.jks
```

**IMPORTANT:** Never commit `key.properties` to Git! (Already in `.gitignore`)

#### 3. Build APK

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

#### 4. Build App Bundle (Recommended for Play Store)

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

## Testing

### Run Automated Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# View coverage report
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Manual Testing Checklist

Follow the comprehensive guide in `TESTING_GUIDE.md`:

- [ ] 500 manual spins recorded
- [ ] 500 camera spins recorded
- [ ] All numbers 0-36 and 00 tested
- [ ] Offline mode works
- [ ] Subscription upgrades work
- [ ] Camera permissions granted
- [ ] Horizontal orientation works
- [ ] Animations smooth (60 FPS)
- [ ] No crashes or errors

## Deployment

### Internal Testing

1. Build app bundle: `flutter build appbundle --release`
2. Go to Play Console → Testing → Internal testing
3. Upload `app-release.aab`
4. Add test users
5. Share test link with testers

### Production Release

1. Complete app content rating questionnaire
2. Set up privacy policy
3. Add screenshots and descriptions
4. Complete store listing
5. Go to Production → Create new release
6. Upload signed AAB
7. Review and roll out

### Post-Deployment Monitoring

- Monitor Firebase Crashlytics for crashes
- Track Analytics for user behavior
- Monitor Stripe dashboard for payments
- Check Play Console for reviews and ratings

## Troubleshooting

### Common Issues

#### Firebase not initializing
```
Error: Firebase initialization error
```
**Solution:** Ensure `google-services.json` is in `android/app/` and Firebase is properly configured.

#### Stripe key invalid
```
Error: Invalid Stripe publishable key
```
**Solution:** Verify the key in `lib/utils/constants.dart` matches your Stripe dashboard.

#### Camera permission denied
```
Error: Camera permission not granted
```
**Solution:** Grant camera permission in device settings or reinstall the app.

#### Build fails
```
Error: Execution failed for task ':app:processReleaseGoogleServices'
```
**Solution:** Ensure `google-services.json` is valid and package name matches.

#### OCR not working
```
Error: ML Kit initialization failed
```
**Solution:** Ensure Google Play Services are up to date on the device.

### Getting Help

1. Check existing issues: https://github.com/Melampe001/Tokyoapps/issues
2. Create new issue with:
   - Error message
   - Steps to reproduce
   - Flutter doctor output
   - Device information

## Additional Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Stripe Documentation](https://stripe.com/docs)
- [Google Play Console Help](https://support.google.com/googleplay/android-developer)

## Next Steps

After completing setup:
1. ✅ Review `IMPLEMENTATION.md` for architecture details
2. ✅ Read `TESTING_GUIDE.md` for testing procedures
3. ✅ Check `DEPLOYMENT.md` for deployment best practices
4. ✅ Start building features or customizing the app
5. ✅ Deploy to internal testing
6. ✅ Gather feedback and iterate
7. ✅ Launch to production!

---

**Last Updated:** November 2025  
**Version:** 1.0.0
