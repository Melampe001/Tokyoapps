# GitHub Copilot Instructions for Tokyo Roulette App

## Project Overview
This is a Flutter-based roulette prediction application with MVVM architecture, featuring AI-powered predictions, ML Kit OCR for camera-based number scanning, and a freemium subscription model. The app supports both European (0-36) and American (0-36 + 00) roulette games.

## Technology Stack
- **Framework**: Flutter 3.0+ with Dart
- **Architecture**: MVVM (Model-View-ViewModel) with Provider for state management
- **Backend**: Firebase (Auth, Firestore, Remote Config, Storage)
- **Payments**: Stripe integration for subscriptions
- **ML/AI**: Google ML Kit for OCR text recognition
- **Database**: SQLite (local) + Firestore (cloud sync)
- **Charts**: fl_chart for animated visualizations
- **Platform**: Android 7.0+ (API 24-35), with future iOS support

## Architecture Pattern

### MVVM Structure
```
lib/
├── models/          # Data structures and business entities
│   ├── spin_result.dart       # Spin data with color/number/timestamp
│   ├── prediction.dart        # Prediction results with confidence scores
│   └── user_subscription.dart # User tier (Free/Advanced/Premium)
├── views/           # UI components (screens and widgets)
│   ├── screens/               # Full-page screens
│   └── widgets/               # Reusable UI components
├── viewmodels/      # Business logic and state management
│   ├── roulette_viewmodel.dart # Main app state
│   ├── auth_viewmodel.dart     # Authentication state
│   └── camera_viewmodel.dart   # OCR camera state
├── services/        # Backend services and APIs
│   ├── rng_service.dart        # Weighted random number generation
│   ├── prediction_service.dart # AI prediction algorithms
│   ├── storage_service.dart    # SQLite + Firestore sync
│   └── camera_ocr_service.dart # ML Kit OCR integration
└── utils/           # Constants, helpers, and utilities
    ├── constants.dart          # Colors, strings, config
    └── extensions.dart         # Dart extensions
```

### Key Principles
1. **Separation of Concerns**: Keep Models, Views, and ViewModels strictly separated
2. **Single Responsibility**: Each class/file should have one clear purpose
3. **Provider Pattern**: Use ChangeNotifier for reactive state updates
4. **Dependency Injection**: Pass services through Provider, not globals
5. **Offline-First**: Always handle offline scenarios gracefully

## Coding Guidelines

### Dart/Flutter Best Practices
- Use `const` constructors wherever possible for performance
- Prefer `final` over `var` for immutable values
- Use named parameters for functions with 3+ arguments
- Follow official Dart style guide (lowerCamelCase for variables, UpperCamelCase for classes)
- Always handle null safety properly (use `?`, `!`, and null checks)
- Use async/await instead of `.then()` for cleaner asynchronous code

### State Management with Provider
```dart
// In ViewModel
class RouletteViewModel extends ChangeNotifier {
  void updateState() {
    // Update state
    notifyListeners(); // Trigger UI rebuild
  }
}

// In View
Consumer<RouletteViewModel>(
  builder: (context, viewModel, child) {
    return Text(viewModel.data);
  },
)
```

### Error Handling
- Always wrap Firebase calls in try-catch blocks
- Provide user-friendly error messages
- Log errors for debugging but never expose sensitive data
- Handle offline scenarios gracefully (show cached data)

## UI/UX Guidelines

### Neon Color Theme
- **Neon Red** (`#FF0040`): Hot numbers, primary actions, paid features
- **Neon Green** (`#00FF41`): Cold numbers, 0/00, success states
- **Dark Background** (`#0A0A0A`): Main background for neon contrast
- **Glow Effects**: Use `BoxShadow` with blur radius for neon glow
- **White Text** (`#FFFFFF`): Primary text on dark backgrounds

### Animations
- Use `AnimatedContainer` for smooth transitions (1.5s duration, cubic curve)
- Implement pulsing effects for important elements (repeating animations)
- Bar charts should animate entry with staggered delays
- Page transitions should use fade + slide animations

