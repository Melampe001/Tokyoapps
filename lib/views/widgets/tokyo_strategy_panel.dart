import 'package:flutter/material.dart';
import '../../utils/constants.dart';

/// Tokyo Strategy Panel Widget
/// Displays the Tokyo Strategy preset betting system with quick-bet functionality
class TokyoStrategyPanel extends StatelessWidget {
  final VoidCallback? onNumberTap;
  final bool isPremiumUser;

  const TokyoStrategyPanel({
    super.key,
    this.onNumberTap,
    this.isPremiumUser = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cardBackground,
      elevation: 8,
      shadowColor: AppColors.neonRed.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: AppColors.neonRed.withOpacity(0.5),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.stars,
                  color: AppColors.neonRed,
                  size: 28,
                ),
                const SizedBox(width: 8),
                Text(
                  'Tokyo Strategy',
                  style: TextStyle(
                    color: AppColors.neonRed,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: AppColors.neonRed.withOpacity(0.5),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                if (!isPremiumUser)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.neonGreen.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.neonGreen),
                    ),
                    child: Text(
                      'PREMIUM',
                      style: TextStyle(
                        color: AppColors.neonGreen,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Description
            Text(
              RouletteConstants.tokyoStrategyDescription,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 13,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            
            // Numbers Grid
            if (isPremiumUser)
              _buildNumbersGrid()
            else
              _buildLockedOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildNumbersGrid() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: RouletteConstants.tokyoStrategyNumbers.map((number) {
        final color = AppColors.getNumberColor(number);
        return GestureDetector(
          onTap: onNumberTap,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              border: Border.all(
                color: color,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.5),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: color,
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLockedOverlay() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.cardBackground.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.neonGreen.withOpacity(0.3),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock,
              color: AppColors.neonGreen,
              size: 40,
            ),
            const SizedBox(height: 8),
            Text(
              'Upgrade to Premium (\$299)',
              style: TextStyle(
                color: AppColors.neonGreen,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Unlock Tokyo Strategy and all advanced features',
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Tokyo Strategy Quick Info Widget
/// Compact version for display in prediction panel
class TokyoStrategyQuickInfo extends StatelessWidget {
  final bool isPremiumUser;

  const TokyoStrategyQuickInfo({
    super.key,
    this.isPremiumUser = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!isPremiumUser) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.neonRed.withOpacity(0.1),
            AppColors.neonGreen.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.neonRed.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.stars,
            color: AppColors.neonRed,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tokyo Strategy Active',
                  style: TextStyle(
                    color: AppColors.neonRed,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  RouletteConstants.tokyoStrategyNumbers.join(', '),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
