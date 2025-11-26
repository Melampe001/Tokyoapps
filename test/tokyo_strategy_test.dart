import 'package:flutter_test/flutter_test.dart';
import 'package:tokyo_roulette_app/utils/constants.dart';
import 'package:tokyo_roulette_app/services/prediction_service.dart';
import 'package:tokyo_roulette_app/models/spin_result.dart';
import 'package:tokyo_roulette_app/models/user_subscription.dart';

void main() {
  group('Tokyo Strategy Tests', () {
    test('Tokyo Strategy numbers are correctly defined', () {
      // Verify the 8 key numbers: 12, 35, 1, 17, 5, 27, 22, 29
      expect(RouletteConstants.tokyoStrategyNumbers.length, 8);
      expect(RouletteConstants.tokyoStrategyNumbers, containsAll([12, 35, 1, 17, 5, 27, 22, 29]));
      
      // Verify they are in the correct order
      expect(RouletteConstants.tokyoStrategyNumbers, [12, 35, 1, 17, 5, 27, 22, 29]);
    });
    
    test('Tokyo Strategy description is provided', () {
      expect(RouletteConstants.tokyoStrategyDescription, isNotEmpty);
      expect(RouletteConstants.tokyoStrategyDescription.contains('Tokyo Strategy'), isTrue);
      expect(RouletteConstants.tokyoStrategyDescription.contains('8-number'), isTrue);
    });
    
    test('Tokyo Strategy numbers cover multiple sectors', () {
      final tokyoNumbers = RouletteConstants.tokyoStrategyNumbers;
      
      // Check coverage in Voisins du Zéro (should have 12, 35, 22, 29)
      final voisinsNumbers = RouletteConstants.sectors['Voisins du Zéro']!;
      final voisinsCoverage = tokyoNumbers.where((n) => voisinsNumbers.contains(n)).toList();
      expect(voisinsCoverage.length, greaterThanOrEqualTo(3));
      expect(voisinsCoverage, containsAll([12, 35, 22, 29]));
      
      // Check coverage in Tiers du Cylindre (should have 5, 27)
      final tiersNumbers = RouletteConstants.sectors['Tiers du Cylindre']!;
      final tiersCoverage = tokyoNumbers.where((n) => tiersNumbers.contains(n)).toList();
      expect(tiersCoverage.length, greaterThanOrEqualTo(2));
      expect(tiersCoverage, containsAll([5, 27]));
      
      // Check coverage in Orphelins (should have 1, 17)
      final orphelinsNumbers = RouletteConstants.sectors['Orphelins']!;
      final orphelinsCoverage = tokyoNumbers.where((n) => orphelinsNumbers.contains(n)).toList();
      expect(orphelinsCoverage.length, greaterThanOrEqualTo(2));
      expect(orphelinsCoverage, containsAll([1, 17]));
    });
    
    test('Premium predictions include Tokyo Strategy numbers', () {
      final predictionService = PredictionService();
      
      // Create history with some Tokyo Strategy hits
      final history = <SpinResult>[
        SpinResult(number: 12, timestamp: DateTime.now()),
        SpinResult(number: 35, timestamp: DateTime.now()),
        SpinResult(number: 1, timestamp: DateTime.now()),
        SpinResult(number: 27, timestamp: DateTime.now()),
        SpinResult(number: 5, timestamp: DateTime.now()),
        // Add some other numbers
        SpinResult(number: 10, timestamp: DateTime.now()),
        SpinResult(number: 20, timestamp: DateTime.now()),
        SpinResult(number: 30, timestamp: DateTime.now()),
      ];
      
      final prediction = predictionService.generatePrediction(
        history: history,
        tier: SubscriptionTier.premium,
        isEuropean: true,
      );
      
      // Premium predictions should include Tokyo Strategy numbers
      expect(prediction.suggestedBets, isNotEmpty);
      
      // At least some Tokyo Strategy numbers should be in suggested bets
      final tokyoInSuggestions = prediction.suggestedBets
          .where((n) => RouletteConstants.tokyoStrategyNumbers.contains(n))
          .toList();
      expect(tokyoInSuggestions.length, greaterThan(0));
    });
    
    test('Premium strategy mentions Tokyo Strategy', () {
      final predictionService = PredictionService();
      
      // Create history with Tokyo Strategy hits
      final history = List.generate(30, (i) {
        final tokyoNumbers = RouletteConstants.tokyoStrategyNumbers;
        // Mix Tokyo numbers with regular numbers
        final number = i < 10 ? tokyoNumbers[i % 8] : i;
        return SpinResult(number: number, timestamp: DateTime.now());
      });
      
      final prediction = predictionService.generatePrediction(
        history: history,
        tier: SubscriptionTier.premium,
        isEuropean: true,
      );
      
      // Strategy should mention Tokyo Strategy for premium users
      expect(prediction.strategy.toLowerCase(), contains('tokyo'));
    });
    
    test('All Tokyo Strategy numbers are valid roulette numbers', () {
      // All numbers should be between 0 and 36 for European roulette
      for (final number in RouletteConstants.tokyoStrategyNumbers) {
        expect(number, greaterThanOrEqualTo(0));
        expect(number, lessThanOrEqualTo(36));
      }
    });
    
    test('Tokyo Strategy numbers have correct colors', () {
      final redNumbers = [1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36];
      
      // Check each Tokyo Strategy number
      for (final number in RouletteConstants.tokyoStrategyNumbers) {
        final color = AppColors.getNumberColor(number);
        
        if (number == 0) {
          expect(color, AppColors.neonGreen);
        } else if (redNumbers.contains(number)) {
          expect(color, AppColors.neonRed);
        } else {
          expect(color, AppColors.neonBlack);
        }
      }
    });
    
    test('Free tier does not get Tokyo Strategy recommendations', () {
      final predictionService = PredictionService();
      
      final history = List.generate(20, (i) => 
        SpinResult(number: i, timestamp: DateTime.now())
      );
      
      final prediction = predictionService.generatePrediction(
        history: history,
        tier: SubscriptionTier.free,
        isEuropean: true,
      );
      
      // Free tier should not mention Tokyo Strategy
      expect(prediction.strategy.toLowerCase(), isNot(contains('tokyo')));
      
      // Suggested bets should be limited (only top 3 hot numbers)
      expect(prediction.suggestedBets.length, lessThanOrEqualTo(3));
    });
    
    test('Advanced tier does not get Tokyo Strategy (Premium exclusive)', () {
      final predictionService = PredictionService();
      
      final history = List.generate(20, (i) => 
        SpinResult(number: i, timestamp: DateTime.now())
      );
      
      final prediction = predictionService.generatePrediction(
        history: history,
        tier: SubscriptionTier.advanced,
        isEuropean: true,
      );
      
      // Advanced tier should not mention Tokyo Strategy (premium only)
      expect(prediction.strategy.toLowerCase(), isNot(contains('tokyo')));
    });
  });
}
