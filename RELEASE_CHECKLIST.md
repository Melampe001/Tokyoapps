# Tokyo Roulette App - Release Checklist

Use this checklist before releasing a new version to production.

## Pre-Release

### Code Quality
- [ ] All tests pass (`flutter test`)
- [ ] No analyzer warnings (`flutter analyze`)
- [ ] Code formatted (`dart format .`)
- [ ] Coverage > 80% for critical paths
- [ ] No debug/TODO comments in production code
- [ ] All security vulnerabilities addressed

### Documentation
- [ ] CHANGELOG.md updated with new version
- [ ] README.md reflects current features
- [ ] API documentation up to date
- [ ] Setup guides tested and accurate
- [ ] Known issues documented

### Configuration
- [ ] Version number updated in `pubspec.yaml`
- [ ] Build number incremented
- [ ] Firebase configuration verified
- [ ] Stripe keys set for production
- [ ] Environment variables configured
- [ ] API endpoints point to production

### Testing

#### Automated Testing
- [ ] All unit tests pass
- [ ] All widget tests pass
- [ ] Integration tests pass
- [ ] No failing CI/CD pipelines

#### Manual Testing
- [ ] 500 manual spins completed (see TESTING_GUIDE.md)
- [ ] 500 camera spins completed
- [ ] All numbers (0-36 and 00) tested
- [ ] Tested on multiple devices:
  - [ ] Low-end device (2GB RAM)
  - [ ] Mid-range device (4GB RAM)
  - [ ] High-end device (6GB+ RAM)
- [ ] Tested on multiple Android versions:
  - [ ] Android 7.0 (API 24)
  - [ ] Android 10 (API 29)
  - [ ] Android 13 (API 33)
  - [ ] Android 14 (API 34)
  - [ ] Android 15 (API 35)

#### Feature Testing
- [ ] European roulette works correctly
- [ ] American roulette works correctly
- [ ] RNG generates valid numbers
- [ ] Predictions are accurate and reasonable
- [ ] Hot/cold number tracking works
- [ ] Sector analysis accurate (Premium)
- [ ] Statistics charts display correctly
- [ ] Animations smooth (60 FPS)

#### UI/UX Testing
- [ ] Portrait mode works correctly
- [ ] Landscape left works correctly
- [ ] Landscape right works correctly
- [ ] Neon colors display properly
- [ ] Glow effects render correctly
- [ ] All buttons responsive
- [ ] No UI glitches or overlaps
- [ ] Loading states display
- [ ] Error messages user-friendly

#### Offline Mode
- [ ] App works without internet
- [ ] Local database stores data
- [ ] Syncs when back online
- [ ] No crashes when offline
- [ ] Graceful Firebase error handling

#### Camera/OCR
- [ ] Camera permission requested
- [ ] Camera opens correctly
- [ ] OCR recognizes numbers accurately
- [ ] Gallery selection works
- [ ] Error handling for invalid images
- [ ] Works in various lighting conditions

#### Subscriptions
- [ ] Free tier limitations enforced
- [ ] Advanced upgrade prompt shows
- [ ] Premium upgrade prompt shows
- [ ] Stripe payment sheet opens
- [ ] Test purchases work (test mode)
- [ ] Subscription status persists
- [ ] Features unlock after purchase

#### Performance
- [ ] App starts in < 3 seconds
- [ ] Spin animation smooth
- [ ] Charts render in < 1 second
- [ ] No memory leaks
- [ ] Battery usage acceptable
- [ ] App size < 50 MB

## Build & Sign

### Android Release Build
- [ ] Generate release keystore (if first time)
- [ ] `key.properties` configured
- [ ] Build app bundle: `flutter build appbundle --release`
- [ ] App bundle size reasonable (< 30 MB)
- [ ] Test app bundle on device
- [ ] No crashes in release mode
- [ ] ProGuard rules configured (if used)

### Security
- [ ] No API keys hardcoded
- [ ] No secrets in version control
- [ ] `.env` file not committed
- [ ] `key.properties` not committed
- [ ] Firebase security rules configured
- [ ] Stripe webhook secured

## Play Console Setup

### App Listing
- [ ] App name: Tokyo Roulette Predictor
- [ ] Short description (< 80 chars)
- [ ] Full description (< 4000 chars)
- [ ] Screenshots (min 2, recommended 8):
  - [ ] Phone: 1080x1920 or 1080x2400
  - [ ] 7-inch tablet: 1200x1920
  - [ ] 10-inch tablet: 1600x2560
- [ ] Feature graphic: 1024x500
- [ ] App icon: 512x512
- [ ] Category selected
- [ ] Content rating completed

### Store Listing Optimization
- [ ] Keywords optimized
- [ ] Description includes:
  - [ ] Key features
  - [ ] Benefits
  - [ ] How it works
  - [ ] Subscription tiers
  - [ ] Call to action

