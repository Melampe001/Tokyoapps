# GitHub Copilot Instructions for Tokyo Roulette Predictor

This repository contains a Flutter mobile application with MVVM architecture. Follow these guidelines when working with the codebase.

## Development Workflow

### 1. Code Formatting
Before each commit, ensure all Dart code is properly formatted:
```bash
flutter format .
```

### 2. Development Commands

**Install dependencies:**
```bash
flutter pub get
```

**Run the app:**
```bash
flutter run
```

**Build for production:**
```bash
# Android
flutter build apk --release
flutter build appbundle --release

# iOS (on macOS)
flutter build ios --release
```

**Run tests:**
```bash
flutter test
flutter test --coverage
```

**Analyze code:**
```bash
flutter analyze
```

**Complete CI check (format, analyze, test):**
```bash
flutter format . --set-exit-if-changed && flutter analyze && flutter test
```

## Repository Structure

- **`lib/`**: Main application code
  - **`models/`**: Data models (Dart classes representing app data structures)
  - **`views/`**: UI components
    - `screens/`: Full-screen views
    - `widgets/`: Reusable UI widgets
  - **`viewmodels/`**: Business logic and state management (MVVM pattern)
  - **`services/`**: Core services (Firebase, OCR, RNG, storage, etc.)
  - **`utils/`**: Constants, helpers, and utilities
- **`test/`**: Unit and widget tests
- **`android/`**: Android-specific configuration
- **`assets/`**: Images, icons, and other static resources
- **`config/`**: Configuration files
- **`docs/`**: Documentation

## Key Development Practices

### Architecture
- **Follow MVVM pattern**: Separate UI (Views), business logic (ViewModels), and data (Models)
- **Use Provider for state management**: ViewModels extend ChangeNotifier
- **Maintain clean separation of concerns**: Views should only handle UI, ViewModels handle logic

### Code Quality
- **Follow Dart/Flutter style guide**: Use `flutter analyze` to check compliance
- **Write idiomatic Dart code**: Prefer `final` over `const` where appropriate, use null safety
- **Maintain existing code structure**: Don't reorganize without reason
- **Use dependency injection**: Pass dependencies through constructors

### Testing
- **Write tests for new features**: Prioritize ViewModels and Services
- **Use widget tests for UI components**: Test user interactions
- **Prefer test-driven development**: Write tests before implementing features
- **Follow existing test patterns**: Check `test/` directory for examples

### Documentation
- **Document public APIs**: Add doc comments to public methods and classes
- **Explain complex logic**: Add inline comments for non-obvious code
- **Update docs/**: When adding major features, update documentation in `docs/`

### Firebase & External Services
- **Firebase**: Used for authentication, Firestore, storage, and remote config
- **Stripe**: Payment integration (configured in services)
- **ML Kit**: OCR for camera-based roulette scanning
- **Keep secrets safe**: Never commit API keys or secrets to the repository

### UI/UX Guidelines
- **Neon theme**: Red (#FF0040), Green (#00FF41), Dark background (#0A0A0A)
- **Responsive design**: Support both portrait and landscape orientations
- **Smooth animations**: Use 1.5s transitions for charts and UI changes
- **Accessibility**: Ensure UI is accessible with proper labels and contrast

## Common Tasks

### Adding a new feature
1. Create/update models in `lib/models/`
2. Add business logic in `lib/viewmodels/`
3. Create UI in `lib/views/`
4. Add services if needed in `lib/services/`
5. Write tests in `test/`
6. Format code: `flutter format .`
7. Run tests: `flutter test`
8. Analyze: `flutter analyze`

### Adding a new dependency
1. Add to `pubspec.yaml` under `dependencies` or `dev_dependencies`
2. Run `flutter pub get`
3. Import in your Dart files

### Updating Firebase configuration
1. Run `flutterfire configure` (requires FlutterFire CLI)
2. Update `lib/firebase_options.dart` if needed

## Git Workflow

- **Format before commit**: Always run `flutter format .`
- **Run tests before push**: Ensure `flutter test` passes
- **Write meaningful commit messages**: Describe what and why, not how
- **Keep commits focused**: One logical change per commit

## CI/CD

The repository uses GitHub Actions for continuous integration. The workflow runs on push and pull requests to `main`.

Current CI steps:
- Checkout code
- Set up Flutter environment
- Install dependencies
- Format check
- Analyze code
- Run tests

## References

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [MVVM Pattern in Flutter](https://medium.com/flutter-community/flutter-mvvm-architecture-f8bed2521958)
- [Provider Package](https://pub.dev/packages/provider)
- [Best practices for Copilot coding agent](https://gh.io/copilot-coding-agent-tips)
- Internal documentation: `/docs/`

## Troubleshooting

**Dependency issues:**
```bash
flutter clean
flutter pub get
```

**Build issues:**
```bash
flutter clean
cd android && ./gradlew clean
cd ..
flutter build apk
```

**Firebase issues:**
- Ensure `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) are present
- Verify Firebase project configuration with `flutterfire configure`

---

**Note**: This is a Flutter/Dart project. Always use Flutter-specific commands and follow Flutter best practices.
