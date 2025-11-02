# Performance Optimization Quick Reference

A quick lookup guide for common performance issues and their solutions.

## 🔍 Quick Diagnostics

### Symptom: App becomes slower over time
**Likely Cause**: Unbounded data growth
**Solution**: Implement circular buffer (see [BEST_PRACTICES.md](BEST_PRACTICES.md#bounded-collections))

### Symptom: UI freezes during operations
**Likely Cause**: Expensive calculations on UI thread
**Solution**: Use incremental updates or compute isolates

### Symptom: High memory usage
**Likely Cause**: Caching too much data or memory leaks
**Solution**: Implement LRU cache or bounded collections

### Symptom: Poor frame rate (< 60 FPS)
**Likely Cause**: Too many widget rebuilds
**Solution**: Use const constructors and separate stateful widgets

### Symptom: Slow database operations
**Likely Cause**: Individual writes instead of batching
**Solution**: Batch operations (see [BEST_PRACTICES.md](BEST_PRACTICES.md#batch-database-operations))

## ⚡ Quick Fixes

### Fix #1: Frequency Calculation
```dart
// ❌ SLOW
Map<int, int> calculateFreq(List<int> history) {
  Map<int, int> freq = {};
  for (var num in history) {
    freq[num] = (freq[num] ?? 0) + 1;
  }
  return freq;
}

// ✅ FAST
Map<int, int> _freqCache = {};
void updateFreq(int newNum) {
  _freqCache[newNum] = (_freqCache[newNum] ?? 0) + 1;
}
```

### Fix #2: List Lookups
```dart
// ❌ SLOW - O(n)
List<int> numbers = [1, 2, 3, 4, 5];
bool found = numbers.contains(3);

// ✅ FAST - O(1)
Set<int> numbers = {1, 2, 3, 4, 5};
bool found = numbers.contains(3);
```

### Fix #3: Widget Rebuilds
```dart
// ❌ SLOW
Widget build(BuildContext context) {
  return Text('Static');
}

// ✅ FAST
Widget build(BuildContext context) {
  return const Text('Static');
}
```

### Fix #4: String Concatenation
```dart
// ❌ SLOW
String result = '';
for (var item in items) {
  result += item;
}

// ✅ FAST
StringBuffer buffer = StringBuffer();
for (var item in items) {
  buffer.write(item);
}
String result = buffer.toString();
```

### Fix #5: Database Writes
```dart
// ❌ SLOW
for (var item in items) {
  await db.save(item);
}

// ✅ FAST
final batch = db.batch();
for (var item in items) {
  batch.set(doc, item);
}
await batch.commit();
```

## 📊 Complexity Reference

| Operation | Bad | Good | Speedup |
|-----------|-----|------|---------|
| Lookup | List O(n) | Set/Map O(1) | n times |
| Frequency calc | Recalc O(n) | Incremental O(1) | n times |
| String concat | += O(n²) | StringBuffer O(n) | n times |
| DB writes | Individual | Batched | 50x |
| Widget build | Dynamic | const | 2-5x |

## 🎯 Priority Matrix

Fix in this order for maximum impact:

1. **Critical** (Fix Immediately)
   - Unbounded list growth
   - Frequency recalculation in loops
   - Individual database writes

2. **High** (Fix Soon)
   - Expensive operations on UI thread
   - Missing const constructors
   - Linear searches in hot paths

3. **Medium** (Fix When Possible)
   - String concatenation in loops
   - Unnecessary widget rebuilds
   - Missing caching

4. **Low** (Nice to Have)
   - Micro-optimizations
   - Code style improvements
   - Documentation updates

## 🔧 Tools

### Profiling
```bash
# Run Flutter in profile mode
flutter run --profile

# Open DevTools
flutter pub global activate devtools
flutter pub global run devtools
```

### Benchmarking
```dart
import 'dart:developer';

void measurePerformance() {
  Timeline.startSync('myOperation');
  // Your code
  Timeline.finishSync();
}
```

### Memory Monitoring
```dart
import 'dart:developer';

void checkMemory() {
  print('RSS: ${ProcessInfo.currentRss}');
  print('Max RSS: ${ProcessInfo.maxRss}');
}
```

## 📚 Full Documentation

- [PERFORMANCE_IMPROVEMENTS.md](PERFORMANCE_IMPROVEMENTS.md) - Detailed analysis of issues
- [BEST_PRACTICES.md](BEST_PRACTICES.md) - Best practices guide
- [BENCHMARK_RESULTS.md](BENCHMARK_RESULTS.md) - Performance metrics
- [optimized_roulette_rng.dart](optimized_roulette_rng.dart) - Optimized RNG implementation
- [optimized_main_screen.dart](optimized_main_screen.dart) - Optimized UI implementation

## 🚀 Getting Started

1. Read [PERFORMANCE_IMPROVEMENTS.md](PERFORMANCE_IMPROVEMENTS.md) for context
2. Review [optimized_roulette_rng.dart](optimized_roulette_rng.dart) for implementation examples
3. Apply fixes from this quick reference
4. Measure improvements with Flutter DevTools
5. Refer to [BEST_PRACTICES.md](BEST_PRACTICES.md) for ongoing development

## 💡 Tips

- **Measure first**: Use profiler before optimizing
- **Start with biggest wins**: Fix O(n²) before O(n log n)
- **Test after changes**: Verify improvements with benchmarks
- **Monitor in production**: Use Firebase Performance or similar
- **Document decisions**: Note why optimizations were made

## ⚠️ Common Mistakes

1. **Premature optimization**: Don't optimize before measuring
2. **Breaking correctness**: Don't sacrifice correctness for speed
3. **Over-caching**: Too much caching uses memory
4. **Ignoring const**: Missing const leads to unnecessary rebuilds
5. **Not testing**: Always verify optimizations work

## 📞 Need Help?

- Review benchmark results: [BENCHMARK_RESULTS.md](BENCHMARK_RESULTS.md)
- Check best practices: [BEST_PRACTICES.md](BEST_PRACTICES.md)
- See working code: [optimized_main_screen.dart](optimized_main_screen.dart)
