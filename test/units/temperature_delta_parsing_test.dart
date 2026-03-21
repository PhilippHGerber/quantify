import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('TemperatureDelta parsing —', () {
    group('Basic parsing (invariant format)', () {
      test('parses kelvin delta with symbol', () {
        expect(
          TemperatureDelta.parse('20 K'),
          const TemperatureDelta(20, TemperatureDeltaUnit.kelvinDelta),
        );
      });

      test('parses celsius delta', () {
        expect(
          TemperatureDelta.parse('20 °C'),
          const TemperatureDelta(20, TemperatureDeltaUnit.celsiusDelta),
        );
      });

      test('parses fahrenheit delta', () {
        expect(
          TemperatureDelta.parse('36 °F'),
          const TemperatureDelta(36, TemperatureDeltaUnit.fahrenheitDelta),
        );
      });

      test('parses rankine delta', () {
        expect(
          TemperatureDelta.parse('36 °R'),
          const TemperatureDelta(36, TemperatureDeltaUnit.rankineDelta),
        );
      });
    });

    group('Spacing tolerance', () {
      test('parses with no space', () {
        expect(
          TemperatureDelta.parse('20K'),
          const TemperatureDelta(20, TemperatureDeltaUnit.kelvinDelta),
        );
      });

      test('parses with multiple spaces', () {
        expect(
          TemperatureDelta.parse('20   °C'),
          const TemperatureDelta(20, TemperatureDeltaUnit.celsiusDelta),
        );
      });

      test('parses with leading/trailing whitespace', () {
        expect(
          TemperatureDelta.parse('  36 °F  '),
          const TemperatureDelta(36, TemperatureDeltaUnit.fahrenheitDelta),
        );
      });
    });

    group('Case sensitivity', () {
      test('SI symbols are case-sensitive (K vs k)', () {
        expect(() => TemperatureDelta.parse('20 k'), throwsA(isA<QuantityParseException>()));
      });

      test('full names are case-insensitive', () {
        expect(
          TemperatureDelta.parse('20 KELVIN'),
          const TemperatureDelta(20, TemperatureDeltaUnit.kelvinDelta),
        );
        expect(
          TemperatureDelta.parse('20 Celsius'),
          const TemperatureDelta(20, TemperatureDeltaUnit.celsiusDelta),
        );
        expect(
          TemperatureDelta.parse('36 fahrenheit'),
          const TemperatureDelta(36, TemperatureDeltaUnit.fahrenheitDelta),
        );
        expect(
          TemperatureDelta.parse('36 RANKINE'),
          const TemperatureDelta(36, TemperatureDeltaUnit.rankineDelta),
        );
      });

      test('full names with "delta" suffix are case-insensitive', () {
        expect(
          TemperatureDelta.parse('20 KELVIN DELTA'),
          const TemperatureDelta(20, TemperatureDeltaUnit.kelvinDelta),
        );
        expect(
          TemperatureDelta.parse('20 Celsius Delta'),
          const TemperatureDelta(20, TemperatureDeltaUnit.celsiusDelta),
        );
        expect(
          TemperatureDelta.parse('36 fahrenheit delta'),
          const TemperatureDelta(36, TemperatureDeltaUnit.fahrenheitDelta),
        );
      });
    });

    group('Error handling', () {
      test('throws on invalid number', () {
        expect(() => TemperatureDelta.parse('abc K'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on missing unit', () {
        expect(() => TemperatureDelta.parse('20'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on unknown unit', () {
        expect(() => TemperatureDelta.parse('20 xyz'), throwsA(isA<QuantityParseException>()));
      });

      test('returns null with tryParse on invalid input', () {
        expect(TemperatureDelta.tryParse('invalid'), isNull);
      });

      test('returns null with tryParse on missing unit', () {
        expect(TemperatureDelta.tryParse('20'), isNull);
      });
    });

    group('Round-trip', () {
      test('parse(toString()) preserves value and unit', () {
        const original = TemperatureDelta(20, TemperatureDeltaUnit.celsiusDelta);
        final roundTrip = TemperatureDelta.parse(original.toString());
        expect(roundTrip, equals(original));
      });

      test('parse(toString()) works for all units', () {
        for (final unit in TemperatureDeltaUnit.values) {
          final original = TemperatureDelta(1, unit);
          final roundTrip = TemperatureDelta.parse(original.toString());
          expect(roundTrip, equals(original));
        }
      });
    });
  });
}
