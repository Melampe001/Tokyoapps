# Contributing to Tokyo Roulette App

Thank you for considering contributing to the Tokyo Roulette App! This document provides guidelines and instructions for contributing.

## 📋 Table of Contents
- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Process](#development-process)
- [Coding Standards](#coding-standards)
- [Testing Guidelines](#testing-guidelines)
- [Pull Request Process](#pull-request-process)
- [Issue Reporting](#issue-reporting)

## Code of Conduct

### Our Pledge
We are committed to providing a welcoming and inspiring community for all. Please be respectful and constructive in all interactions.

### Expected Behavior
- Use welcoming and inclusive language
- Respect differing viewpoints and experiences
- Accept constructive criticism gracefully
- Focus on what's best for the community

## Getting Started

### Prerequisites
1. Read `QUICK_START.md` to set up your development environment
2. Read `SETUP_GUIDE.md` for detailed configuration
3. Familiarize yourself with the codebase structure in `IMPLEMENTATION.md`

### Development Setup
```bash
# Fork and clone the repository
git clone https://github.com/YOUR_USERNAME/Tokyoapps.git
cd Tokyoapps

# Add upstream remote
git remote add upstream https://github.com/Melampe001/Tokyoapps.git

# Install dependencies
flutter pub get

# Create a feature branch
git checkout -b feature/your-feature-name
```

## Development Process

### Branch Naming Convention
- `feature/` - New features
- `fix/` - Bug fixes
- `docs/` - Documentation updates
- `refactor/` - Code refactoring
- `test/` - Adding or updating tests
- `chore/` - Maintenance tasks

Examples:
- `feature/add-european-roulette-stats`
- `fix/camera-permission-crash`
- `docs/update-setup-guide`

### Commit Message Format
Follow conventional commits:

```
type(scope): subject

body (optional)

footer (optional)
```

Types:
- `feat` - New feature
- `fix` - Bug fix
- `docs` - Documentation
- `style` - Code style (formatting)
- `refactor` - Code refactoring
- `test` - Tests
- `chore` - Maintenance

Examples:
```
feat(rng): add weighted RNG algorithm

Implements history-based weighting for predictions.
Weighs recent spins 5% higher than baseline.

Closes #123
```

```
fix(camera): handle permission denial gracefully

Added proper error handling when camera permission is denied.
Shows user-friendly message instead of crashing.

Fixes #456
```

## Coding Standards

### Dart/Flutter Guidelines

#### 1. Follow Effective Dart
- Read: https://dart.dev/guides/language/effective-dart

#### 2. Code Formatting
```bash
# Format all Dart files
dart format .

# Check formatting
dart format --output=none --set-exit-if-changed .
```

#### 3. Linting
```bash
# Run analyzer
flutter analyze

# Fix auto-fixable issues
dart fix --apply
```

#### 4. Naming Conventions
```dart
// Classes: PascalCase
class RouletteViewModel extends ChangeNotifier {}

// Functions/Variables: camelCase
void calculatePrediction() {}
final int spinCount = 0;

// Constants: lowerCamelCase with const
const int maxSpins = 500;

// Private: prefix with underscore
void _privateMethod() {}
final int _privateVar = 0;

// Files: snake_case
// roulette_view_model.dart
// prediction_service.dart
```

#### 5. Documentation
```dart
/// Calculates weighted predictions based on spin history.
///
/// Uses the last [historyLength] spins to determine hot/cold numbers.
/// Weights recent spins 5% higher than older spins.
///
/// Returns a [Prediction] object with suggested numbers and confidence scores.
Prediction calculatePrediction({required List<SpinResult> history, int historyLength = 100}) {
  // Implementation
}
```

### MVVM Architecture Rules

#### Models
- Pure data classes
- No business logic
- Serialization methods (toJson/fromJson)
- Equality and hashCode overrides

```dart
class SpinResult {
  final int number;
  final DateTime timestamp;
  
  const SpinResult({required this.number, required this.timestamp});
  
  Map<String, dynamic> toJson() => {
    'number': number,
    'timestamp': timestamp.toIso8601String(),
  };
  
  factory SpinResult.fromJson(Map<String, dynamic> json) => SpinResult(
    number: json['number'],
    timestamp: DateTime.parse(json['timestamp']),
  );
}
```

#### Views
- UI only
- No business logic
- Use Consumer for state updates
- Stateless when possible

```dart
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RouletteViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Column(
            children: [
              Text(viewModel.lastResult?.toString() ?? 'No spins yet'),
              ElevatedButton(
                onPressed: viewModel.spin,
                child: Text('SPIN'),
              ),
            ],
          ),
        );
      },
    );
  }
}
```

#### ViewModels
- Business logic
- State management
- Extends ChangeNotifier
- Call notifyListeners() on state changes

```dart
class RouletteViewModel extends ChangeNotifier {
  SpinResult? _lastResult;
  SpinResult? get lastResult => _lastResult;
  
  void spin() {
    _lastResult = _rngService.generate();
    notifyListeners();
  }
}
```

#### Services
- Reusable business logic
- No UI dependencies
- Injectable/mockable for testing

```dart
class RNGService {
  SpinResult generate({required bool isEuropean}) {
    // Implementation
  }
}
```

## Testing Guidelines

### Test Coverage Requirements
- Aim for 80%+ code coverage
- All services must have unit tests
- ViewModels should have unit tests
- Critical UI flows should have widget tests

### Writing Tests

#### Unit Tests
```dart
void main() {
  group('RNGService', () {
    late RNGService rngService;
    
    setUp(() {
      rngService = RNGService();
    });
    
    test('generates numbers in valid range for European roulette', () {
      for (int i = 0; i < 100; i++) {
        final result = rngService.generate(isEuropean: true);
        expect(result.number, greaterThanOrEqualTo(0));
        expect(result.number, lessThanOrEqualTo(36));
      }
    });
    
    test('generates numbers in valid range for American roulette', () {
      for (int i = 0; i < 100; i++) {
        final result = rngService.generate(isEuropean: false);
        expect(result.number, greaterThanOrEqualTo(0));
        expect(result.number, lessThanOrEqualTo(37)); // 37 represents 00
      }
    });
  });
}
```

#### Widget Tests
```dart
void main() {
  testWidgets('Spin button triggers spin', (WidgetTester tester) async {
    final viewModel = RouletteViewModel();
    
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider.value(
          value: viewModel,
          child: MainScreen(),
        ),
      ),
    );
    
    expect(find.text('SPIN'), findsOneWidget);
    await tester.tap(find.text('SPIN'));
    await tester.pump();
    
    expect(viewModel.lastResult, isNotNull);
  });
}
```

### Running Tests
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/services/rng_service_test.dart

# Run with coverage
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

### Manual Testing
Before submitting a PR, complete the relevant sections of `TESTING_GUIDE.md`.

## Pull Request Process

### Before Submitting

1. **Update your branch**
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. **Run tests**
   ```bash
   flutter test
   flutter analyze
   dart format --output=none --set-exit-if-changed .
   ```

3. **Manual testing**
   - Test on both emulator and real device
   - Test affected features thoroughly
   - Check for crashes or errors

### PR Checklist

- [ ] Code follows style guidelines
- [ ] All tests pass
- [ ] New tests added for new features
- [ ] Documentation updated (if applicable)
- [ ] No new warnings or errors
- [ ] Tested on Android device/emulator
- [ ] Commit messages follow convention
- [ ] Branch is up to date with main

### PR Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing Done
- [ ] Unit tests added/updated
- [ ] Manual testing completed
- [ ] Tested on Android X.X
- [ ] No crashes or errors

## Screenshots (if applicable)
Add screenshots for UI changes

## Related Issues
Fixes #123
Closes #456

## Additional Notes
Any additional context
```

### Review Process

1. Maintainers will review your PR
2. Address feedback and requested changes
3. Once approved, your PR will be merged
4. Thank you for contributing!

## Issue Reporting

### Before Creating an Issue

1. Search existing issues
2. Check if it's already fixed in main branch
3. Verify it's reproducible

### Issue Template

```markdown
**Description**
Clear description of the issue

**Steps to Reproduce**
1. Go to...
2. Click on...
3. See error...

**Expected Behavior**
What should happen

**Actual Behavior**
What actually happens

**Environment**
- Flutter version: [e.g., 3.16.0]
- Device: [e.g., Pixel 7]
- Android version: [e.g., 14]

**Screenshots**
If applicable

**Additional Context**
Any other relevant information
```

## Development Resources

### Documentation
- `QUICK_START.md` - Get started quickly
- `SETUP_GUIDE.md` - Complete setup instructions
- `IMPLEMENTATION.md` - Architecture details
- `TESTING_GUIDE.md` - Testing procedures
- `DEPLOYMENT.md` - Deployment guide

### External Resources
- [Flutter Documentation](https://docs.flutter.dev/)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [Flutter MVVM](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple)

## Questions?

- Open a discussion on GitHub
- Comment on relevant issues
- Reach out to maintainers

## License

By contributing, you agree that your contributions will be licensed under the project's license.

---

Thank you for contributing to Tokyo Roulette App! 🎰🚀
