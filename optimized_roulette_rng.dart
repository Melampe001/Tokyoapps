import 'dart:math';

/// Optimized RouletteRNG with performance improvements
/// 
/// Key optimizations:
/// 1. Reuses single Random instance instead of creating new ones
/// 2. Pre-builds index maps for O(1) lookups
/// 3. Caches wheel configurations
/// 4. Removes unnecessary dependencies on pointycastle
class OptimizedRouletteRNG {
  // Reuse single Random instance - PERFORMANCE IMPROVEMENT
  final Random _rng = Random.secure();
  
  final List<int> europeanWheel = List.generate(37, (i) => i);
  // American roulette wheel in actual physical order
  // Note: 37 is used to represent '00' for simplicity in this implementation
  // In production, you may want to use a separate type or enum to distinguish 00 from regular numbers
  final List<int> americanWheel = [
    0, 28, 9, 26, 30, 11, 7, 20, 32, 17, 5, 22, 34, 15, 3, 24, 36, 13, 1,
    37, // 37 represents '00' - this is a simplified encoding
    27, 10, 25, 29, 12, 8, 19, 31, 18, 6, 21, 33, 16, 4, 23, 35, 14, 2
  ];

  // Pre-built index maps for O(1) lookups - PERFORMANCE IMPROVEMENT
  late final Map<int, int> _europeanIndex;
  late final Map<int, int> _americanIndex;

  // Sector definitions (European roulette)
  final Map<String, List<int>> sectors = {
    'Voisins du Zéro': [22, 18, 29, 7, 28, 12, 35, 3, 26, 0, 32, 15, 19, 4, 21, 2, 25],
    'Tiers du Cylindre': [27, 13, 36, 11, 30, 8, 23, 10, 5, 24, 16, 33],
    'Orphelins': [17, 34, 6, 1, 20, 14, 31, 9],
    'Jeu Zéro': [12, 35, 3, 26, 0, 32, 15],
  };

  OptimizedRouletteRNG() {
    _buildIndexMaps();
  }

  /// Build index maps once during initialization
  void _buildIndexMaps() {
    _europeanIndex = {};
    _americanIndex = {};
    
    for (int i = 0; i < europeanWheel.length; i++) {
      _europeanIndex[europeanWheel[i]] = i;
    }
    
    for (int i = 0; i < americanWheel.length; i++) {
      _americanIndex[americanWheel[i]] = i;
    }
  }

  /// Generate a random roulette result
  /// 
  /// PERFORMANCE: O(1) - uses pre-initialized RNG
  /// Previously: Created new RNG instance and seed on every call
  int generateResult(bool isEuropean) {
    final wheel = isEuropean ? europeanWheel : americanWheel;
    return wheel[_rng.nextInt(wheel.length)];
  }

  /// Get neighboring numbers on the wheel
  /// 
  /// PERFORMANCE: O(1) lookup using index map instead of O(n) indexOf
  /// Returns neighbors in wheel order (not sorted for performance)
  List<int> getNeighbors(int number, bool isEuropean, {int count = 4}) {
    final wheel = isEuropean ? europeanWheel : americanWheel;
    final indexMap = isEuropean ? _europeanIndex : _americanIndex;
    
    final index = indexMap[number];
    if (index == null) return [];
    
    final neighbors = <int>[];
    for (int i = 1; i <= count; i++) {
      neighbors.add(wheel[(index + i) % wheel.length]);
      neighbors.add(wheel[(index - i + wheel.length) % wheel.length]);
    }
    
    return neighbors;
  }

  /// Check if a number belongs to a specific sector
  /// 
  /// PERFORMANCE: O(1) with proper data structure
  bool isInSector(int number, String sectorName) {
    return sectors[sectorName]?.contains(number) ?? false;
  }

  /// Get all sectors that contain a number
  /// 
  /// Useful for incremental sector frequency updates
  List<String> getSectorsForNumber(int number) {
    return sectors.entries
        .where((entry) => entry.value.contains(number))
        .map((entry) => entry.key)
        .toList();
  }
}
