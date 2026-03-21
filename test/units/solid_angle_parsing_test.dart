import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('SolidAngle parsing —', () {
    group('Basic parsing (invariant format)', () {
      test('parses steradian with symbol', () {
        expect(SolidAngle.parse('1 sr'), const SolidAngle(1, SolidAngleUnit.steradian));
      });

      test('parses square degree', () {
        expect(
          SolidAngle.parse('3282.806 deg²'),
          const SolidAngle(3282.806, SolidAngleUnit.squareDegree),
        );
      });

      test('parses spat', () {
        expect(SolidAngle.parse('1 sp'), const SolidAngle(1, SolidAngleUnit.spat));
      });
    });

    group('Spacing tolerance', () {
      test('parses with no space', () {
        expect(SolidAngle.parse('1sr'), const SolidAngle(1, SolidAngleUnit.steradian));
      });

      test('parses with multiple spaces', () {
        expect(
          SolidAngle.parse('3282.806   deg²'),
          const SolidAngle(3282.806, SolidAngleUnit.squareDegree),
        );
      });

      test('parses with leading/trailing whitespace', () {
        expect(SolidAngle.parse('  1 sp  '), const SolidAngle(1, SolidAngleUnit.spat));
      });
    });

    group('Case sensitivity', () {
      test('SI symbols are case-sensitive (sr vs SR)', () {
        expect(() => SolidAngle.parse('1 SR'), throwsA(isA<QuantityParseException>()));
      });

      test('full names are case-insensitive', () {
        expect(SolidAngle.parse('1 STERADIAN'), const SolidAngle(1, SolidAngleUnit.steradian));
        expect(
          SolidAngle.parse('3282.806 Square Degree'),
          const SolidAngle(3282.806, SolidAngleUnit.squareDegree),
        );
        expect(SolidAngle.parse('1 spat'), const SolidAngle(1, SolidAngleUnit.spat));
      });

      test('non-SI abbreviations are case-insensitive', () {
        expect(
          SolidAngle.parse('3282.806 DEG2'),
          const SolidAngle(3282.806, SolidAngleUnit.squareDegree),
        );
        expect(SolidAngle.parse('1 SP'), const SolidAngle(1, SolidAngleUnit.spat));
        expect(SolidAngle.parse('1 SPAT'), const SolidAngle(1, SolidAngleUnit.spat));
      });
    });

    group('Error handling', () {
      test('throws on invalid number', () {
        expect(() => SolidAngle.parse('abc sr'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on missing unit', () {
        expect(() => SolidAngle.parse('1'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on unknown unit', () {
        expect(() => SolidAngle.parse('1 xyz'), throwsA(isA<QuantityParseException>()));
      });

      test('returns null with tryParse on invalid input', () {
        expect(SolidAngle.tryParse('invalid'), isNull);
      });

      test('returns null with tryParse on missing unit', () {
        expect(SolidAngle.tryParse('1'), isNull);
      });
    });

    group('Round-trip', () {
      test('parse(toString()) preserves value and unit', () {
        const original = SolidAngle(1, SolidAngleUnit.steradian);
        final roundTrip = SolidAngle.parse(original.toString());
        expect(roundTrip, equals(original));
      });

      test('parse(toString()) works for all units', () {
        for (final unit in SolidAngleUnit.values) {
          final original = SolidAngle(1, unit);
          final roundTrip = SolidAngle.parse(original.toString());
          expect(roundTrip, equals(original));
        }
      });
    });
  });
}
