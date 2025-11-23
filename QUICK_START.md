# Tokyo Roulette App - Quick Start Guide

## 🚀 Get Running in 10 Minutes

This quick start guide will help you get the app running quickly for development and testing.

## Prerequisites Check

```bash
# Verify Flutter is installed
flutter --version

# Verify Java is installed
java -version

# Check Flutter setup
flutter doctor -v
```

If any checks fail, install the missing components first.

## 1. Clone & Setup (2 minutes)

```bash
# Clone the repository
git clone https://github.com/Melampe001/Tokyoapps.git
cd Tokyoapps

# Install dependencies
flutter pub get
```

## 2. Quick Configuration (3 minutes)

### Option A: Demo Mode (No Firebase/Stripe needed)

For quick testing without external services:

1. The app will work in offline mode
2. Firebase errors will be caught gracefully
3. Stripe payments will show demo mode
4. All core features work locally

Just run:
```bash
flutter run
```

### Option B: Full Setup (With Firebase)

If you want full functionality:

1. **Copy environment template:**
   ```bash
   cp .env.example .env
   ```

2. **Set up Firebase (minimal):**
   - Create project at https://console.firebase.google.com/
   - Download `google-services.json`
   - Place in `android/app/google-services.json`

3. **Run auto-config:**
   ```bash
   # Install FlutterFire CLI
   dart pub global activate flutterfire_cli
   
   # Auto-configure
   flutterfire configure
   ```

## 3. Run the App (1 minute)

```bash
# Start emulator (Android Studio) or connect device
flutter run

# Or specify device
flutter devices
flutter run -d <device-id>
```

## 4. Test Basic Features (4 minutes)

Once running, test these key features:

### ✅ Spin the Wheel
1. Tap "European" or "American" mode
2. Tap "SPIN" button
3. See result and predictions

### ✅ View Statistics
1. Make several spins (at least 10)
2. Scroll down to see charts
3. Check hot/cold numbers

### ✅ Camera OCR (if available)
1. Tap camera icon
2. Grant camera permission
3. Point at a number (write on paper: 17)
4. See it recognized

### ✅ Subscription Tiers
1. Tap "Upgrade" button
2. See subscription options
3. Note freemium limitations

## Quick Troubleshooting

### App won't start
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

### Firebase errors
- Check `google-services.json` is in `android/app/`
- Or run in demo mode (errors are handled gracefully)

### Camera not working
- Grant camera permission in device settings
- Check physical device (emulator cameras often don't work well)

### Build errors
```bash
# Update Flutter
flutter upgrade

# Re-fetch dependencies
rm -rf .dart_tool
flutter pub get
```

## Development Tips

### Hot Reload
When app is running, press `r` to hot reload changes instantly.

### Debug Output
Watch the console for debug messages and errors.

### Emulator Shortcuts
- **Android Studio:** Tools → AVD Manager → Start emulator
- **Command line:** `flutter emulators` then `flutter emulators --launch <id>`

### Code Changes
Main files to customize:
- `lib/utils/constants.dart` - Colors, settings
- `lib/views/screens/main_screen.dart` - Main UI
- `lib/services/prediction_service.dart` - Prediction logic
- `lib/services/rng_service.dart` - RNG and weighting

## Next Steps

After you're running:

1. ✅ Read `SETUP_GUIDE.md` for complete Firebase/Stripe setup
2. ✅ Review `IMPLEMENTATION.md` to understand architecture
3. ✅ Check `TESTING_GUIDE.md` for comprehensive testing
4. ✅ See `DEPLOYMENT.md` for production deployment

## Common First-Time Questions

**Q: Do I need Firebase to run the app?**
A: No! The app works in offline/demo mode. Firebase adds cloud sync and auth.

**Q: Do I need Stripe to test subscriptions?**
A: No! The app shows subscription tiers and UI. Stripe enables real payments.

**Q: Can I use iOS?**
A: Yes, but you need a Mac and Xcode. Android is easier to start.

**Q: How do I test on a real device?**
A: Enable Developer Options and USB Debugging on Android, connect via USB, run `flutter run`.

**Q: The camera OCR isn't accurate?**
A: ML Kit needs good lighting and clear numbers. Test with printed/written numbers.

## Getting Help

- 📖 Full docs: See other .md files in this repo
- 🐛 Issues: https://github.com/Melampe001/Tokyoapps/issues
- 💬 Discussions: GitHub Discussions tab

## Success Checklist

- [ ] App builds successfully
- [ ] App runs on emulator/device
- [ ] Can spin the wheel and see results
- [ ] Can view statistics
- [ ] Can switch between European/American
- [ ] UI looks good (neon red/black/green theme)
- [ ] No critical errors in console

If all checked ✅ - congratulations! You're ready to develop.

---

**Need more help?** Check `SETUP_GUIDE.md` for detailed instructions.
