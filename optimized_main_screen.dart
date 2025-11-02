import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Optimized MainScreen with performance improvements
/// 
/// Key optimizations:
/// 1. Incremental frequency updates (O(1) instead of O(n))
/// 2. Cached sector frequencies
/// 3. Bounded history with circular buffer
/// 4. Batched Firestore writes
/// 5. Reduced widget rebuilds
class OptimizedMainScreen extends StatefulWidget {
  @override
  _OptimizedMainScreenState createState() => _OptimizedMainScreenState();
}

class _OptimizedMainScreenState extends State<OptimizedMainScreen> {
  // Configuration
  static const int MAX_HISTORY = 1000;  // Prevent unbounded memory growth
  static const int BATCH_WRITE_SIZE = 50;
  static const Duration BATCH_WRITE_INTERVAL = Duration(seconds: 30);

  // State
  bool isEuropean = true;
  final Queue<int> history = Queue<int>();  // Circular buffer
  late final OptimizedRouletteRNG rng;
  String prediction = '';
  int subscriptionLevel = 0;

  // PERFORMANCE IMPROVEMENT: Cached frequencies for O(1) updates
  final Map<int, int> _frequencyCache = {};
  final Map<String, int> _sectorFrequencyCache = {};

  // Firestore batching
  final List<Map<String, dynamic>> _pendingWrites = [];
  Timer? _writeTimer;

  @override
  void initState() {
    super.initState();
    rng = OptimizedRouletteRNG();
    _loadPreferences();
    _initializeFrequencyCaches();
    
    // Start periodic batch write timer
    _writeTimer = Timer.periodic(BATCH_WRITE_INTERVAL, (_) {
      _flushPendingWrites();
    });
  }

  @override
  void dispose() {
    _writeTimer?.cancel();
    _flushPendingWrites();  // Flush any remaining writes
    super.dispose();
  }

