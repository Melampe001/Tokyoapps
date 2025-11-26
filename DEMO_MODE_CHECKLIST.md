# Demo Mode Verification Checklist

Use this checklist to verify that the Tokyo Roulette app works correctly in demo mode.

## Prerequisites

- [ ] Flutter SDK installed and configured
- [ ] Dependencies installed (`flutter pub get`)
- [ ] Demo mode is enabled in `lib/utils/demo_mode.dart` (should be `true` by default)

## App Launch Verification

### Startup
- [ ] App launches without errors
- [ ] Splash screen displays
- [ ] "🎮 DEMO MODE" badge visible on splash screen
- [ ] Console shows "Running in DEMO MODE - Firebase initialization skipped"
- [ ] No Firebase errors in console
- [ ] App transitions to main screen automatically

### Authentication
- [ ] No authentication dialogs appear (auto-authenticated)
- [ ] App considers user authenticated
- [ ] No Firebase auth errors

## Core Features Verification

### Roulette Type Selection
- [ ] Toggle between European/American roulette works
- [ ] "EUR" label shows for European
- [ ] "USA" label shows for American
- [ ] Wheel updates appropriately

### Manual Spins
- [ ] Tap "Spin" button works
- [ ] Random number is generated (0-36 for EUR, 0-37 for USA)
- [ ] Number is displayed prominently
- [ ] Number appears in history list
- [ ] Spin count increments
- [ ] No Firebase errors

Perform 10 manual spins:
- [ ] Spin 1: Number ___
- [ ] Spin 2: Number ___
- [ ] Spin 3: Number ___
- [ ] Spin 4: Number ___
- [ ] Spin 5: Number ___
- [ ] Spin 6: Number ___
- [ ] Spin 7: Number ___
- [ ] Spin 8: Number ___
- [ ] Spin 9: Number ___
- [ ] Spin 10: Number ___

### Predictions

#### Free Tier (Default)
- [ ] Basic predictions show
- [ ] Hot numbers displayed (top 3-5)
- [ ] Cold numbers displayed (bottom 3-5)
- [ ] Teaser message for Advanced tier shows
- [ ] Message mentions "Upgrade to Advanced ($199)"

#### Advanced Tier (After Upgrade)
- [ ] Upgrade to Advanced works (see Subscription section)
- [ ] Voisins du Zéro predictions appear
- [ ] Neighbor analysis shows
- [ ] More numbers in predictions (5-8)
- [ ] Teaser message for Premium tier shows

#### Premium Tier (After Upgrade)
- [ ] Upgrade to Premium works
- [ ] All sector predictions appear:
  - [ ] Voisins du Zéro
  - [ ] Tiers du Cylindre
  - [ ] Orphelins
  - [ ] Jeu Zéro
- [ ] Confidence scores visible
- [ ] No more teaser messages

### Camera OCR
- [ ] Camera button visible
- [ ] Tap camera button requests permissions
- [ ] Grant camera permission
- [ ] Camera view opens
- [ ] Can capture image
- [ ] OR can select image from gallery
- [ ] Number recognition works
- [ ] Recognized number appears in history
- [ ] Camera spin count increments
- [ ] No Firebase errors

### Statistics & Charts
- [ ] Statistics tab accessible
- [ ] 3D bar chart renders
- [ ] Chart shows frequency of numbers
- [ ] Colors match number colors:
  - [ ] Green for 0 (and 00)
  - [ ] Red for red numbers
  - [ ] Black for black numbers
- [ ] Chart animates smoothly
- [ ] Tooltips show on tap/hover
- [ ] Chart updates after new spins

### History
- [ ] History tab accessible
- [ ] All spins listed in order (newest first)
- [ ] Each entry shows:
  - [ ] Number
  - [ ] Timestamp
  - [ ] Method (manual/camera)
  - [ ] Color indicator
- [ ] Manual spin count displayed
- [ ] Camera spin count displayed
- [ ] Clear history button works

## Subscription Management

### Subscription Dialog
- [ ] Tap subscription badge in app bar
- [ ] Subscription dialog opens
- [ ] Demo mode message visible at top
- [ ] Message explains payment simulation
- [ ] Current tier highlighted
- [ ] All three tiers visible:
  - [ ] Free ($0)
  - [ ] Advanced ($199)
  - [ ] Premium ($299)
- [ ] Feature lists visible for each tier

