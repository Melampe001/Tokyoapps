import 'package:flutter_test/flutter_test.dart';
import 'package:tokyo_roulette_app/models/spin_result.dart';

void main() {
  group('SpinResult Model Tests', () {
    test('Create SpinResult with valid data', () {
      final spin = SpinResult(
        number: 17,
        timestamp: DateTime.now(),
        method: 'manual',
        isEuropean: true,
      );

      expect(spin.number, equals(17));
      expect(spin.method, equals('manual'));
      expect(spin.isEuropean, isTrue);
    });

    test('Get color name for red numbers', () {
      const redNumbers = [1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36];
      
      for (final number in redNumbers) {
        final spin = SpinResult(
          number: number,
          timestamp: DateTime.now(),
          method: 'manual',
          isEuropean: true,
        );
        expect(spin.getColorName(), equals('Red'), reason: 'Number $number should be Red');
      }
    });

    test('Get color name for black numbers', () {
      const blackNumbers = [2, 4, 6, 8, 10, 11, 13, 15, 17, 20, 22, 24, 26, 28, 29, 31, 33, 35];
      
      for (final number in blackNumbers) {
        final spin = SpinResult(
          number: number,
          timestamp: DateTime.now(),
          method: 'manual',
          isEuropean: true,
        );
        expect(spin.getColorName(), equals('Black'), reason: 'Number $number should be Black');
      }
    });

    test('Get color name for green numbers (0 and 00)', () {
      final spin0 = SpinResult(
        number: 0,
        timestamp: DateTime.now(),
        method: 'manual',
        isEuropean: true,
      );
      expect(spin0.getColorName(), equals('Green'));

      final spin00 = SpinResult(
        number: 37, // 00 represented as 37
        timestamp: DateTime.now(),
        method: 'manual',
        isEuropean: false,
      );
      expect(spin00.getColorName(), equals('Green'));
    });

    test('Serialize to JSON correctly without id', () {
      final timestamp = DateTime.parse('2025-11-02T12:00:00Z');
      final spin = SpinResult(
        number: 17,
        timestamp: timestamp,
        method: 'camera',
        isEuropean: true,
      );

      final json = spin.toJson();

      expect(json['number'], equals(17));
      expect(json['timestamp'], equals('2025-11-02T12:00:00.000Z'));
      expect(json['method'], equals('camera'));
      expect(json['isEuropean'], isTrue);
      expect(json.containsKey('id'), isFalse);
    });

    test('Serialize to JSON correctly with id', () {
      final timestamp = DateTime.parse('2025-11-02T12:00:00Z');
      final spin = SpinResult(
        id: 123,
        number: 17,
        timestamp: timestamp,
        method: 'camera',
        isEuropean: true,
      );

      final json = spin.toJson();

      expect(json['id'], equals(123));
      expect(json['number'], equals(17));
      expect(json['timestamp'], equals('2025-11-02T12:00:00.000Z'));
      expect(json['method'], equals('camera'));
      expect(json['isEuropean'], isTrue);
    });

    test('Deserialize from JSON correctly without id', () {
      final json = {
        'number': 25,
        'timestamp': '2025-11-02T15:30:00.000Z',
        'method': 'manual',
        'isEuropean': false,
      };

      final spin = SpinResult.fromJson(json);

      expect(spin.id, isNull);
      expect(spin.number, equals(25));
      expect(spin.timestamp, equals(DateTime.parse('2025-11-02T15:30:00.000Z')));
      expect(spin.method, equals('manual'));
      expect(spin.isEuropean, isFalse);
    });

    test('Deserialize from JSON correctly with id', () {
      final json = {
        'id': 456,
        'number': 25,
        'timestamp': '2025-11-02T15:30:00.000Z',
        'method': 'manual',
        'isEuropean': false,
      };

      final spin = SpinResult.fromJson(json);

      expect(spin.id, equals(456));
      expect(spin.number, equals(25));
      expect(spin.timestamp, equals(DateTime.parse('2025-11-02T15:30:00.000Z')));
      expect(spin.method, equals('manual'));
      expect(spin.isEuropean, isFalse);
    });

    test('Round-trip serialization', () {
      final original = SpinResult(
        number: 12,
        timestamp: DateTime.now(),
        method: 'camera',
        isEuropean: true,
      );

      final json = original.toJson();
      final deserialized = SpinResult.fromJson(json);

      expect(deserialized.number, equals(original.number));
      expect(deserialized.method, equals(original.method));
      expect(deserialized.isEuropean, equals(original.isEuropean));
    });

    test('Verify all European numbers (0-36)', () {
      for (int i = 0; i <= 36; i++) {
        final spin = SpinResult(
          number: i,
          timestamp: DateTime.now(),
          method: 'manual',
          isEuropean: true,
        );
        
        // Should not throw and should have a valid color
        expect(spin.getColorName(), isIn(['Red', 'Black', 'Green']));
      }
    });

    test('Verify American roulette 00 (as 37)', () {
      final spin = SpinResult(
        number: 37,
        timestamp: DateTime.now(),
        method: 'manual',
        isEuropean: false,
      );
      
      expect(spin.getColorName(), equals('Green'));
    });
  });
}