  /// Initialize frequency caches with all possible numbers
  void _initializeFrequencyCaches() {
    final wheel = isEuropean ? rng.europeanWheel : rng.americanWheel;
    for (var num in wheel) {
      _frequencyCache[num] = 0;
    }
    
    for (var sector in rng.sectors.keys) {
      _sectorFrequencyCache[sector] = 0;
    }
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      subscriptionLevel = prefs.getInt('subscriptionLevel') ?? 0;
    });
  }

  /// OPTIMIZED: Incremental frequency update - O(1) instead of O(n)
  void _spin() {
    final result = rng.generateResult(isEuropean);
    
    setState(() {
      // Add to history with circular buffer management
      history.add(result);
      
      // Incremental frequency update
      _frequencyCache[result] = (_frequencyCache[result] ?? 0) + 1;
      
      // Update sector frequencies incrementally
      for (var sector in rng.getSectorsForNumber(result)) {
        _sectorFrequencyCache[sector] = (_sectorFrequencyCache[sector] ?? 0) + 1;
      }
      
      // Remove oldest entry if over limit
      if (history.length > MAX_HISTORY) {
        _removeOldestFromCache();
      }
      
      // Generate prediction using cached data
      prediction = _predictNext();
    });
    
    // Queue for batch write
    if (subscriptionLevel > 0) {
      _queueFirestoreWrite(result);
    }
  }

  /// Remove oldest entry from caches when history exceeds limit
  void _removeOldestFromCache() {
    final removed = history.removeFirst();
    
    // Decrement frequency
    _frequencyCache[removed] = (_frequencyCache[removed] ?? 1) - 1;
    if (_frequencyCache[removed]! <= 0) {
      _frequencyCache.remove(removed);
    }
    
    // Update sector frequencies
    for (var sector in rng.getSectorsForNumber(removed)) {
      _sectorFrequencyCache[sector] = (_sectorFrequencyCache[sector] ?? 1) - 1;
    }
  }

  /// OPTIMIZED: Uses cached frequencies instead of recalculating
  String _predictNext() {
    if (history.isEmpty) {
      return 'No hay historial para proyecciones.';
    }

    // Sort cached frequencies - O(m log m) where m is wheel size
    final sortedFreq = _frequencyCache.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    final hot = sortedFreq.take(5).map((e) => e.key).toList();
    final cold = sortedFreq.reversed.take(5).map((e) => e.key).toList();

    var proj = 'Proyección básica:\n';
    proj += 'Calientes: ${hot.join(", ")}\n';
    proj += 'Fríos: ${cold.join(", ")}';

    // Advanced predictions for paid tiers
    if (subscriptionLevel >= 1 && history.isNotEmpty) {
      final lastNumber = history.last;
      final neighbors = rng.getNeighbors(lastNumber, isEuropean);
      proj += '\n\nVecinos de $lastNumber: ${neighbors.join(", ")}';
      
      // Show one sector as teaser
      final sectorFreq = _getSectorFrequency('Voisins du Zéro');
      proj += '\nVoisins du Zéro: ${sectorFreq.toStringAsFixed(1)}%';
    }

    // Full sector analysis for premium tier
    if (subscriptionLevel == 2) {
      proj += '\n\nAnálisis completo de sectores:';
      for (var entry in rng.sectors.entries) {
        final freq = _getSectorFrequency(entry.key);
        proj += '\n${entry.key}: ${freq.toStringAsFixed(1)}%';
      }
    }

    return proj;
  }

  /// OPTIMIZED: O(1) lookup from cache instead of O(n) iteration
  double _getSectorFrequency(String sector) {
    if (history.isEmpty) return 0.0;
    final count = _sectorFrequencyCache[sector] ?? 0;
    return (count / history.length) * 100;
  }

  /// Queue a Firestore write for batching
  void _queueFirestoreWrite(int result) {
    _pendingWrites.add({
      'result': result,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
    
    // Flush if batch is full
    if (_pendingWrites.length >= BATCH_WRITE_SIZE) {
      _flushPendingWrites();
    }
  }

  /// OPTIMIZED: Batch writes instead of individual writes per spin
  Future<void> _flushPendingWrites() async {
    if (_pendingWrites.isEmpty) return;
    
    try {
      final batch = FirebaseFirestore.instance.batch();
      final collection = FirebaseFirestore.instance
          .collection('users')
          .doc('current_user')  // Replace with actual user ID
          .collection('spins');
      
      for (var data in _pendingWrites) {
        batch.set(
          collection.doc(),
          {
            ...data,
            'serverTimestamp': FieldValue.serverTimestamp(),
          },
        );
      }
      
      await batch.commit();
      _pendingWrites.clear();
    } catch (e) {
      debugPrint('Error flushing writes: $e');
      // Keep pending writes for retry
    }
  }

  /// Reset wheel type and clear caches
  void _switchWheelType(bool european) {
    setState(() {
      isEuropean = european;
      history.clear();
      _frequencyCache.clear();
      _sectorFrequencyCache.clear();
      _initializeFrequencyCaches();
      prediction = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ruleta Optimizada'),
        actions: [
          // Show history size for transparency
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Chip(
              label: Text('${history.length} giros'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: const Text('Europea/Americana'),
            subtitle: Text(isEuropean ? 'Europea (37 números)' : 'Americana (38 números)'),
            value: isEuropean,
            onChanged: _switchWheelType,
          ),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _spin,
              child: const Text('Girar', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
              ),
            ),
          ),
          
          if (history.isNotEmpty) ...[
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Último resultado: ${history.last}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Total de giros: ${history.length}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Predicción:',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(prediction),
                    
                    if (subscriptionLevel == 0) ...[
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Implement upgrade logic
                        },
                        icon: const Icon(Icons.upgrade),
                        label: const Text('Actualizar a Avanzado (\$199)'),
                      ),
                    ],
                    
                    if (subscriptionLevel == 1) ...[
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Implement upgrade logic
                        },
                        icon: const Icon(Icons.upgrade),
                        label: const Text('Actualizar a Premium (\$299)'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ] else
            const Expanded(
              child: Center(
                child: Text('Gira la ruleta para ver predicciones'),
              ),
            ),
          
          // Performance indicator
          if (_pendingWrites.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.amber.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  const SizedBox(width: 8),
                  Text('Sincronizando ${_pendingWrites.length} giros...'),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// Stub for the optimized RNG (would be imported)
class OptimizedRouletteRNG {
  final List<int> europeanWheel = List.generate(37, (i) => i);
  final List<int> americanWheel = List.generate(38, (i) => i);
  final Map<String, List<int>> sectors = {};
  
  int generateResult(bool isEuropean) => 0;
  List<int> getNeighbors(int number, bool isEuropean) => [];
  List<String> getSectorsForNumber(int number) => [];
}
