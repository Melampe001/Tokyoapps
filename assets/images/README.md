# Assets - Images

This directory contains image assets for the Tokyo Roulette Predictor app.

## Purpose

Store image files that are used throughout the application, such as:
- Background images
- Roulette wheel graphics
- UI decorative elements
- Tutorial/onboarding images
- Splash screen images

## File Format Guidelines

- **Format**: PNG (with transparency) or JPEG
- **Naming**: Use lowercase with underscores (e.g., `roulette_wheel.png`)
- **Size**: Optimize images for mobile use (< 500KB per image recommended)
- **Resolution**: Provide multiple resolutions for different screen densities if needed

## Example Structure

```
assets/images/
├── roulette_wheel.png
├── splash_background.png
├── tutorial_step1.png
├── tutorial_step2.png
└── logo.png
```

## Usage in Code

To use images in Flutter code:

```dart
Image.asset('assets/images/roulette_wheel.png')
```

Make sure the path is listed in `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/images/
```

## Notes

- This directory is currently empty but ready for image assets
- Images will be bundled with the app during build
- Optimize images before adding to reduce app size