### Responsive Design
- Support portrait, landscape left, and landscape right orientations
- Use `MediaQuery` for responsive sizing
- Test on different screen sizes (phones and tablets)
- Minimum touch target size: 48x48 logical pixels

## Feature-Specific Guidelines

### Roulette Wheel and RNG
- **European Wheel**: 37 numbers (0-36), house edge 2.7%
- **American Wheel**: 38 numbers (0-36 + 00 as 37), house edge 5.26%
- **Weighted RNG**: Use history to weight predictions, but maintain fairness
- **Sectors**: 
  - Voisins du Zéro: [22,18,29,7,28,12,35,3,26,0,32,15,19,4,21,2,25]
  - Tiers du Cylindre: [27,13,36,11,30,8,23,10,5,24,16,33]
  - Orphelins: [17,34,6,1,20,14,31,9]
  - Jeu Zéro: [12,35,3,26,0,32,15]

### Freemium Subscription Model
- **Free Tier**: Basic hot/cold predictions, manual spin tracking, limited history
- **Advanced Tier ($199)**: + Voisins du Zéro analysis, neighbor calculations, camera OCR, extended history
- **Premium Tier ($299)**: + All 4 sector predictions, advanced betting strategies, full confidence scores, priority support

### Upgrade Prompts
- Show tasteful upgrade prompts in prediction text
- Never block core functionality for free users
- Premium features should be clearly marked with a "💎" icon
- Use `SubscriptionUpgradeDialog` widget for consistent upgrade flow

### Camera OCR Integration
- Use `google_mlkit_text_recognition` package
- Request camera permission before accessing camera
- Process images to extract numbers (0-36 or 00)
- Validate extracted numbers are in valid range
- Provide visual feedback during scanning
- Handle OCR errors gracefully (allow manual entry fallback)

### Firebase Integration
- **Authentication**: Support anonymous and email/password sign-in
- **Firestore**: Sync spin history to cloud (with offline support)
- **Remote Config**: Use for feature flags and dynamic pricing
- **Storage**: Store user profile images if needed

### Stripe Payments
- Use `flutter_stripe` package for payment processing
- Implement 3D Secure (SCA) for European compliance
- Handle payment failures gracefully
- Store subscription status in both Firestore and SharedPreferences
- Support subscription management (upgrade/downgrade/cancel)

## Testing Guidelines

### Unit Tests
- Test all services independently (RNG, Prediction, Storage)
- Mock Firebase and Stripe dependencies
- Test edge cases (empty history, invalid numbers, offline mode)
- Aim for 80%+ code coverage on services and viewmodels

### Widget Tests
- Test critical user flows (spin, prediction, upgrade)
- Test responsive layouts at different screen sizes
- Test error states and loading indicators
- Use `flutter_test` package with `WidgetTester`

### Integration Tests
- Test complete user journeys (onboarding → spin → upgrade → premium features)
- Test offline → online sync scenarios
- Test camera OCR flow with sample images
- Use `integration_test` package

### Manual Testing Checklist
- [ ] 500 manual spins (track in database)
- [ ] 500 camera scans (track in database)
- [ ] All numbers 0-36 and 00 appear and are recognized
- [ ] All 3 orientations work properly
- [ ] All subscription tiers unlock correct features
- [ ] Offline mode works without crashes
- [ ] Payments complete successfully
- [ ] Firebase sync works after reconnection

## Security Best Practices

### Data Protection
- Never store payment information locally
- Use Firebase Auth for user authentication
- Encrypt sensitive local data (SQLite encryption with `sqflite_sqlcipher`)
- Validate all user inputs to prevent injection attacks
- Use HTTPS for all network requests

### API Keys
- Store API keys in environment variables or Firebase Remote Config
- Never commit API keys to version control
- Use different keys for development and production
- Rotate keys regularly

### Permissions
- Request minimum necessary permissions
- Explain why permissions are needed before requesting
- Handle permission denial gracefully
- Respect user privacy (no tracking without consent)

