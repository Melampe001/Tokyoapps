# Performance Best Practices for Flutter/Dart Applications

This document outlines best practices for writing efficient Flutter/Dart code, based on the optimizations made to the Tokyoapps project.

## 1. Data Structure Selection

### Use Appropriate Collections

❌ **Bad:** Using List for frequent lookups
```dart
List<int> numbers = [1, 2, 3, 4, 5];
bool contains = numbers.contains(3);  // O(n)
```

✅ **Good:** Using Set or Map for lookups
```dart
Set<int> numbers = {1, 2, 3, 4, 5};
bool contains = numbers.contains(3);  // O(1)

// Or Map for key-value pairs
Map<int, int> numberFrequency = {1: 5, 2: 3, 3: 8};
int? freq = numberFrequency[3];  // O(1)
```

### Bounded Collections

❌ **Bad:** Unbounded growth
```dart
List<int> history = [];
void addItem(int item) {
  history.add(item);  // Grows forever
}
```

✅ **Good:** Use circular buffer or limit size
```dart
import 'dart:collection';

Queue<int> history = Queue<int>();
static const int MAX_SIZE = 1000;

void addItem(int item) {
  history.add(item);
  if (history.length > MAX_SIZE) {
    history.removeFirst();
  }
}
```

## 2. Incremental Updates vs Full Recalculation

### Maintain State Incrementally

❌ **Bad:** Recalculate everything on each update
```dart
void onUpdate() {
  // Recalculates all frequencies every time
  Map<int, int> freq = {};
  for (var item in history) {
    freq[item] = (freq[item] ?? 0) + 1;
  }
}
```

✅ **Good:** Update incrementally
```dart
Map<int, int> _frequencyCache = {};

void onUpdate(int newItem) {
  // O(1) update
  _frequencyCache[newItem] = (_frequencyCache[newItem] ?? 0) + 1;
}
```

## 3. Avoid Repeated Expensive Operations

### Cache Expensive Computations

❌ **Bad:** Recalculating in multiple places
```dart
Widget buildChart() {
  var freq = calculateFrequencies();  // Expensive
  // ... use freq
}

Widget buildStats() {
  var freq = calculateFrequencies();  // Same expensive calculation
  // ... use freq
}
```

✅ **Good:** Calculate once, reuse
```dart
class MyState {
  late final Map<int, int> _frequencyCache;
  
  void update() {
    _frequencyCache = calculateFrequencies();  // Once
  }
  
  Widget buildChart() => _useFrequencies(_frequencyCache);
  Widget buildStats() => _useFrequencies(_frequencyCache);
}
```

## 4. Lazy Initialization

### Initialize Expensive Resources Once

❌ **Bad:** Creating new instances repeatedly
```dart
int generateRandom() {
  var rng = Random.secure();  // Expensive initialization
  return rng.nextInt(100);
}
```

✅ **Good:** Reuse instances
```dart
class RandomGenerator {
  final Random _rng = Random.secure();  // Initialize once
  
  int generate() => _rng.nextInt(100);
}
```

### Use late final for Lazy Initialization

```dart
class MyClass {
  // Initialized only when first accessed
  late final Map<int, int> expensiveMap = _buildExpensiveMap();
  
  Map<int, int> _buildExpensiveMap() {
    // Expensive computation
    return {};
  }
}
```

## 5. Minimize Widget Rebuilds

### Use const Constructors

❌ **Bad:** Creating new widgets on every build
```dart
Widget build(BuildContext context) {
  return Column(
    children: [
      Text('Static Text'),  // Recreated every build
      MyWidget(),           // Recreated every build
    ],
  );
}
```

✅ **Good:** Use const where possible
```dart
Widget build(BuildContext context) {
  return Column(
    children: [
      const Text('Static Text'),  // Reused
      const MyWidget(),           // Reused
    ],
  );
}
```

### Separate Stateful and Stateless Widgets

❌ **Bad:** Large stateful widget rebuilds everything
```dart
class MyScreen extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DynamicWidget(data),      // Needs updates
        ExpensiveStaticWidget(),  // Doesn't need updates but rebuilds
      ],
    );
  }
}
```

✅ **Good:** Separate concerns
```dart
class MyScreen extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DynamicWidget(data),           // Updates when needed
        const ExpensiveStaticWidget(), // Never rebuilds
      ],
    );
  }
}
```

## 6. Async Operations and Batching

### Batch Database/Network Operations

❌ **Bad:** Individual operations
```dart
void saveItems(List<int> items) {
  for (var item in items) {
    database.save(item);  // Separate network call each
  }
}
```

✅ **Good:** Batch operations
```dart
void saveItems(List<int> items) {
  database.batchSave(items);  // Single operation
}

// Or with Firestore
void saveItems(List<int> items) {
  final batch = FirebaseFirestore.instance.batch();
  for (var item in items) {
    batch.set(collection.doc(), {'value': item});
  }
  await batch.commit();  // Single network call
}
```

### Debounce Rapid Operations

```dart
Timer? _debounceTimer;

void onRapidEvent() {
  _debounceTimer?.cancel();
  _debounceTimer = Timer(Duration(milliseconds: 300), () {
    // Execute after 300ms of inactivity
    performExpensiveOperation();
  });
}
```

## 7. Memory Management

### Use Weak References for Caches