### Pricing & Distribution
- [ ] App set to Free
- [ ] Countries/regions selected
- [ ] In-app products configured:
  - [ ] Advanced Plan: $199
  - [ ] Premium Plan: $299
- [ ] Pricing tested in test mode

### App Content
- [ ] Privacy policy URL provided
- [ ] Target age group selected
- [ ] Ads disclosure (if applicable)
- [ ] Content rating questionnaire complete
- [ ] Data safety form complete:
  - [ ] Data collected disclosed
  - [ ] Data usage disclosed
  - [ ] Security practices disclosed

## Internal Testing

### Internal Test Track
- [ ] Upload app bundle to internal testing
- [ ] Add internal testers (email addresses)
- [ ] Internal testers receive email
- [ ] Install and test on real devices
- [ ] Collect feedback
- [ ] Fix critical bugs
- [ ] Upload new version if needed

### Internal Test Checklist
- [ ] App installs successfully
- [ ] No crashes on startup
- [ ] Core features work
- [ ] Subscriptions work (test mode)
- [ ] No major bugs

## Closed/Alpha Testing

### Closed Test Track
- [ ] Upload app bundle to closed testing
- [ ] Create opt-in URL
- [ ] Share with alpha testers (10-100 people)
- [ ] Monitor crash reports
- [ ] Collect user feedback
- [ ] Address feedback
- [ ] Upload new version if needed

### Metrics to Monitor
- [ ] Crash-free rate > 99%
- [ ] ANR rate < 0.5%
- [ ] Startup time < 3s
- [ ] User ratings > 4.0
- [ ] No critical bugs reported

## Open/Beta Testing (Optional)

### Open Test Track
- [ ] Upload app bundle to open testing
- [ ] Make available to public
- [ ] Monitor larger user base
- [ ] Collect feedback at scale
- [ ] Address issues
- [ ] Prepare for production

## Production Release

### Final Checks
- [ ] All previous checklists complete
- [ ] No blocking bugs
- [ ] Performance acceptable
- [ ] Security verified
- [ ] Legal requirements met
- [ ] Team approval obtained

### Release
- [ ] Upload app bundle to production
- [ ] Set rollout percentage (recommended: 20% → 50% → 100%)
- [ ] Write release notes
- [ ] Set go-live date (or immediate)
- [ ] Submit for review
- [ ] Monitor review status

### Release Notes Template
```
Version X.X.X

New Features:
• Feature 1 description
• Feature 2 description

Improvements:
• Improvement 1
• Improvement 2

Bug Fixes:
• Fixed issue with ...
• Resolved crash when ...

Performance:
• Improved loading speed
• Reduced app size
```

## Post-Release

### Monitoring (First 24 Hours)
- [ ] Monitor crash reports (Firebase Crashlytics)
- [ ] Check ANR rate (Play Console)
- [ ] Monitor reviews and ratings
- [ ] Check install metrics
- [ ] Watch for critical issues
- [ ] Be ready for emergency update

### Monitoring (First Week)
- [ ] Review crash-free rate
- [ ] Analyze user retention
- [ ] Check subscription conversion
- [ ] Monitor payment issues
- [ ] Gather user feedback
- [ ] Plan next iteration

### Marketing
- [ ] Announce release on social media
- [ ] Update website
- [ ] Send email to subscribers (if applicable)
- [ ] Reach out to press/reviewers
- [ ] Monitor app store ranking

### Support
- [ ] Set up support email
- [ ] Monitor reviews and respond
- [ ] Create FAQ based on feedback
- [ ] Track common issues
- [ ] Plan support resources

## Emergency Rollback

If critical issues found:
- [ ] Stop rollout immediately
- [ ] Assess severity
- [ ] Fix critical bug
- [ ] Test fix thoroughly
- [ ] Upload emergency update
- [ ] Resume rollout with fix

## Version Management

### After Release
- [ ] Tag release in Git: `v1.0.0`
- [ ] Create GitHub release with notes
- [ ] Archive build artifacts
- [ ] Document known issues
- [ ] Plan next version features
- [ ] Update project board

---

## Sign-Off

### Team Sign-Off
- [ ] Developer: _________________ Date: _______
- [ ] QA Tester: _________________ Date: _______
- [ ] Product Owner: _____________ Date: _______
- [ ] Release Manager: ___________ Date: _______

### Release Information
- **Version:** _______
- **Build Number:** _______
- **Release Date:** _______
- **Release Type:** [ ] Internal [ ] Closed [ ] Open [ ] Production

### Notes
_Add any additional notes, known issues, or important information:_

---

**Remember:** It's better to delay a release than to ship a buggy app. Quality over speed!