## Android-Specific Considerations

### Build Configuration
- **Min SDK**: 24 (Android 7.0 Nougat)
- **Target SDK**: 35 (Android 15)
- **Compile SDK**: 34
- Use Gradle 7.5+ and Kotlin 1.8+

### Permissions (AndroidManifest.xml)
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.VIBRATE" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="com.android.vending.BILLING" />
```

### ProGuard Rules
- Keep ML Kit classes
- Keep Firebase classes
- Keep Stripe classes
- Obfuscate everything else for release builds

## Development Workflow

### Setting Up Development Environment
```bash
# Clone repository
git clone https://github.com/Melampe001/Tokyoapps.git
cd Tokyoapps

# Install dependencies
flutter pub get

# Configure Firebase (requires Firebase project)
# Add google-services.json to android/app/

# Run the app
flutter run
```

### Branch Strategy
- `main`: Production-ready code
- `develop`: Integration branch for features
- `feature/*`: New features
- `bugfix/*`: Bug fixes
- `hotfix/*`: Emergency production fixes

### Commit Messages
Follow conventional commits:
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `style:` Code style changes (formatting)
- `refactor:` Code refactoring
- `test:` Adding or updating tests
- `chore:` Maintenance tasks

### Code Review Checklist
- [ ] Follows MVVM architecture
- [ ] No business logic in Views
- [ ] Proper error handling
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] No hardcoded strings (use constants)
- [ ] No API keys committed
- [ ] Follows Dart style guide
- [ ] Performance optimized (no unnecessary rebuilds)

## Common Patterns and Examples

### Adding a New Feature
1. Create model in `lib/models/` if needed
2. Add service logic in `lib/services/`
3. Create/update ViewModel in `lib/viewmodels/`
4. Implement UI in `lib/views/`
5. Write tests for each layer
6. Update documentation

### Making API Calls
```dart
// In Service
Future<Result> fetchData() async {
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.success(json.decode(response.body));
    }
    return Result.error('Failed to load data');
  } catch (e) {
    return Result.error('Network error: $e');
  }
}

// In ViewModel
Future<void> loadData() async {
  final result = await _service.fetchData();
  result.when(
    success: (data) => _data = data,
    error: (message) => _errorMessage = message,
  );
  notifyListeners();
}
```

### Handling Subscriptions
```dart
// Check user tier before showing premium features
if (userSubscription.tier >= SubscriptionTier.advanced) {
  // Show advanced feature
} else {
  // Show upgrade prompt
  showUpgradeDialog(context, SubscriptionTier.advanced);
}
```

## Resources

### Documentation
- [IMPLEMENTATION.md](../IMPLEMENTATION.md) - Technical implementation details
- [TESTING_GUIDE.md](../TESTING_GUIDE.md) - Comprehensive testing procedures
- [DEPLOYMENT.md](../DEPLOYMENT.md) - Build and deployment guide
- [PROJECT_SUMMARY.md](../PROJECT_SUMMARY.md) - Complete implementation status

### External Links
- [Flutter Documentation](https://docs.flutter.dev/)
- [Firebase for Flutter](https://firebase.google.com/docs/flutter/setup)
- [Stripe Flutter SDK](https://stripe.com/docs/payments/accept-a-payment?platform=android&ui=payment-sheet)
- [ML Kit Text Recognition](https://developers.google.com/ml-kit/vision/text-recognition/android)
- [Provider Package](https://pub.dev/packages/provider)
- [fl_chart Package](https://pub.dev/packages/fl_chart)

## Support and Contact
- **Repository**: https://github.com/Melampe001/Tokyoapps
- **Author**: Tokyo / Melampe (@Melampe001)
- **Issues**: Create an issue on GitHub
- **Email**: support@example.com

## License
This project is proprietary software. All rights reserved.

---

**Last Updated**: November 2025  
**Version**: 1.0.0  
**Status**: ✅ Production Ready
