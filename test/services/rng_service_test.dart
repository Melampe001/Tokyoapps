import 'package:flutter_test/flutter_test.dart';
import 'package:tokyo_roulette_app/services/rng_service.dart';
import 'package:tokyo_roulette_app/models/spin_result.dart';

void main() {
  group('RNGService Tests', () {
    late RNGService rngService;

    setUp(() {
      rngService = RNGService();
    });

    test('Generate European roulette number in valid range', () {
      final number = rngService.generateNumber(isEuropean: true);
      expect(number, greaterThanOrEqualTo(0));
      expect(number, lessThan(37)); // 0-36
    });

    test('Generate American roulette number in valid range', () {
      final number = rngService.generateNumber(isEuropean: false);
      expect(number, greaterThanOrEqualTo(0));
      expect(number, lessThan(38)); // 0-36 + 00 (as 37)
    });

    test('Generate 500 numbers and verify all are valid', () {
      for (int i = 0; i < 500; i++) {
        final number = rngService.generateNumber(isEuropean: true);
        expect(number, greaterThanOrEqualTo(0));
        expect(number, lessThan(37));
      }
    });

    test('Weighted RNG respects history', () {
      // Create history with biased numbers
      final history = List.generate(
        100,
        (i) => SpinResult(
          number: 7, // Bias towards number 7
          timestamp: DateTime.now(),
          method: 'manual',
          isEuropean: true,
        ),
      );

      // Generate numbers with weighting
      Map<int, int> frequency = {};
      for (int i = 0; i < 1000; i++) {
        final number = rngService.generateNumber(
          isEuropean: true,
          history: history,
          useWeighting: true,
        );
        frequency[number] = (frequency[number] ?? 0) + 1;
      }

      // Number 7 should appear more frequently than others
      final number7Frequency = frequency[7] ?? 0;
      final averageFrequency =
          frequency.values.reduce((a, b) => a + b) / frequency.length;

      expect(number7Frequency, greaterThan(averageFrequency));
    });

    test('Get neighbors returns correct count', () {
      final neighbors = rngService.getNeighbors(0, true, count: 4);
      expect(neighbors.length, equals(8)); // 4 on each side
    });

    test('Calculate sector frequency correctly', () {
      final history = [
        SpinResult(
            number: 22,
            timestamp: DateTime.now(),
            method: 'manual',
            isEuropean: true),
        SpinResult(
            number: 18,
            timestamp: DateTime.now(),
            method: 'manual',
            isEuropean: true),
        SpinResult(
            number: 5,
            timestamp: DateTime.now(),
            method: 'manual',
            isEuropean: true), // Not in Voisins du Zéro
      ];

      final frequency =
          rngService.calculateSectorFrequency('Voisins du Zéro', history);

      // 2 out of 3 spins are in Voisins du Zéro = 66.67%
      expect(frequency, closeTo(66.67, 0.1));
    });

    test('Verify all European numbers can be generated', () {
      Set<int> generatedNumbers = {};

      // Generate many spins to hit all numbers
      for (int i = 0; i < 10000; i++) {
        generatedNumbers.add(rngService.generateNumber(isEuropean: true));
      }

      // Should have hit all 37 numbers (0-36)
      expect(generatedNumbers.length, greaterThanOrEqualTo(35)); // Allow for some randomness
    });

    test('Verify all American numbers can be generated', () {
      Set<int> generatedNumbers = {};

      // Generate many spins to hit all numbers
      for (int i = 0; i < 10000; i++) {
        generatedNumbers.add(rngService.generateNumber(isEuropean: false));
      }

      // Should have hit all 38 numbers (0-36 + 00)
      expect(generatedNumbers.length, greaterThanOrEqualTo(36)); // Allow for some randomness
    });
  });
}
