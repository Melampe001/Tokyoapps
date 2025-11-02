import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../viewmodels/roulette_viewmodel.dart';
import '../../models/user_subscription.dart';
import '../../utils/constants.dart';
import '../../utils/demo_mode.dart';

class SubscriptionUpgradeDialog extends StatelessWidget {
  const SubscriptionUpgradeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RouletteViewModel>(context, listen: false);
    
    return Dialog(
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'UPGRADE YOUR EXPERIENCE',
              style: TextStyle(
                color: AppColors.neonRed,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                shadows: [
                  Shadow(
                    color: AppColors.neonRed.withOpacity(0.5),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Demo mode indicator
            if (DemoMode.isEnabled)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.neonGreen.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.neonGreen,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.neonGreen,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        DemoMode.paymentDemoMessage,
                        style: TextStyle(
                          color: AppColors.neonGreen,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 24),
            
            // Current tier
            _buildCurrentTierBadge(viewModel.subscription.tier),
            const SizedBox(height: 24),
            
            // Free tier
            _buildTierCard(
              context: context,
              tier: SubscriptionTier.free,
              title: 'FREE',
              price: '\$0',
              features: [
                'Basic predictions',
                'Hot & cold numbers',
                'Manual spins',
                'Limited history',
              ],
              color: Colors.grey,
              isCurrentTier: viewModel.subscription.tier == SubscriptionTier.free,
              onSelect: null,
            ),
            const SizedBox(height: 16),
            
            // Advanced tier
            _buildTierCard(
              context: context,
              tier: SubscriptionTier.advanced,
              title: 'ADVANCED',
              price: '\$199',
              features: [
                '✓ Everything in Free',
                '✓ Voisins du Zéro predictions',
                '✓ Neighbor analysis',
                '✓ Camera OCR spins',
                '✓ Advanced statistics',
              ],
              color: Colors.blue,
              isCurrentTier: viewModel.subscription.tier == SubscriptionTier.advanced,
              onSelect: viewModel.subscription.tier == SubscriptionTier.free
                  ? () => _purchaseSubscription(context, viewModel, SubscriptionTier.advanced)
                  : null,
            ),
            const SizedBox(height: 16),
            
            // Premium tier
            _buildTierCard(
              context: context,
              tier: SubscriptionTier.premium,
              title: 'PREMIUM',
              price: '\$299',
              features: [
                '✓ Everything in Advanced',
                '✓ All sector predictions',
                '✓ Tiers du Cylindre',
                '✓ Orphelins & Jeu Zéro',
                '✓ Advanced strategies',
                '✓ Priority support',
              ],
              color: Colors.amber,
              isCurrentTier: viewModel.subscription.tier == SubscriptionTier.premium,
              onSelect: viewModel.subscription.tier != SubscriptionTier.premium
                  ? () => _purchaseSubscription(context, viewModel, SubscriptionTier.premium)
                  : null,
            ),
            const SizedBox(height: 24),
            
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Maybe Later',
                style: TextStyle(color: Colors.white60),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCurrentTierBadge(SubscriptionTier tier) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: _getTierColor(tier).withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _getTierColor(tier),
          width: 2,
        ),
      ),
      child: Text(
        'Current: ${tier.toString().split('.').last.toUpperCase()}',
        style: TextStyle(
          color: _getTierColor(tier),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  
  Widget _buildTierCard({
    required BuildContext context,
    required SubscriptionTier tier,
    required String title,
    required String price,
    required List<String> features,
    required Color color,
    required bool isCurrentTier,
    VoidCallback? onSelect,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrentTier ? color : color.withOpacity(0.3),
          width: isCurrentTier ? 3 : 1,
        ),
        boxShadow: isCurrentTier ? [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ] : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                price,
                style: TextStyle(
                  color: color,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(color: Colors.white24, height: 16),
          ...features.map((feature) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              feature,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
              ),
            ),
          )).toList(),
          if (onSelect != null) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onSelect,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                ),
                child: const Text('UPGRADE NOW'),
              ),
            ),
          ],
          if (isCurrentTier) ...[
            const SizedBox(height: 8),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.neonGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'ACTIVE',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
  
  Future<void> _purchaseSubscription(
    BuildContext context,
    RouletteViewModel viewModel,
    SubscriptionTier tier,
  ) async {
    try {
      // Show loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      
      // PRODUCTION TODO:
      // 1. Create payment intent on your backend server
      // 2. Present Stripe payment sheet with Flutter Stripe SDK
      // 3. Confirm payment with Stripe
      // 4. Verify payment on backend before updating subscription
      // 5. Update subscription in Firebase and local storage
      
      // DEMO ONLY: Simulate purchase without real payment
      // WARNING: Never update subscription without payment verification in production
      await Future.delayed(const Duration(seconds: 2));
      await viewModel.updateSubscription(tier);
      
      // Close loading dialog
      if (context.mounted) Navigator.pop(context);
      
      // Close subscription dialog
      if (context.mounted) Navigator.pop(context);
      
      // Show success
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully upgraded to ${tier.toString().split('.').last}!'),
            backgroundColor: AppColors.neonGreen,
          ),
        );
      }
    } catch (e) {
      // Close loading dialog
      if (context.mounted) Navigator.pop(context);
      
      // Show error
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Purchase failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
  
  Color _getTierColor(SubscriptionTier tier) {
    switch (tier) {
      case SubscriptionTier.free:
        return Colors.grey;
      case SubscriptionTier.advanced:
        return Colors.blue;
      case SubscriptionTier.premium:
        return Colors.amber;
    }
  }
}
