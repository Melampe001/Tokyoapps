# 🎰 Tokyo Roulette - Quick Start Guide

Get the app running in **2 minutes** with zero configuration!

## 🚀 Super Fast Setup

```bash
# 1. Clone the repository
git clone https://github.com/Melampe001/Tokyoapps.git

# 2. Navigate to the project
cd Tokyoapps

# 3. Get dependencies
flutter pub get

# 4. Run the app (that's it!)
flutter run
```

**No Firebase setup. No Stripe configuration. No credentials needed.**

## 🎮 What You'll See

### 1. Splash Screen (3 seconds)
```
┌──────────────────────────────────┐
│                                  │
│         🎰 (glowing red)         │
│                                  │
│       TOKYO ROULETTE            │
│    AI-Powered Predictions        │
│                                  │
│         Loading...               │
│                                  │
│     🎮 DEMO MODE                 │
│                                  │
└──────────────────────────────────┘
```

### 2. Main Screen
```
┌─────────────── Tokyo Roulette ────────────────┐
│  EUR/USA Switch    [FREE] Badge               │
├───────────────────────────────────────────────┤
│                                               │
│         🎯 Roulette Wheel Display             │
│           (Last Number: --)                   │
│                                               │
│              [SPIN] Button                    │
│           (tap to generate)                   │
│                                               │
│  📊 Predictions                               │
│  • Hot numbers: --                            │
│  • Cold numbers: --                           │
│  • 🔒 Upgrade to Advanced for more            │
│                                               │
├───────────────────────────────────────────────┤
│  Home  |  Stats  |  History                  │
└───────────────────────────────────────────────┘
```

### 3. After First Spin
```
┌─────────────── Tokyo Roulette ────────────────┐
│  EUR/USA Switch    [FREE] Badge               │
├───────────────────────────────────────────────┤
│                                               │
│         🎯 Roulette Wheel Display             │
│           (Last Number: 17)                   │
│              RED - Manual                      │
│                                               │
│              [SPIN] Button                    │
│                                               │
│  📊 Predictions                               │
│  • Hot: 17, 12, 3                            │
│  • Cold: 0, 36, 22                           │
│  • Confidence: Medium                         │
│  • 🔒 Upgrade to Advanced ($199)             │
│    for Voisins du Zéro predictions           │
│                                               │
├───────────────────────────────────────────────┤
│  Home  |  Stats  |  History                  │
└───────────────────────────────────────────────┘
```

### 4. Subscription Dialog
```
┌─────── UPGRADE YOUR EXPERIENCE ───────┐
│                                       │
│  ℹ️ Payment simulation - In          │
│  production, this would connect to    │
│  Stripe. For now, upgrade is instant. │
│                                       │
│  Current: FREE                        │
│                                       │
│  ┌─────────────────────────────┐     │
│  │ FREE - $0                   │     │
│  │ • Basic predictions         │ ✓   │
│  │ • Hot & cold numbers        │     │
│  └─────────────────────────────┘     │
│                                       │
│  ┌─────────────────────────────┐     │
│  │ ADVANCED - $199             │     │
│  │ • Everything in Free        │     │
│  │ • Voisins du Zéro           │     │
│  │ • Camera OCR                │     │
│  │   [UPGRADE NOW]             │     │
│  └─────────────────────────────┘     │
│                                       │
│  ┌─────────────────────────────┐     │
│  │ PREMIUM - $299              │     │
│  │ • Everything in Advanced    │     │
│  │ • All sectors               │     │
│  │ • Priority support          │     │
│  │   [UPGRADE NOW]             │     │
│  └─────────────────────────────┘     │
│                                       │
│           [Maybe Later]               │
└───────────────────────────────────────┘
```

## 🎯 Try These Features

### 1. Perform Manual Spins (30 seconds)
1. Tap the **[SPIN]** button
2. Watch a random number appear
3. See it added to history
4. Notice predictions update
5. Repeat 5-10 times

**Expected:** Numbers generate instantly, predictions improve with more data

### 2. Try Camera OCR (1 minute)
1. Tap the camera icon 📷
2. Grant camera permission if asked
3. Point at any number (0-36)
4. Tap capture
5. Number gets recognized and added

**Expected:** Number recognition works, added to history as "camera" method

### 3. Upgrade Subscription (30 seconds)
1. Tap **[FREE]** badge in top-right
2. See demo mode message
3. Tap **[UPGRADE NOW]** on Advanced
4. Wait 2 seconds (simulated processing)
5. See success message
6. Badge changes to **[ADVANCED]**
7. More predictions appear!

