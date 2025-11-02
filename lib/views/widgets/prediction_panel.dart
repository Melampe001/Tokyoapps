import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/roulette_viewmodel.dart';
import '../../utils/constants.dart';

class PredictionPanel extends StatelessWidget {
  const PredictionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RouletteViewModel>(context);
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.neonRed.withOpacity(0.5),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonRed.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.psychology,
                color: AppColors.neonRed,
                size: 28,
                shadows: [
                  Shadow(
                    color: AppColors.neonRed.withOpacity(0.8),
                    blurRadius: 15,
                  ),
                ],
              ),
              const SizedBox(width: 12),
              const Text(
                'AI PREDICTION',
                style: TextStyle(
                  color: AppColors.neonRed,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          const Divider(color: Colors.white24, height: 24),
          
          if (viewModel.currentPrediction != null) ...[
            // Confidence indicator
            Row(
              children: [
                const Text(
                  'CONFIDENCE:',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: LinearProgressIndicator(
                    value: viewModel.currentPrediction!.confidence,
                    backgroundColor: Colors.white10,
                    valueColor: AlwaysStoppedAnimation(
                      viewModel.currentPrediction!.confidence > 0.7
                          ? AppColors.neonGreen
                          : AppColors.neonRed,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${(viewModel.currentPrediction!.confidence * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                    color: viewModel.currentPrediction!.confidence > 0.7
                        ? AppColors.neonGreen
                        : AppColors.neonRed,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Prediction text
            Text(
              viewModel.getPredictionText(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            
            // Suggested bets
            if (viewModel.currentPrediction!.suggestedBets.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text(
                'SUGGESTED BETS:',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: viewModel.currentPrediction!.suggestedBets.take(8).map((number) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.getNumberColor(number).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.getNumberColor(number),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.getNumberColor(number).withOpacity(0.5),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Text(
                      number == 37 ? '00' : '$number',
                      style: TextStyle(
                        color: AppColors.getNumberColor(number),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ] else ...[
            const Center(
              child: Text(
                'Spin the wheel to generate predictions',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
