# Assets - Icons

This directory contains icon assets for the Tokyo Roulette Predictor app.

## Purpose

Store icon files that are used throughout the application, such as:
- Navigation icons
- Action button icons
- Status indicators
- Feature icons
- Custom UI icons

## File Format Guidelines

- **Format**: PNG (with transparency) or SVG
- **Naming**: Use lowercase with underscores (e.g., `camera_icon.png`)
- **Size**: Keep icons small (< 50KB each)
- **Resolution**: Provide @2x and @3x variants for iOS if needed

## Example Structure

```
assets/icons/
├── camera_icon.png
├── stats_icon.png
├── settings_icon.png
├── spin_icon.png
└── upgrade_icon.png
```

## Icon Size Recommendations

- **Navigation icons**: 24x24 dp (72x72 px @3x)
- **Action icons**: 24x24 dp (72x72 px @3x)
- **Feature icons**: 48x48 dp (144x144 px @3x)

## Usage in Code

To use icons in Flutter code:

```dart
Image.asset('assets/icons/camera_icon.png', width: 24, height: 24)
```

Or with Icon widget if using Material Icons:

```dart
Icon(Icons.camera_alt)  // Material Design icon
```

Make sure the path is listed in `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/icons/
```

## Material Icons

Flutter includes Material Design icons by default. Consider using these before adding custom icons:

```dart
Icon(Icons.camera_alt)
Icon(Icons.bar_chart)
Icon(Icons.settings)
```

See all available icons: https://api.flutter.dev/flutter/material/Icons-class.html

## Notes

- This directory is currently empty but ready for icon assets
- Icons will be bundled with the app during build
- Consider using Material Icons first to reduce app size
- Optimize custom icons before adding