**Expected:** Instant upgrade, Voisins du Zéro predictions unlock

### 4. View Statistics (30 seconds)
1. Tap **Stats** tab at bottom
2. See 3D bar chart
3. Watch it animate
4. Check number frequencies
5. Notice color coding (red/black/green)

**Expected:** Beautiful animated chart with all your spins

### 5. Check History (30 seconds)
1. Tap **History** tab
2. See list of all spins
3. Notice timestamps
4. See method (manual/camera)
5. Check spin counters

**Expected:** Complete list of all spins, persistent across restarts

## 🔄 Test Data Persistence

```bash
# 1. Perform 5-10 spins
# 2. Upgrade to Advanced
# 3. Close the app completely
# 4. Reopen the app
# 5. Check:
```

✅ All spins are still there
✅ Subscription tier is maintained
✅ Predictions based on saved history
✅ Statistics show saved data

**Expected:** Everything persists perfectly!

## 💡 Pro Tips

### Get the Best Experience

1. **Perform 20+ spins** for accurate predictions
2. **Try both European and American** roulette modes
3. **Test portrait and landscape** orientations
4. **Upgrade to Premium** to see all features
5. **Clear history** to start fresh anytime

### See All Features

| Tap This | To See This |
|----------|-------------|
| EUR/USA toggle | Switch roulette types |
| [FREE] badge | Subscription options |
| Camera icon | OCR number recognition |
| Stats tab | 3D frequency charts |
| History tab | Complete spin list |
| Settings icon | App preferences |

### Console Messages

Watch the console for helpful messages:
```
Running in DEMO MODE - Firebase initialization skipped
Firebase and Stripe are simulated
Demo user ID: demo-user-12345
```

## 🎨 Visual Features to Notice

### Neon Theme
- **Neon Red** (#FF0040) - Hot numbers, spin button
- **Neon Green** (#00FF41) - Zero (00), success states
- **Dark Background** (#0A0A0A) - Main background
- **Glow Effects** - Shadows on key elements

### Animations
- **Splash screen** - Smooth fade-in
- **Charts** - 1.5-second transitions
- **Number display** - Pulse effect
- **Buttons** - Hover glow

### Responsive Design
- **Portrait mode** - Stacked layout
- **Landscape mode** - Side-by-side
- **Adaptive spacing** - Scales to screen
- **Touch targets** - 48dp minimum

## 🆘 Troubleshooting

### App doesn't start?
```bash
# Clear Flutter cache
flutter clean
flutter pub get
flutter run
```

### Camera not working?
1. Check permissions in system settings
2. Grant camera access
3. Restart app
4. Try gallery option instead

### Numbers not appearing?
1. Check console for errors
2. Verify demo mode is enabled
3. Try clearing history
4. Restart app

### Want real Firebase/Stripe?
See [DEMO_MODE.md](DEMO_MODE.md) for production setup

## 📚 Next Steps

### Learn More
- **[DEMO_MODE.md](DEMO_MODE.md)** - Complete demo mode guide
- **[DEMO_MODE_CHECKLIST.md](DEMO_MODE_CHECKLIST.md)** - Verification checklist
- **[IMPLEMENTATION.md](IMPLEMENTATION.md)** - Technical architecture
- **[TESTING_GUIDE.md](TESTING_GUIDE.md)** - Testing procedures

### Ready for Production?
1. Configure Firebase (`flutterfire configure`)
2. Add Stripe keys
3. Disable demo mode
4. Build release version

### Need Help?
- Check documentation files
- Look at console logs
- Review code comments
- Create GitHub issue

## ✨ Key Takeaways

🎮 **Demo Mode is Active**
- Zero configuration required
- All features fully functional
- Perfect for testing and development

💾 **Data is Local**
- SQLite database for spins
- SharedPreferences for settings
- Everything persists offline

🚀 **Full Feature Access**
- Manual and camera spins
- All three subscription tiers
- Complete statistics
- Persistent history

🎯 **Professional Quality**
- Neon UI theme
- Smooth animations
- Responsive layouts
- Production-ready code

---

## 🎉 You're Ready!

Now you have a **fully functional roulette prediction app** running on your device with:
- ✅ Zero configuration
- ✅ All features working
- ✅ Beautiful UI
- ✅ Offline capability
- ✅ Demo mode clearly indicated

**Enjoy exploring the app! 🎰✨**

---

**Need more details?** Check [DEMO_MODE.md](DEMO_MODE.md) for the complete guide!
