import '../models/spin_result.dart';
import '../models/prediction.dart';
import '../models/user_subscription.dart';
import '../utils/constants.dart';
import 'rng_service.dart';

class PredictionService {
  final RNGService _rngService = RNGService();
  
  /// Generate prediction based on history and subscription tier
  Prediction generatePrediction({
    required List<SpinResult> history,
    required SubscriptionTier tier,
    required bool isEuropean,
  }) {
    if (history.isEmpty) {
      return Prediction(
        hotNumbers: [],
        coldNumbers: [],
        sectorFrequencies: {},
        suggestedBets: [],
        confidence: 0.0,
        strategy: 'No data available',
      );
    }
    
    // Calculate number frequencies
    final maxNumber = isEuropean ? AppConstants.europeanWheelSize : AppConstants.americanWheelSize;
    Map<int, int> frequency = {};
    
    for (int i = 0; i < maxNumber; i++) {
      frequency[i] = 0;
    }
    
    for (var spin in history) {
      frequency[spin.number] = (frequency[spin.number] ?? 0) + 1;
    }
    
    // Sort by frequency
    var sortedNumbers = frequency.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    final hotNumbers = sortedNumbers.take(10).map((e) => e.key).toList();
    final coldNumbers = sortedNumbers.reversed.take(10).map((e) => e.key).toList();
    
    // Calculate sector frequencies (available for advanced and premium)
    Map<String, double> sectorFrequencies = {};
    if (tier == SubscriptionTier.advanced || tier == SubscriptionTier.premium) {
      RouletteConstants.sectors.forEach((sectorName, _) {
        sectorFrequencies[sectorName] = _rngService.calculateSectorFrequency(sectorName, history);
      });
    }
    
    // Generate suggested bets based on tier
    List<int> suggestedBets = _generateSuggestedBets(
      history: history,
      tier: tier,
      hotNumbers: hotNumbers,
      isEuropean: isEuropean,
    );
    
    // Calculate confidence based on data size
    double confidence = _calculateConfidence(history.length);
    
    // Determine strategy
    String strategy = _determineStrategy(tier, history, hotNumbers, coldNumbers);
    
    return Prediction(
      hotNumbers: hotNumbers,
      coldNumbers: coldNumbers,
      sectorFrequencies: sectorFrequencies,
      suggestedBets: suggestedBets,
      confidence: confidence,
      strategy: strategy,
    );
  }
  
  List<int> _generateSuggestedBets({
    required List<SpinResult> history,
    required SubscriptionTier tier,
    required List<int> hotNumbers,
    required bool isEuropean,
  }) {
    switch (tier) {
      case SubscriptionTier.free:
        // Free: Only top 3 hot numbers
        return hotNumbers.take(3).toList();
        
      case SubscriptionTier.advanced:
        // Advanced: Top 5 hot + neighbors of last number
        final suggested = hotNumbers.take(5).toList();
        if (history.isNotEmpty) {
          final neighbors = _rngService.getNeighbors(history.last.number, isEuropean, count: 2);
          suggested.addAll(neighbors.where((n) => !suggested.contains(n)).take(3));
        }
        return suggested;
        
      case SubscriptionTier.premium:
        // Premium: Include Tokyo Strategy numbers + sector analysis
        final suggested = <int>[];
        
        // Add Tokyo Strategy numbers first (prioritized)
        suggested.addAll(RouletteConstants.tokyoStrategyNumbers);
        
        // Add hot numbers that aren't already in Tokyo Strategy
        suggested.addAll(
          hotNumbers.where((n) => !suggested.contains(n)).take(3)
        );
        
        // Find best performing sector and add additional numbers
        double maxFreq = 0.0;
        String bestSector = '';
        RouletteConstants.sectors.forEach((sectorName, _) {
          final freq = _rngService.calculateSectorFrequency(sectorName, history);
          if (freq > maxFreq) {
            maxFreq = freq;
            bestSector = sectorName;
          }
        });
        
        if (bestSector.isNotEmpty) {
          final sectorNumbers = RouletteConstants.sectors[bestSector] ?? [];
          suggested.addAll(sectorNumbers.where((n) => !suggested.contains(n)).take(2));
        }
        
        return suggested;
    }
  }
  
  double _calculateConfidence(int historySize) {
    // Confidence increases with more data, caps at 85%
    if (historySize < 10) return 0.2;
    if (historySize < 50) return 0.4;
    if (historySize < 100) return 0.6;
    if (historySize < 300) return 0.75;
    return 0.85;
  }
  
  String _determineStrategy(
    SubscriptionTier tier,
    List<SpinResult> history,
    List<int> hotNumbers,
    List<int> coldNumbers,
  ) {
    if (tier == SubscriptionTier.free) {
      return 'Basic: Follow hot numbers';
    }
    
    // Check Tokyo Strategy coverage for premium users
    if (tier == SubscriptionTier.premium) {
      final tokyoNumbers = RouletteConstants.tokyoStrategyNumbers;
      final recentHistory = history.take(20).toList();
      final tokyoHits = recentHistory.where((s) => tokyoNumbers.contains(s.number)).length;
      
      if (tokyoHits >= 5) {
        return 'Tokyo Strategy: Strong performance! Continue with Tokyo numbers (${tokyoNumbers.join(', ')})';
      } else if (tokyoHits >= 3) {
        return 'Tokyo Strategy: Moderate activity. Wait 3-4 spins, then bet Tokyo numbers';
      } else {
        return 'Tokyo Strategy: Low activity. Consider sector-based bets or wait for pattern';
      }
    }
    
    // Analyze recent trend for advanced tier
    final recentHistory = history.take(20).toList();
    final recentHotCount = recentHistory.where((s) => hotNumbers.contains(s.number)).length;
    
    if (recentHotCount > 12) {
      return 'Follow the hot streak';
    } else if (recentHotCount < 6) {
      return 'Hot numbers cooling off';
    } else {
      return 'Balanced approach recommended';
    }
  }
}
