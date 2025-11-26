# Tokyo Roulette App - Demo Mode Guide

## Overview

The Tokyo Roulette app includes a **DEMO MODE** that allows you to run and test the app without configuring Firebase or Stripe. This is perfect for:

- **Development and testing** - Test features without backend setup
- **Demonstrations** - Show the app functionality to stakeholders
- **Quick start** - Get the app running immediately
- **Offline testing** - Test without internet connectivity

## Enabling Demo Mode

Demo mode is controlled by the `DemoMode` class in `lib/utils/demo_mode.dart`:

```dart
class DemoMode {
  // Set to true to enable demo mode (no Firebase/Stripe required)
  static const bool enabled = true;
  
  // Demo mode is also automatically enabled in debug builds
  static bool get isEnabled => enabled || kDebugMode;
}
```

### Configuration Options

1. **Always Demo Mode**: Set `enabled = true` in `demo_mode.dart`
2. **Debug Only**: Set `enabled = false` - demo mode will only activate in debug builds
3. **Production**: Set `enabled = false` and use release build for production with real Firebase/Stripe

## What Works in Demo Mode

### ✅ Fully Functional Features

All core app features work perfectly in demo mode:

#### 1. **Roulette Simulation**
- ✅ European roulette (0-36)
- ✅ American roulette (0-36 + 00)
- ✅ Manual spins with weighted RNG
- ✅ Cryptographically secure random generation
- ✅ Full spin history tracking

#### 2. **AI Predictions**
- ✅ Hot/cold number analysis
- ✅ Sector predictions (Voisins du Zéro, Tiers, Orphelins, Jeu Zéro)
- ✅ Neighbor calculations
- ✅ Confidence scores
- ✅ All three subscription tiers (Free, Advanced, Premium)

#### 3. **Camera OCR**
- ✅ Camera initialization
- ✅ Number recognition from images
- ✅ Real-time capture
- ✅ Validation and error handling

#### 4. **Statistics & Charts**
- ✅ 3D animated bar charts
- ✅ Number frequency analysis
- ✅ Color-coded statistics
- ✅ Sector frequency tracking
- ✅ Real-time updates

#### 5. **User Interface**
- ✅ Neon red/black/green theme
- ✅ Glowing effects
- ✅ Smooth animations
- ✅ Portrait and landscape modes
- ✅ Responsive layouts

#### 6. **Data Storage**
- ✅ Local SQLite database
- ✅ Offline-first architecture
- ✅ Spin history persistence
- ✅ Subscription state saved locally
- ✅ All data accessible without internet

#### 7. **Subscription Management**
- ✅ View all three tiers
- ✅ Instant tier upgrades (simulated)
- ✅ Feature unlocking
- ✅ Tier-specific predictions
- ✅ Demo payment messaging

### 🔄 Simulated Features

The following features are simulated in demo mode:

#### Authentication
- **Simulated**: Anonymous authentication
- **Demo User ID**: `demo-user-12345`
- **Demo Email**: `demo@tokyoroulette.com`
- **Behavior**: Always authenticated, no real Firebase user

#### Cloud Sync
- **Simulated**: Firebase Firestore writes are skipped
- **Behavior**: All data saved locally, no cloud backup
- **Status**: Graceful degradation, no errors

#### Payments
- **Simulated**: Stripe payments skipped
- **Behavior**: Subscription upgrades happen instantly
- **Message**: "Payment simulation - In production, this would connect to Stripe"

## Visual Indicators

Demo mode is clearly indicated throughout the app:

### Splash Screen
- 🎮 **"DEMO MODE"** badge in neon green
- Visible during app launch

### Subscription Dialog
- ℹ️ Info banner explaining payment simulation
- Message: "Payment simulation - In production, this would connect to Stripe. For now, subscription upgrade is granted immediately in demo mode."

### Console Logs
```
Running in DEMO MODE - Firebase initialization skipped
Running in DEMO MODE - Firebase and Stripe are simulated.
To use real features, configure Firebase and Stripe keys.
```

## Testing in Demo Mode

### Basic Testing Flow

1. **Launch App**
   ```bash
   flutter run
   ```
   - Verify demo mode indicator appears
   - Check console for demo mode messages

2. **Test Manual Spins**
   - Tap "Spin" button
   - Verify number is generated and displayed
   - Check history updates
   - Verify predictions update

3. **Test Camera OCR**
   - Tap camera button
   - Grant camera permissions if prompted
   - Capture/select image with number
   - Verify number is recognized and added to history

4. **Test Subscription Tiers**
   - Open subscription dialog
   - Verify demo mode message appears
   - Upgrade to Advanced tier
   - Verify features unlock (Voisins du Zéro predictions)
   - Upgrade to Premium tier
   - Verify all sectors available

