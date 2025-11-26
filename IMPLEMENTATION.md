# Tokyo Roulette App - Implementation Guide

## Overview
This is a comprehensive roulette prediction application built with Flutter using MVVM architecture. The app supports both European and American roulette with AI-powered predictions.

## Architecture

### MVVM Pattern
The app follows Model-View-ViewModel architecture:

- **Models** (`lib/models/`): Data structures (SpinResult, Prediction, UserSubscription)
- **Views** (`lib/views/`): UI screens and widgets
- **ViewModels** (`lib/viewmodels/`): Business logic and state management
- **Services** (`lib/services/`): Backend services (RNG, Prediction, Storage, Camera OCR)

## Key Features Implemented

### 1. Modular Code Structure ✓
- Clean MVVM separation
- Service layer for business logic
- Reusable widgets
- Type-safe models

### 2. API Integrations ✓

#### Firebase
- **Authentication**: Anonymous and email/password sign-in
- **Firestore**: Cloud storage for spin data
- **Remote Config**: Dynamic configuration updates

#### Stripe
- **Payment Processing**: In-app purchases for subscriptions
- **Subscription Management**: Free, Advanced ($199), Premium ($299) tiers

#### ML Kit OCR
- **Camera Integration**: Real-time roulette number recognition
- **Image Processing**: OCR text recognition from camera or gallery

#### Weighted RNG
- **History-based predictions**: Numbers weighted by recent history
- **Sector analysis**: Voisins du Zéro, Tiers du Cylindre, Orphelins, Jeu Zéro
- **Tokyo Strategy**: Premium 8-number preset system (12, 35, 1, 17, 5, 27, 22, 29)

### 3. UI Features ✓