### Free to Advanced Upgrade
- [ ] Tap "UPGRADE NOW" on Advanced tier
- [ ] Loading indicator appears
- [ ] Upgrade completes (1-2 seconds)
- [ ] Success message appears
- [ ] Dialog closes
- [ ] Subscription badge updates to "ADVANCED"
- [ ] Advanced features unlock
- [ ] No payment dialog appears
- [ ] No Stripe errors

### Advanced to Premium Upgrade
- [ ] Tap "UPGRADE NOW" on Premium tier
- [ ] Loading indicator appears
- [ ] Upgrade completes
- [ ] Success message appears
- [ ] Badge updates to "PREMIUM"
- [ ] Premium features unlock
- [ ] No payment dialog appears

## Data Persistence

### App Restart Test
1. [ ] Perform 5-10 spins
2. [ ] Upgrade to Advanced or Premium
3. [ ] Close app completely
4. [ ] Reopen app
5. [ ] Verify:
   - [ ] Spin history is preserved
   - [ ] Subscription tier is maintained
   - [ ] Predictions based on saved history
   - [ ] Statistics show saved data

## Offline Functionality

### Airplane Mode Test
1. [ ] Enable airplane mode
2. [ ] Close and reopen app
3. [ ] Verify:
   - [ ] App launches successfully
   - [ ] No network errors
   - [ ] All features work
   - [ ] Spins can be performed
   - [ ] Data is saved locally
4. [ ] Disable airplane mode

## UI/UX Verification

### Theme & Colors
- [ ] Neon red primary color (#FF0040)
- [ ] Neon green accents (#00FF41)
- [ ] Dark background (#0A0A0A)
- [ ] Glow effects visible on key elements
- [ ] Buttons have proper styling

### Animations
- [ ] Splash screen fade-in animation smooth
- [ ] Chart bars animate on update (1.5s duration)
- [ ] Wheel spin animation (if implemented)
- [ ] Dialog transitions smooth
- [ ] Number display updates smoothly

### Responsive Layout

#### Portrait Mode
- [ ] All elements visible
- [ ] Proper spacing
- [ ] Tabs work correctly
- [ ] Easy to navigate

#### Landscape Mode
- [ ] Layout adapts properly
- [ ] Main area + Stats side-by-side
- [ ] All elements accessible
- [ ] No overlapping elements

### Orientation Changes
- [ ] Rotate to landscape - layout adapts
- [ ] Rotate to portrait - layout adapts
- [ ] Data persists during rotation
- [ ] No crashes or errors

## Error Handling

### Invalid Camera Input
- [ ] Try camera scan with no number
- [ ] Error message shows
- [ ] App doesn't crash
- [ ] Can retry

### Clear History
- [ ] Clear history button works
- [ ] Confirmation dialog appears (if implemented)
- [ ] History clears
- [ ] Predictions reset
- [ ] Charts reset

## Console Log Verification

Check console for expected messages:
- [ ] "Running in DEMO MODE - Firebase initialization skipped"
- [ ] Demo mode message appears
- [ ] No Firebase errors
- [ ] No Stripe errors
- [ ] Warnings about Firebase being skipped (expected)

## Final Checks

### Demo Mode Indicators
- [ ] Demo mode badge on splash screen
- [ ] Demo message in subscription dialog
- [ ] Console messages about demo mode
- [ ] No confusion about Firebase being missing

### Overall Experience
- [ ] App feels complete and functional
- [ ] No broken features
- [ ] Smooth performance
- [ ] Professional appearance
- [ ] Clear that it's demo mode but fully functional

## Issues Found

Document any issues discovered during testing:

1. Issue: ___________________________________________
   - Expected: _____________________________________
   - Actual: _______________________________________
   - Severity: [ ] Critical [ ] High [ ] Medium [ ] Low

2. Issue: ___________________________________________
   - Expected: _____________________________________
   - Actual: _______________________________________
   - Severity: [ ] Critical [ ] High [ ] Medium [ ] Low

3. Issue: ___________________________________________
   - Expected: _____________________________________
   - Actual: _______________________________________
   - Severity: [ ] Critical [ ] High [ ] Medium [ ] Low

## Sign-off

- [ ] All critical features tested and working
- [ ] Demo mode is clearly indicated
- [ ] No crashes or critical errors
- [ ] App ready for demo/development use

**Tested by:** ___________________________  
**Date:** ___________________________  
**Build/Version:** ___________________________  
**Device/Emulator:** ___________________________  

---

## Notes for Production Testing

When testing with real Firebase and Stripe (demo mode disabled):
- [ ] Firebase authentication works
- [ ] Cloud sync works
- [ ] Real payment flow works
- [ ] Subscription verification works
- [ ] All demo indicators removed
