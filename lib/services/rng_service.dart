import 'dart:math';
import '../models/spin_result.dart';
import '../utils/constants.dart';

/// Weighted RNG service based on historical data
class RNGService {
  final Random _random = Random.secure();
  
  /// Generate a random number with optional weighting based on history
  int generateNumber({
    required bool isEuropean,
    List<SpinResult>? history,
    bool useWeighting = false,
  }) {
    final maxNumber = isEuropean ? AppConstants.europeanWheelSize : AppConstants.americanWheelSize;
    
    if (!useWeighting || history == null || history.isEmpty) {
      // Pure random generation
      return _random.nextInt(maxNumber);
    }
    
    // Calculate weights based on history
    final weights = _calculateWeights(history, maxNumber);
    final totalWeight = weights.values.reduce((a, b) => a + b);
    
    // Weighted random selection
    double randomValue = _random.nextDouble() * totalWeight;
    double cumulative = 0.0;
    
    for (int number = 0; number < maxNumber; number++) {
      cumulative += weights[number]!;
      if (randomValue <= cumulative) {
        return number;
      }
    }
    
    return _random.nextInt(maxNumber);
  }
  
  Map<int, double> _calculateWeights(List<SpinResult> history, int maxNumber) {
    // Initialize weights with base probability
    Map<int, double> weights = {};
    for (int i = 0; i < maxNumber; i++) {
      weights[i] = 1.0;
    }
    
    // Adjust weights based on recent history (recency bias)
    final recentHistory = history.take(100).toList();
    Map<int, int> frequency = {};
    
    for (var spin in recentHistory) {
      frequency[spin.number] = (frequency[spin.number] ?? 0) + 1;
    }
    
    // Apply slight weighting - numbers that appeared more recently get slightly higher weight
    frequency.forEach((number, count) {
      // Increase weight by 5% for each occurrence
      weights[number] = weights[number]! * (1.0 + (count * 0.05));
    });
    
    return weights;
  }
  
  /// Get neighbors of a number on the wheel
  List<int> getNeighbors(int number, bool isEuropean, {int count = 4}) {
    final wheel = isEuropean ? RouletteConstants.europeanWheel : RouletteConstants.americanWheel;
    final index = wheel.indexOf(number);
    
    if (index == -1) return [];
    
    List<int> neighbors = [];
    for (int i = 1; i <= count; i++) {
      neighbors.add(wheel[(index + i) % wheel.length]);
      neighbors.add(wheel[(index - i + wheel.length) % wheel.length]);
    }
    
    return neighbors;
  }
  
  /// Calculate sector frequency from history
  double calculateSectorFrequency(String sectorName, List<SpinResult> history) {
    if (history.isEmpty) return 0.0;
    
    final sectorNumbers = RouletteConstants.sectors[sectorName] ?? [];
    final sectorHits = history.where((spin) => sectorNumbers.contains(spin.number)).length;
    
    return (sectorHits / history.length) * 100;
  }
}
