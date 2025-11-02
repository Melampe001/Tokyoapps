import 'package:flutter_test/flutter_test.dart';
import 'package:tokyo_roulette_app/services/prediction_service.dart';
import 'package:tokyo_roulette_app/models/spin_result.dart';
import 'package:tokyo_roulette_app/models/user_subscription.dart';

void main() {
  group('PredictionService Tests', () {
    late PredictionService predictionService;

    setUp(() {
      predictionService = PredictionService();
    });

    test('Generate prediction with empty history', () {
      final prediction = predictionService.generatePrediction(
        history: [],
        tier: SubscriptionTier.free,
        isEuropean: true,
      );

      expect(prediction.hotNumbers, isEmpty);
      expect(prediction.coldNumbers, isEmpty);
      expect(prediction.confidence, equals(0.0));
    });

    test('Free tier prediction excludes sector data', () {
      final history = List.generate(
        50,
        (i) => SpinResult(
          number: i % 37,
          timestamp: DateTime.now(),
          method: 'manual',
          isEuropean: true,
        ),
      );

      final prediction = predictionService.generatePrediction(
        history: history,
        tier: SubscriptionTier.free,
        isEuropean: true,
      );

      expect(prediction.hotNumbers, isNotEmpty);
      expect(prediction.coldNumbers, isNotEmpty);
      expect(prediction.sectorFrequencies, isEmpty);
      expect(prediction.suggestedBets.length, lessThanOrEqualTo(3));
    });

    test('Advanced tier includes sector data', () {
      final history = List.generate(
        50,
        (i) => SpinResult(
          number: i % 37,
          timestamp: DateTime.now(),
          method: 'manual',
          isEuropean: true,
        ),
      );

      final prediction = predictionService.generatePrediction(
        history: history,
        tier: SubscriptionTier.advanced,
        isEuropean: true,
      );

      expect(prediction.sectorFrequencies, isNotEmpty);
      expect(prediction.sectorFrequencies.keys, contains('Voisins du Zéro'));
    });

    test('Premium tier includes all sectors', () {
      final history = List.generate(
        100,
        (i) => SpinResult(
          number: i % 37,
          timestamp: DateTime.now(),
          method: 'manual',
          isEuropean: true,
        ),
      );

      final prediction = predictionService.generatePrediction(
        history: history,
        tier: SubscriptionTier.premium,
        isEuropean: true,
      );

      expect(prediction.sectorFrequencies.keys, contains('Voisins du Zéro'));
      expect(prediction.sectorFrequencies.keys, contains('Tiers du Cylindre'));
      expect(prediction.sectorFrequencies.keys, contains('Orphelins'));
      expect(prediction.sectorFrequencies.keys, contains('Jeu Zéro'));
    });

    test('Confidence increases with more data', () {
      final smallHistory = List.generate(
        10,
        (i) => SpinResult(
          number: i % 37,
          timestamp: DateTime.now(),
          method: 'manual',
          isEuropean: true,
        ),
      );

      final largeHistory = List.generate(
        500,
        (i) => SpinResult(
          number: i % 37,
          timestamp: DateTime.now(),
          method: 'manual',
          isEuropean: true,
        ),
      );

      final smallPrediction = predictionService.generatePrediction(
        history: smallHistory,
        tier: SubscriptionTier.free,
        isEuropean: true,
      );

      final largePrediction = predictionService.generatePrediction(
        history: largeHistory,
        tier: SubscriptionTier.free,
        isEuropean: true,
      );

      expect(largePrediction.confidence,
          greaterThan(smallPrediction.confidence));
    });

    test('Hot numbers are correctly identified', () {
      // Create history with number 17 appearing most frequently
      final history = <SpinResult>[
        ...List.generate(
            20,
            (i) => SpinResult(
                number: 17,
                timestamp: DateTime.now(),
                method: 'manual',
                isEuropean: true)),
        ...List.generate(
            10,
            (i) => SpinResult(
                number: 5,
                timestamp: DateTime.now(),
                method: 'manual',
                isEuropean: true)),
        ...List.generate(
            5,
            (i) => SpinResult(
                number: i,
                timestamp: DateTime.now(),
                method: 'manual',
                isEuropean: true)),
      ];

      final prediction = predictionService.generatePrediction(
        history: history,
        tier: SubscriptionTier.free,
        isEuropean: true,
      );

      expect(prediction.hotNumbers.first, equals(17));
    });

    test('Prediction handles both roulette types', () {
      final europeanHistory = List.generate(
        50,
        (i) => SpinResult(
          number: i % 37,
          timestamp: DateTime.now(),
          method: 'manual',
          isEuropean: true,
        ),
      );

      final americanHistory = List.generate(
        50,
        (i) => SpinResult(
          number: i % 38,
          timestamp: DateTime.now(),
          method: 'manual',
          isEuropean: false,
        ),
      );

      final europeanPrediction = predictionService.generatePrediction(
        history: europeanHistory,
        tier: SubscriptionTier.free,
        isEuropean: true,
      );

      final americanPrediction = predictionService.generatePrediction(
        history: americanHistory,
        tier: SubscriptionTier.free,
        isEuropean: false,
      );

      expect(europeanPrediction.hotNumbers, isNotEmpty);
      expect(americanPrediction.hotNumbers, isNotEmpty);
    });
  });
}
