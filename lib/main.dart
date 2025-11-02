import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'viewmodels/roulette_viewmodel.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'views/screens/splash_screen.dart';
import 'utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase (with error handling for missing config)
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print('Firebase initialization error: $e');
  }
  
  // Initialize Stripe
  Stripe.publishableKey = AppConstants.stripePublishableKey;
  
  // Set preferred orientations (horizontal support)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  
  runApp(const TokyoRouletteApp());
}

class TokyoRouletteApp extends StatelessWidget {
  const TokyoRouletteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => RouletteViewModel()),
      ],
      child: MaterialApp(
        title: 'Tokyo Roulette Predictor',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Neon theme with red/black/green colors
          primaryColor: AppColors.neonRed,
          scaffoldBackgroundColor: AppColors.darkBackground,
          colorScheme: ColorScheme.dark(
            primary: AppColors.neonRed,
            secondary: AppColors.neonGreen,
            error: AppColors.neonRed,
          ),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              color: AppColors.neonRed,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            bodyLarge: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.neonRed,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