#### Neon Color Theme
- Red (#FF0040) for hot numbers and primary actions
- Green (#00FF41) for cold numbers and success states
- Black (#000000) for background and dark elements
- Glow effects using shadows

#### 3D Bar Chart Animations
- Animated statistics with fl_chart
- Smooth transitions (1.5s cubic easing)
- Color-coded bars by number type
- Interactive tooltips

#### Offline Mode
- SQLite local database for spin history
- SharedPreferences for settings
- Graceful Firebase failure handling
- Automatic sync when online

#### Freemium Model with Teasers
- **Free Tier**: Basic hot/cold predictions
- **Advanced Tier ($199)**: Voisins du Zéro + neighbor analysis
- **Premium Tier ($299)**: All sectors + advanced strategies
- Upgrade prompts in prediction text

### 4. Testing Requirements ✓

#### Spin Tracking
- Manual spin counter (target: 500)
- Camera spin counter (target: 500)
- Progress indicators in UI
- Database storage for verification

#### Number Coverage
- Supports 0-36 for European roulette
- Supports 0-36 + 00 (as 37) for American roulette
- Frequency tracking for all numbers
- Color-coded visualization

### 5. Device Compatibility ✓

#### Android 15+ Support
- Minimum SDK: 24 (Android 7.0)
- Target SDK: 35 (Android 15)
- Compiled with SDK 34

#### Orientation Support
- Portrait mode
- Landscape left
- Landscape right
- Adaptive layouts for each orientation

#### Permissions
- Camera permission for OCR
- Vibration permission for haptic feedback
- Network permission for Firebase
- Proper permission request flows

### 6. Performance Optimizations ✓

#### Efficient State Management
- Provider pattern for reactive UI
- Selective rebuilds with ChangeNotifier
- Lazy loading of data

#### Local Caching
- Recent spins cached (limit 500)
- Predictions generated on-demand
- Offline-first architecture

#### Animations
- Hardware-accelerated charts
- Smooth 60 FPS animations
- Optimized paint operations

## Project Structure

```
lib/
├── main.dart                          # App entry point
├── models/                            # Data models
│   ├── prediction.dart
│   ├── spin_result.dart
│   └── user_subscription.dart
├── services/                          # Business logic services
│   ├── camera_ocr_service.dart       # ML Kit OCR
│   ├── prediction_service.dart       # AI predictions
│   ├── rng_service.dart              # Weighted random number generation
│   └── storage_service.dart          # Local/remote storage
├── utils/
│   └── constants.dart                # App constants and colors
├── viewmodels/                       # MVVM view models
│   ├── auth_viewmodel.dart
│   └── roulette_viewmodel.dart
└── views/                            # UI layer
    ├── screens/
    │   ├── main_screen.dart
    │   └── splash_screen.dart
    └── widgets/
        ├── prediction_panel.dart
        ├── roulette_wheel_widget.dart
        ├── stats_chart.dart
        ├── subscription_upgrade_dialog.dart
        └── tokyo_strategy_panel.dart    # Tokyo Strategy UI
```

## Setup Instructions

### Prerequisites
1. Flutter SDK 3.0.0 or higher
2. Android Studio or VS Code with Flutter extensions
3. Firebase project configured
4. Stripe account for payments

### Configuration Steps

1. **Firebase Setup**:
   ```bash
   # Add google-services.json to android/app/
   # Add GoogleService-Info.plist to ios/Runner/
   ```

2. **Stripe Configuration**:
   - Update `AppConstants.stripePublishableKey` in `lib/utils/constants.dart`
   - Set up your backend for payment intents

3. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

4. **Run the App**:
   ```bash
   flutter run
   ```

## Testing Checklist

- [ ] 500 manual spins recorded
- [ ] 500 camera spins recorded
- [ ] All numbers 0-36 tested (European)
- [ ] 00 tested (American)
- [ ] Predictions generated for all numbers
- [ ] Horizontal orientation works correctly
- [ ] Camera permission granted
- [ ] Vibration works on spin
- [ ] Offline mode functions properly
- [ ] Subscription upgrades work
- [ ] Stats chart animates smoothly
- [ ] Tested on Android 15+ device

## Tokyo Strategy Implementation

The Tokyo Strategy is a premium feature that provides an elite 8-number betting system based on sector analysis.

### Technical Implementation

**Constants** (`lib/utils/constants.dart`):
- `tokyoStrategyNumbers`: `[12, 35, 1, 17, 5, 27, 22, 29]`
- `tokyoStrategyDescription`: Detailed strategy explanation

**UI Components** (`lib/views/widgets/tokyo_strategy_panel.dart`):
- `TokyoStrategyPanel`: Full strategy display with neon-styled numbers
- `TokyoStrategyQuickInfo`: Compact widget for prediction panel
- Locked overlay for non-premium users with upgrade prompt

**Prediction Integration** (`lib/services/prediction_service.dart`):
- Premium predictions prioritize Tokyo Strategy numbers
- Strategy recommendations based on Tokyo number performance
- Real-time activity tracking (strong/moderate/low)

**Testing** (`test/tokyo_strategy_test.dart`):
- Number validation and sector coverage
- Premium prediction integration
- Tier-specific feature access
- Color mapping and validation

### Usage

Premium users see:
1. Dedicated Tokyo Strategy panel on main screen
2. Real-time performance indicator in predictions
3. Intelligent strategy recommendations
4. Quick-access number display with color coding

Non-premium users see:
- Locked overlay with upgrade prompt
- Feature preview to encourage upgrade

## Known Limitations

1. **Firebase Configuration**: Requires manual setup of google-services.json
2. **Stripe Payments**: Requires backend API implementation for production
3. **ML Kit**: OCR accuracy depends on image quality and lighting
4. **Camera Permissions**: Must be granted by user

## Future Enhancements

1. iOS support
2. Real-time multiplayer predictions
3. Cloud backup and restore
4. Social sharing features
5. Advanced analytics dashboard
6. Push notifications for hot streaks
7. Integration with real casino APIs
8. Voice commands for hands-free operation

## Support

For issues or questions, please refer to the documentation or create an issue in the repository.
