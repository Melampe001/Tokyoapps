import 'package:flutter/material.dart';

class AppConstants {
  // Stripe keys - Load from environment or secure config in production
  // TODO: Move to .env file and use flutter_dotenv package
  static const String stripePublishableKey = String.fromEnvironment(
    'STRIPE_PUBLISHABLE_KEY',
    defaultValue: 'pk_test_YOUR_KEY_HERE',
  );
  // WARNING: Never hardcode or commit secret keys to version control
  // Secret key should only be used on backend server
  static const String stripeSecretKey = 'NEVER_USE_IN_CLIENT_APP';
  
  // Subscription prices
  static const int advancedPlanPrice = 19900; // $199.00 in cents
  static const int premiumPlanPrice = 29900; // $299.00 in cents
  
  // Roulette configuration
  static const int europeanWheelSize = 37; // 0-36
  static const int americanWheelSize = 38; // 0-36 + 00
  
  // Testing requirements
  static const int requiredManualSpins = 500;
  static const int requiredCameraSpins = 500;
}

class AppColors {
  // Neon colors for roulette
  static const Color neonRed = Color(0xFFFF0040);
  static const Color neonGreen = Color(0xFF00FF41);
  static const Color neonBlack = Color(0xFF000000);
  static const Color darkBackground = Color(0xFF0A0A0A);
  static const Color cardBackground = Color(0xFF1A1A1A);
  
  // Roulette number colors
  static Color getNumberColor(int number) {
    if (number == 0 || number == 37) return neonGreen; // 0 and 00
    
    // Red numbers: 1,3,5,7,9,12,14,16,18,19,21,23,25,27,30,32,34,36
    const redNumbers = [1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36];
    return redNumbers.contains(number) ? neonRed : neonBlack;
  }
}

class RouletteConstants {
  // European roulette wheel layout
  static const List<int> europeanWheel = [
    0, 32, 15, 19, 4, 21, 2, 25, 17, 34, 6, 27, 13, 36, 11, 30, 8, 23, 10,
    5, 24, 16, 33, 1, 20, 14, 31, 9, 22, 18, 29, 7, 28, 12, 35, 3, 26
  ];
  
  // American roulette wheel layout (with 00 represented as 37)
  static const List<int> americanWheel = [
    0, 28, 9, 26, 30, 11, 7, 20, 32, 17, 5, 22, 34, 15, 3, 24, 36, 13, 1,
    37, 27, 10, 25, 29, 12, 8, 19, 31, 18, 6, 21, 33, 16, 4, 23, 35, 14, 2
  ];
  
  // Betting sectors for advanced predictions
  static const Map<String, List<int>> sectors = {
    'Voisins du Zéro': [22, 18, 29, 7, 28, 12, 35, 3, 26, 0, 32, 15, 19, 4, 21, 2, 25],
    'Tiers du Cylindre': [27, 13, 36, 11, 30, 8, 23, 10, 5, 24, 16, 33],
    'Orphelins': [17, 34, 6, 1, 20, 14, 31, 9],
    'Jeu Zéro': [12, 35, 3, 26, 0, 32, 15],
  };
}
