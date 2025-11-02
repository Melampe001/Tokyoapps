# Tokyo Roulette App - Testing Guide

## Overview
This guide provides comprehensive testing procedures to validate all requirements from the problem statement.

## Automated Tests

### Running Tests
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/services/rng_service_test.dart

# Run with coverage
flutter test --coverage
```

### Test Coverage

#### Unit Tests
- ✓ **RNG Service Tests** (`test/services/rng_service_test.dart`)
  - Number generation in valid ranges (0-36 for European, 0-37 for American)
  - Weighted RNG based on history
  - Neighbor calculation
  - Sector frequency calculation
  - Coverage of all possible numbers

- ✓ **Prediction Service Tests** (`test/services/prediction_service_test.dart`)
  - Predictions for different subscription tiers
  - Confidence calculation
  - Hot/cold number identification
  - Sector analysis for premium tiers
  - Both roulette types

- ✓ **Spin Result Model Tests** (`test/models/spin_result_test.dart`)
  - Color classification (Red/Black/Green)
  - JSON serialization/deserialization
  - All numbers 0-36/00 validation

## Manual Testing Requirements

### 1. 500 Manual Spins Test ✓
**Requirement**: Simulate 500 manual spins

**Steps**:
1. Launch the app
2. Navigate to main roulette screen
3. Click "MANUAL SPIN" button 500 times
4. Monitor the counter: "Manual: X / 500"
5. Progress bar should fill as you approach 500

**Validation**:
- [ ] Counter accurately tracks spins
- [ ] Progress bar updates correctly
- [ ] All spins are saved to local database
- [ ] UI remains responsive throughout

### 2. 500 Camera Spins Test ✓
**Requirement**: Simulate 500 spins via camera OCR

**Steps**:
1. Grant camera permissions
2. Click "CAMERA SPIN" button
3. Point camera at roulette wheel or number display
4. OR use gallery to select pre-captured images
5. Repeat 500 times
6. Monitor the counter: "Camera: X / 500"

**Validation**:
- [ ] Camera initializes correctly
- [ ] OCR recognizes numbers accurately
- [ ] Counter tracks camera spins separately
- [ ] Invalid numbers are rejected with error message

**Note**: For testing purposes, you can create a set of 38 images (0-36 + 00) and cycle through them.

### 3. Number Coverage Test (0-36/00) ✓
**Requirement**: Verify predictions work for all numbers

**European Roulette (0-36)**:
```
Numbers to test: 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 
                 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29,
                 30, 31, 32, 33, 34, 35, 36