5. **Test Statistics**
   - Perform multiple spins (10+)
   - Check 3D bar chart updates
   - Verify color coding (red/black/green)
   - Check number frequencies

6. **Test Persistence**
   - Close app
   - Reopen app
   - Verify spin history is preserved
   - Verify subscription tier is maintained

### Required Testing (Per TESTING_GUIDE.md)

- [ ] 500 manual spins - Track progress to 500
- [ ] 500 camera spins - Track progress to 500
- [ ] All numbers 0-36/00 coverage verification
- [ ] Horizontal orientation testing
- [ ] Permissions verification

## Switching to Production Mode

When ready to deploy with real Firebase and Stripe:

### 1. Configure Firebase

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase for your project
flutterfire configure
```

This will:
- Create a Firebase project
- Generate `firebase_options.dart` with real credentials
- Configure Android and iOS apps

### 2. Configure Stripe

1. Get your Stripe publishable key from [Stripe Dashboard](https://dashboard.stripe.com)
2. Update `lib/utils/constants.dart`:
   ```dart
   static const String stripePublishableKey = 'pk_live_YOUR_REAL_KEY';
   ```
3. Set up backend API for payment intents (required for production)

### 3. Disable Demo Mode

In `lib/utils/demo_mode.dart`:
```dart
static const bool enabled = false;  // Disable demo mode
```

### 4. Build for Production

```bash
# Build release APK
flutter build apk --release

# Or build App Bundle for Play Store
flutter build appbundle --release
```

## Architecture Notes

### Demo Mode Implementation

Demo mode is implemented with minimal code changes:

1. **Conditional Initialization**: Firebase/Stripe only initialized if `!DemoMode.isEnabled`
2. **Nullable Services**: Firebase services are nullable (`FirebaseAuth?`, `FirebaseFirestore?`)
3. **Graceful Fallback**: All Firebase calls wrapped in `if (!_isDemoMode)` checks
4. **Local-First**: Core functionality relies on local storage (SQLite, SharedPreferences)
5. **No Errors**: Failed Firebase calls are logged but don't crash the app

### File Changes

Files modified to support demo mode:
- ✅ `lib/utils/demo_mode.dart` - Configuration
- ✅ `lib/main.dart` - Conditional Firebase init
- ✅ `lib/viewmodels/auth_viewmodel.dart` - Mock authentication
- ✅ `lib/viewmodels/roulette_viewmodel.dart` - Skip Firestore saves
- ✅ `lib/views/screens/splash_screen.dart` - Demo indicator
- ✅ `lib/views/widgets/subscription_upgrade_dialog.dart` - Demo messaging

## Limitations in Demo Mode

### What Doesn't Work

1. **Cloud Sync**: Data is not backed up to Firebase
2. **Multi-Device**: Can't sync data across devices
3. **Real Payments**: Subscriptions are simulated
4. **Analytics**: Firebase Analytics not available
5. **Remote Config**: Dynamic config updates not available
6. **Push Notifications**: Firebase Messaging not available

### Workarounds

For development/testing, these limitations are acceptable:
- Use local storage for all data
- Test payments with simulated upgrades
- Use debug logs instead of analytics
- Configure features in code instead of remote config

## FAQ

### Q: Can I use demo mode in production?
**A:** No. Demo mode is for development and testing only. Production apps need real Firebase and Stripe.

### Q: Will my data persist in demo mode?
**A:** Yes! All data is saved locally in SQLite and SharedPreferences. It survives app restarts.

### Q: Can I test in-app purchases in demo mode?
**A:** Subscription tiers can be tested (features unlock), but real payment flows require Stripe configuration.

### Q: Does demo mode require internet?
**A:** No! Demo mode works completely offline. Perfect for testing without connectivity.

### Q: How do I know if I'm in demo mode?
**A:** Look for the "🎮 DEMO MODE" badge on the splash screen and demo messages in subscription dialogs.

### Q: Can I switch between demo and production mode?
**A:** Yes! Just toggle `DemoMode.enabled` in `demo_mode.dart` and rebuild the app.

## Support

For questions or issues with demo mode:
- Check console logs for demo mode messages
- Verify `DemoMode.enabled = true` in `demo_mode.dart`
- Ensure you're in debug mode (`kDebugMode = true`)
- Review this document for feature availability

For production setup help:
- See [DEPLOYMENT.md](DEPLOYMENT.md) for deployment guide
- See [IMPLEMENTATION.md](IMPLEMENTATION.md) for architecture details
- See [TESTING_GUIDE.md](TESTING_GUIDE.md) for testing procedures

---

**Happy Testing! 🎰🎮**
