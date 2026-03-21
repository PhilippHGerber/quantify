import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('AngularVelocity parsing —', () {
    group('Basic parsing (invariant format)', () {
      test('parses radian per second with symbol', () {
        expect(
          AngularVelocity.parse('6.28 rad/s'),
          const AngularVelocity(6.28, AngularVelocityUnit.radianPerSecond),
        );
      });

      test('parses degree per second', () {
        expect(
          AngularVelocity.parse('360 °/s'),
          const AngularVelocity(360, AngularVelocityUnit.degreePerSecond),
        );
      });

      test('parses revolution per minute', () {
        expect(
          AngularVelocity.parse('3000 rpm'),
          const AngularVelocity(3000, AngularVelocityUnit.revolutionPerMinute),
        );
      });

      test('parses revolution per second', () {
        expect(
          AngularVelocity.parse('50 rps'),
          const AngularVelocity(50, AngularVelocityUnit.revolutionPerSecond),
        );
      });
    });

    group('Spacing tolerance', () {
      test('parses with no space', () {
        expect(
          AngularVelocity.parse('6.28rad/s'),
          const AngularVelocity(6.28, AngularVelocityUnit.radianPerSecond),
        );
      });

      test('parses with multiple spaces', () {
        expect(
          AngularVelocity.parse('360   °/s'),
          const AngularVelocity(360, AngularVelocityUnit.degreePerSecond),
        );
      });

      test('parses with leading/trailing whitespace', () {
        expect(
          AngularVelocity.parse('  3000 rpm  '),
          const AngularVelocity(3000, AngularVelocityUnit.revolutionPerMinute),
        );
      });
    });

    group('Case sensitivity', () {
      test('full names are case-insensitive', () {
        expect(
          AngularVelocity.parse('6.28 RADIAN PER SECOND'),
          const AngularVelocity(6.28, AngularVelocityUnit.radianPerSecond),
        );
        expect(
          AngularVelocity.parse('360 Degree Per Second'),
          const AngularVelocity(360, AngularVelocityUnit.degreePerSecond),
        );
        expect(
          AngularVelocity.parse('3000 revolution per minute'),
          const AngularVelocity(3000, AngularVelocityUnit.revolutionPerMinute),
        );
        expect(
          AngularVelocity.parse('50 REVOLUTION PER SECOND'),
          const AngularVelocity(50, AngularVelocityUnit.revolutionPerSecond),
        );
      });

      test('non-SI abbreviations are case-insensitive', () {
        expect(
          AngularVelocity.parse('3000 RPM'),
          const AngularVelocity(3000, AngularVelocityUnit.revolutionPerMinute),
        );
        expect(
          AngularVelocity.parse('50 RPS'),
          const AngularVelocity(50, AngularVelocityUnit.revolutionPerSecond),
        );
      });
    });

    group('Error handling', () {
      test('throws on invalid number', () {
        expect(() => AngularVelocity.parse('abc rad/s'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on missing unit', () {
        expect(() => AngularVelocity.parse('6.28'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on unknown unit', () {
        expect(() => AngularVelocity.parse('3000 xyz'), throwsA(isA<QuantityParseException>()));
      });

      test('returns null with tryParse on invalid input', () {
        expect(AngularVelocity.tryParse('invalid'), isNull);
      });

      test('returns null with tryParse on missing unit', () {
        expect(AngularVelocity.tryParse('3000'), isNull);
      });
    });

    group('Round-trip', () {
      test('parse(toString()) preserves value and unit', () {
        const original = AngularVelocity(3000, AngularVelocityUnit.revolutionPerMinute);
        final roundTrip = AngularVelocity.parse(original.toString());
        expect(roundTrip, equals(original));
      });

      test('parse(toString()) works for all units', () {
        for (final unit in AngularVelocityUnit.values) {
          final original = AngularVelocity(1, unit);
          final roundTrip = AngularVelocity.parse(original.toString());
          expect(roundTrip, equals(original));
        }
      });
    });
  });
}