```

**American Roulette (0-36 + 00)**:
```
Additional: 00 (displayed as "00", stored as 37)
```

**Steps**:
1. Switch to European mode
2. Manually enter or generate all numbers 0-36
3. Verify each number:
   - Appears in history
   - Shows correct color (Red/Black/Green)
   - Updates statistics chart
   - Included in predictions
4. Switch to American mode
5. Test number 00 (37)

**Validation Checklist**:
- [ ] All 37 European numbers work
- [ ] Number 00 works in American mode
- [ ] Each number shows correct color in UI
- [ ] Frequency grid includes all numbers
- [ ] Stats chart displays all numbers
- [ ] Predictions consider all numbers

### 4. Horizontal Orientation Test ✓
**Requirement**: App works in horizontal position

**Steps**:
1. Rotate device to landscape mode
2. Verify UI adapts correctly
3. Test all features in landscape:
   - Manual spin
   - Camera spin
   - View statistics
   - View history
   - Upgrade subscription
4. Rotate back to portrait

**Validation**:
- [ ] Layout adapts to landscape (side-by-side view)
- [ ] All buttons remain accessible
- [ ] Text remains readable
- [ ] Charts display correctly
- [ ] No UI elements overlap
- [ ] Camera works in landscape

### 5. Permissions Test ✓
**Requirement**: Camera and vibration permissions work

**Camera Permission**:
1. First launch: Verify permission request dialog
2. Grant permission
3. Test camera spin feature
4. Deny permission (reinstall if needed)
5. Verify error message shown

**Vibration Permission**:
1. Perform manual spin
2. Feel device vibrate (100ms)
3. Perform camera spin
4. Feel device vibrate (150ms)

**Validation**:
- [ ] Camera permission requested on first camera use
- [ ] Clear error if camera denied
- [ ] Vibration works on each spin
- [ ] App functions without vibration if unavailable

### 6. Android 15+ Compatibility Test ✓
**Requirement**: Works on Android 15+ devices

**Test Devices**:
- Android 15 (API 35) - Primary target
- Android 14 (API 34) - Secondary
- Android 7.0 (API 24) - Minimum support

**Steps**:
1. Install APK on test device
2. Verify app launches
3. Test all major features
4. Check for crashes or warnings

**Validation**:
- [ ] App installs successfully
- [ ] No runtime permission errors
- [ ] All features work as expected
- [ ] No deprecated API warnings
- [ ] Performance is smooth (60 FPS)

### 7. Offline Mode Test ✓
**Requirement**: App works without internet

**Steps**:
1. Turn on airplane mode or disable WiFi/data
2. Launch app (or continue using)
3. Perform manual spins
4. Perform camera spins
5. View history and statistics
6. Try to upgrade subscription (should fail gracefully)
7. Re-enable internet
8. Verify data syncs to Firebase

**Validation**:
- [ ] App functions without internet
- [ ] Spins saved to local database
- [ ] Predictions still generated
- [ ] Statistics still displayed
- [ ] Graceful error for online-only features
- [ ] Data syncs when connection restored

### 8. Freemium Features Test ✓
**Requirement**: Teasers motivate upgrades

**Free Tier**:
1. Use app without purchasing
2. View basic predictions
3. See upgrade prompts

**Validation**:
- [ ] Shows hot/cold numbers only
- [ ] Teaser text mentions "Voisins du Zéro"
- [ ] Displays "Upgrade to Advanced ($199)"
- [ ] Suggested bets limited to 3 numbers
- [ ] Sector data NOT shown

**Advanced Tier ($199)**:
1. Tap subscription badge
2. Select "ADVANCED" tier
3. Confirm (demo mode auto-upgrades)
4. View enhanced predictions

**Validation**:
- [ ] Shows Voisins du Zéro frequency
- [ ] Includes neighbor analysis
- [ ] Shows teaser for Premium features
- [ ] Suggested bets expanded (5-8 numbers)
- [ ] Still shows upgrade prompt to Premium

**Premium Tier ($299)**:
1. Upgrade to Premium
2. View full predictions

**Validation**:
- [ ] Shows all 4 sectors with frequencies
- [ ] Includes advanced strategies
- [ ] No upgrade prompts
- [ ] Full suggested bets list
- [ ] Confidence scores displayed

### 9. UI/UX Test ✓
**Requirement**: Neon colors and 3D animations

**Neon Colors**:
- [ ] Red (#FF0040) for hot numbers and primary actions
- [ ] Green (#00FF41) for 0/00 and success states
- [ ] Black background (#0A0A0A)
- [ ] Glow effects on numbers and buttons

**3D Bar Chart**:
- [ ] Chart animates when data changes (1.5s)
- [ ] Bars have depth/shadow effect
- [ ] Smooth cubic easing
- [ ] Interactive tooltips on hover
- [ ] Colors match roulette number colors

**General UI**:
- [ ] Loading states during spins
- [ ] Error messages are clear
- [ ] Success feedback (vibration, visual)
- [ ] Consistent spacing and alignment
- [ ] Readable text at all sizes

### 10. Performance Test ✓
**Requirement**: Smooth performance

**Metrics**:
- App launch time: < 3 seconds
- Spin response time: < 500ms
- Chart animation: 60 FPS
- Database operations: < 100ms
- Memory usage: < 150MB

**Load Test**:
1. Generate 1000+ spins
2. Navigate between screens
3. View statistics with full history
4. Clear and regenerate data

**Validation**:
- [ ] UI remains responsive with large dataset
- [ ] No memory leaks
- [ ] Animations stay smooth
- [ ] Database queries optimized

## Test Results Documentation

### Test Execution Log
```
Date: _________________
Tester: _________________
Device: _________________
Android Version: _________________

Manual Spins: ____ / 500
Camera Spins: ____ / 500

Number Coverage:
- European (0-36): ☐ Complete
- American (00): ☐ Tested

Orientation: ☐ Portrait  ☐ Landscape
Permissions: ☐ Camera  ☐ Vibration
Offline Mode: ☐ Tested
Subscription Tiers: ☐ Free  ☐ Advanced  ☐ Premium

Issues Found:
1. ________________________________
2. ________________________________
3. ________________________________

Overall Status: ☐ Pass  ☐ Fail  ☐ Partial
```

## Known Issues & Limitations

1. **OCR Accuracy**: ML Kit accuracy depends on image quality
2. **Firebase Config**: Requires manual setup
3. **Stripe Integration**: Demo mode only (no real payments)
4. **iOS Support**: Not yet implemented

## Continuous Integration

The app includes GitHub Actions workflow for:
- Automated testing on push
- Code coverage reports
- Build validation

## Debugging Tips

### Enable Debug Mode
```dart
// In main.dart, set:
const bool kDebugMode = true;
```

### View Database
```bash
# Pull database from device
adb pull /data/data/com.tokyo.roulette_app/databases/roulette.db
```

### Check Logs
```bash
# Filter Flutter logs
adb logcat | grep -i flutter
```

## Security Testing

### Checklist
- [ ] No API keys in source code
- [ ] Secure random number generation
- [ ] Encrypted local storage
- [ ] Secure Firebase rules
- [ ] Input validation on OCR results

## Accessibility Testing

### Checklist
- [ ] Screen reader support
- [ ] Sufficient color contrast
- [ ] Touch targets >= 44px
- [ ] Text scales with system settings

## Conclusion

Complete all tests above before marking the implementation as production-ready. Each feature should pass its validation checklist and any issues should be documented and resolved.