```dart
import 'dart:collection';

class CacheManager<K, V> {
  final Map<K, V> _cache = {};
  final Queue<K> _accessOrder = Queue<K>();
  static const int MAX_SIZE = 100;
  
  V? get(K key) {
    if (_cache.containsKey(key)) {
      // Move to end (most recently used)
      _accessOrder.remove(key);
      _accessOrder.add(key);
      return _cache[key];
    }
    return null;
  }
  
  void put(K key, V value) {
    if (_cache.length >= MAX_SIZE) {
      // Remove least recently used
      final oldest = _accessOrder.removeFirst();
      _cache.remove(oldest);
    }
    _cache[key] = value;
    _accessOrder.add(key);
  }
}
```

### Dispose Resources Properly

```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Timer? _timer;
  StreamSubscription? _subscription;
  
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (_) {});
    _subscription = stream.listen((_) {});
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    _subscription?.cancel();
    super.dispose();
  }
}
```

## 8. Algorithm Complexity

### Choose Efficient Algorithms

❌ **Bad:** O(n²) nested loops
```dart
List<int> findDuplicates(List<int> numbers) {
  List<int> duplicates = [];
  for (int i = 0; i < numbers.length; i++) {
    for (int j = i + 1; j < numbers.length; j++) {
      if (numbers[i] == numbers[j] && !duplicates.contains(numbers[i])) {
        duplicates.add(numbers[i]);
      }
    }
  }
  return duplicates;
}
```

✅ **Good:** O(n) with Set
```dart
List<int> findDuplicates(List<int> numbers) {
  Set<int> seen = {};
  Set<int> duplicates = {};
  
  for (var num in numbers) {
    if (seen.contains(num)) {
      duplicates.add(num);
    } else {
      seen.add(num);
    }
  }
  
  return duplicates.toList();
}
```

## 9. Strings and Text Processing

### Use StringBuffer for Concatenation

❌ **Bad:** String concatenation in loops
```dart
String buildString(List<String> items) {
  String result = '';
  for (var item in items) {
    result += item;  // Creates new string each time
  }
  return result;
}
```

✅ **Good:** Use StringBuffer
```dart
String buildString(List<String> items) {
  final buffer = StringBuffer();
  for (var item in items) {
    buffer.write(item);  // Efficient append
  }
  return buffer.toString();
}
```

## 10. Profiling and Monitoring

### Use Flutter DevTools

```dart
import 'dart:developer' as developer;

void performOperation() {
  developer.Timeline.startSync('myOperation');
  
  // Your code here
  
  developer.Timeline.finishSync();
}
```

### Add Performance Markers

```dart
void complexOperation() {
  final stopwatch = Stopwatch()..start();
  
  // Do work
  
  stopwatch.stop();
  if (stopwatch.elapsedMilliseconds > 100) {
    print('WARNING: Operation took ${stopwatch.elapsedMilliseconds}ms');
  }
}
```

## 11. List Operations

### Avoid Growing Lists in Loops

❌ **Bad:** Growing list dynamically
```dart
List<int> result = [];
for (int i = 0; i < 1000; i++) {
  result.add(i);  // May need to reallocate
}
```

✅ **Good:** Pre-allocate when size is known
```dart
List<int> result = List<int>.filled(1000, 0);
for (int i = 0; i < 1000; i++) {
  result[i] = i;  // Direct assignment
}

// Or use List.generate
List<int> result = List<int>.generate(1000, (i) => i);
```

## 12. JSON and Serialization

### Use Code Generation

Instead of manual JSON parsing, use code generation:

```dart
// Add dependencies:
// json_annotation: ^4.8.0
// json_serializable: ^6.6.0

import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class User {
  final String name;
  final int age;
  
  User(this.name, this.age);
  
  // Generated methods are much faster
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

## Performance Testing Template

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Performance Tests', () {
    test('Operation completes within time limit', () {
      final stopwatch = Stopwatch()..start();
      
      // Your operation
      myExpensiveOperation();
      
      stopwatch.stop();
      
      expect(
        stopwatch.elapsedMilliseconds,
        lessThan(100),
        reason: 'Operation should complete in under 100ms',
      );
    });
    
    test('Memory usage is bounded', () {
      final initialMemory = ProcessInfo.currentRss;
      
      // Operation that might leak memory
      for (int i = 0; i < 1000; i++) {
        myOperation();
      }
      
      final finalMemory = ProcessInfo.currentRss;
      final growth = finalMemory - initialMemory;
      
      expect(
        growth,
        lessThan(10 * 1024 * 1024), // Less than 10MB growth
        reason: 'Memory growth should be bounded',
      );
    });
  });
}
```

## Summary Checklist

- [ ] Use appropriate data structures (Map/Set for lookups)
- [ ] Implement incremental updates instead of full recalculations
- [ ] Cache expensive computations
- [ ] Reuse instances (RNG, controllers, etc.)
- [ ] Use const constructors where possible
- [ ] Separate stateful and stateless widgets
- [ ] Batch database/network operations
- [ ] Implement proper disposal of resources
- [ ] Choose efficient algorithms (aim for O(1) or O(n log n))
- [ ] Use StringBuffer for string concatenation
- [ ] Pre-allocate lists when size is known
- [ ] Profile with Flutter DevTools
- [ ] Write performance tests
- [ ] Monitor memory usage
- [ ] Bound collection sizes

## Additional Resources

- [Flutter Performance Best Practices](https://flutter.dev/docs/perf/best-practices)
- [Dart Language Optimization](https://dart.dev/guides/language/effective-dart/usage)
- [Flutter DevTools](https://flutter.dev/docs/development/tools/devtools/overview)
