import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../utils/constants.dart';
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  
  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    
    _controller.forward();
    
    // Auto-navigate after splash
    Future.delayed(const Duration(seconds: 3), () {
      _navigateToMain();
    });
  }
  
  void _navigateToMain() async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    
    // Sign in anonymously if not authenticated
    if (!authViewModel.isAuthenticated) {
      await authViewModel.signInAnonymously();
    }
    
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    }
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Neon effect icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.neonRed.withOpacity(0.5),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.casino,
                  size: 80,
                  color: AppColors.neonRed,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'TOKYO ROULETTE',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  shadows: [
                    Shadow(
                      color: AppColors.neonRed.withOpacity(0.8),
                      blurRadius: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'AI-Powered Predictions',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.neonGreen,
                  shadows: [
                    Shadow(
                      color: AppColors.neonGreen.withOpacity(0.8),
                      blurRadius: 15,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.neonRed),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
