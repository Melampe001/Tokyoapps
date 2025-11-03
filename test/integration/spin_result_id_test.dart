import 'package:flutter_test/flutter_test.dart';
import 'package:tokyo_roulette_app/models/spin_result.dart';

void main() {
  group('SpinResult ID Integration Tests', () {
    test('SpinResult can be created without an id', () {
      final spin = SpinResult(
        number: 17,
        timestamp: DateTime.now(),
        method: 'manual',
        isEuropean: true,
      );

      expect(spin.id, isNull);
      expect(spin.number, equals(17));
    });

    test('SpinResult can be created with an id', () {
      final spin = SpinResult(
        id: 123,
        number: 17,
        timestamp: DateTime.now(),
        method: 'manual',
        isEuropean: true,
      );

      expect(spin.id, equals(123));
      expect(spin.number, equals(17));
    });

    test('SpinResult toJson includes id when present', () {
      final spin = SpinResult(
        id: 456,
        number: 25,
        timestamp: DateTime.parse('2025-11-03T12:00:00.000Z'),
        method: 'camera',
        isEuropean: false,
      );

      final json = spin.toJson();

      expect(json['id'], equals(456));
      expect(json['number'], equals(25));
      expect(json['method'], equals('camera'));
    });

    test('SpinResult toJson excludes id when null', () {
      final spin = SpinResult(
        number: 25,
        timestamp: DateTime.parse('2025-11-03T12:00:00.000Z'),
        method: 'camera',
        isEuropean: false,
      );

      final json = spin.toJson();

      expect(json.containsKey('id'), isFalse);
      expect(json['number'], equals(25));
      expect(json['method'], equals('camera'));
    });

    test('SpinResult fromJson handles id field', () {
      final jsonWithId = {
        'id': 789,
        'number': 30,
        'timestamp': '2025-11-03T12:00:00.000Z',
        'method': 'manual',
        'isEuropean': true,
      };

      final spin = SpinResult.fromJson(jsonWithId);

      expect(spin.id, equals(789));
      expect(spin.number, equals(30));
      expect(spin.method, equals('manual'));
      expect(spin.isEuropean, isTrue);
    });

    test('SpinResult fromJson handles missing id field', () {
      final jsonWithoutId = {
        'number': 30,
        'timestamp': '2025-11-03T12:00:00.000Z',
        'method': 'manual',
        'isEuropean': true,
      };

      final spin = SpinResult.fromJson(jsonWithoutId);

      expect(spin.id, isNull);
      expect(spin.number, equals(30));
      expect(spin.method, equals('manual'));
      expect(spin.isEuropean, isTrue);
    });

    test('Round-trip serialization with id preserves id', () {
      final original = SpinResult(
        id: 999,
        number: 15,
        timestamp: DateTime.parse('2025-11-03T12:00:00.000Z'),
        method: 'camera',
        isEuropean: true,
      );

      final json = original.toJson();
      final deserialized = SpinResult.fromJson(json);

      expect(deserialized.id, equals(original.id));
      expect(deserialized.number, equals(original.number));
      expect(deserialized.method, equals(original.method));
      expect(deserialized.isEuropean, equals(original.isEuropean));
    });

    test('Round-trip serialization without id works correctly', () {
      final original = SpinResult(
        number: 15,
        timestamp: DateTime.parse('2025-11-03T12:00:00.000Z'),
        method: 'camera',
        isEuropean: true,
      );

      final json = original.toJson();
      final deserialized = SpinResult.fromJson(json);

      expect(deserialized.id, isNull);
      expect(deserialized.number, equals(original.number));
      expect(deserialized.method, equals(original.method));
      expect(deserialized.isEuropean, equals(original.isEuropean));
    });
  });
}
