# Changelog

All notable changes to the Tokyo Roulette Predictor app will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned Features
- iOS version
- Real-time multiplayer predictions
- Social sharing
- Advanced analytics dashboard
- Push notifications for hot streaks
- Voice commands
- Integration with real casino APIs

## [1.0.0] - 2025-11-02

### Added - Initial Release

#### Core Features
- European roulette support (0-36)
- American roulette support (0-36 + 00)
- Weighted RNG algorithm for predictions
- History-based number weighting
- Hot/cold number analysis
- Sector analysis (Voisins du Zéro, Tiers du Cylindre, Orphelins, Jeu Zéro)

#### UI/UX
- Neon color theme (Red #FF0040, Green #00FF41, Black #0A0A0A)
- Glow effects and animations
- 3D animated bar charts (1.5s transitions)
- Portrait mode support
- Landscape mode support (left and right)
- Responsive layouts for all orientations

#### Camera & OCR
- ML Kit text recognition integration
- Real-time camera capture
- Gallery image selection
- Number validation (0-36 and 00)
- Error handling for invalid inputs

#### Subscription System
- Three-tier freemium model:
  - **Free**: Basic hot/cold predictions, manual tracking
  - **Advanced ($199)**: Voisins du Zéro, neighbor analysis, OCR
  - **Premium ($299)**: All sectors, advanced strategies
- Stripe payment integration
- In-app purchase support
- Subscription status persistence

#### Data & Storage
- SQLite local database
- Firebase Firestore cloud sync
- Offline-first architecture
- Automatic sync when online
- Encrypted local storage
- SharedPreferences for settings

#### Authentication
- Firebase Authentication integration
- Anonymous sign-in
- Email/password authentication
- Session management

#### Architecture
- Clean MVVM (Model-View-ViewModel) pattern
- Provider state management
- Service layer separation
- Dependency injection
- Type-safe models

#### Testing
- Unit tests for all services
- Model tests
- RNG validation tests
- Prediction algorithm tests
- Test coverage tracking
- Manual testing guide

#### Documentation
- Comprehensive README
- Quick start guide (10 minutes)
- Complete setup guide (Firebase, Stripe, Play Console)
- Contributing guidelines
- Implementation details
- Testing procedures
- Deployment guide
- Troubleshooting guide
- Release checklist
- Environment configuration template

#### Scripts & Automation
- APK build script (`scripts/build_apk.sh`)
- App bundle build script (`scripts/build_appbundle.sh`)
- Test runner with coverage (`scripts/run_tests.sh`)
- Firebase setup helper (`scripts/setup_firebase.sh`)
- CI/CD workflow for automated testing

#### Security
- Cryptographically secure random number generation
- Input validation on all OCR results
- Firebase security rules ready
- API key management
- Secure local storage

#### Performance
- 60 FPS animations
- Hardware-accelerated rendering
- Efficient state management
- Memory-optimized history tracking (500 recent spins)
- Fast startup time (< 3 seconds target)

#### Compatibility
- Minimum Android SDK: 24 (Android 7.0)
- Target Android SDK: 35 (Android 15)
- Compile SDK: 34
- Multi-dex support
- Material Design 3

### Configuration Files
- `.env.example` - Environment variable template
- `.gitignore` - Properly configured for Flutter/Firebase/Stripe
- `pubspec.yaml` - All dependencies configured
- `android/app/build.gradle` - Android build configuration
- `AndroidManifest.xml` - Permissions and activities

### Developer Experience
- Detailed code comments
- Type-safe Dart code
- Linting and formatting rules
- CI/CD pipeline
- Automated testing
- Build scripts
- Setup automation

## Version History

### Version Number Format
- **Major.Minor.Patch+Build**
- Example: `1.0.0+1`
  - Major: Breaking changes
  - Minor: New features (backwards compatible)
  - Patch: Bug fixes
  - Build: Build number (increments with each build)

### Release Types
- **Alpha**: Internal testing, frequent changes
- **Beta**: Public testing, feature complete
- **Production**: Stable release for all users

## How to Update This File

When making changes:

1. Add entry under `[Unreleased]`
2. Use categories:
   - `Added` for new features
   - `Changed` for changes in existing functionality
   - `Deprecated` for soon-to-be removed features
   - `Removed` for removed features
   - `Fixed` for bug fixes
   - `Security` for vulnerability fixes
3. Move to versioned section on release
4. Update version in `pubspec.yaml`
5. Create Git tag: `git tag -a v1.0.0 -m "Version 1.0.0"`

## Links

- [Repository](https://github.com/Melampe001/Tokyoapps)
- [Issues](https://github.com/Melampe001/Tokyoapps/issues)
- [Releases](https://github.com/Melampe001/Tokyoapps/releases)

---

**Note:** This changelog covers the complete 1.0.0 release. Future versions will document incremental changes.
