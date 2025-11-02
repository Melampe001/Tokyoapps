import 'package:flutter/foundation.dart';

/// Demo mode configuration
/// When enabled, the app works without Firebase or Stripe configuration
class DemoMode {
  // Set to true to enable demo mode (no Firebase/Stripe required)
  static const bool enabled = true;
  
  // Demo user ID
  static const String demoUserId = 'demo-user-12345';
  
  // Demo user email
  static const String demoUserEmail = 'demo@tokyoroulette.com';
  
  /// Check if app is running in demo mode
  static bool get isEnabled => enabled || kDebugMode;
  
  /// Get a message explaining demo mode
  static String get demoMessage => 
    'Running in DEMO MODE - Firebase and Stripe are simulated. '
    'To use real features, configure Firebase and Stripe keys.';
  
  /// Payment demo message
  static String get paymentDemoMessage =>
    'Payment simulation - In production, this would connect to Stripe.\n'
    'For now, subscription upgrade is granted immediately in demo mode.';
}
