import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('Acceleration parsing —', () {
    group('Basic parsing (invariant format)', () {
      test('parses meter per second squared with symbol', () {
        expect(
          Acceleration.parse('9.80665 m/s²'),
          const Acceleration(9.80665, AccelerationUnit.meterPerSecondSquared),
        );
      });

      test('parses standard gravity', () {
        expect(Acceleration.parse('1 g'), const Acceleration(1, AccelerationUnit.standardGravity));
      });

      test('parses kilometer per hour per second', () {
        expect(
          Acceleration.parse('27.8 km/h/s'),
          const Acceleration(27.8, AccelerationUnit.kilometerPerHourPerSecond),
        );
      });

      test('parses mile per hour per second', () {
        expect(
          Acceleration.parse('12 mph/s'),
          const Acceleration(12, AccelerationUnit.milePerHourPerSecond),
        );
      });

      test('parses knot per second', () {
        expect(
          Acceleration.parse('10 kn/s'),
          const Acceleration(10, AccelerationUnit.knotPerSecond),
        );
      });

      test('parses foot per second squared', () {
        expect(
          Acceleration.parse('32.174 ft/s²'),
          const Acceleration(32.174, AccelerationUnit.footPerSecondSquared),
        );
      });

      test('parses centimeter per second squared', () {
        expect(
          Acceleration.parse('980.665 cm/s²'),
          const Acceleration(980.665, AccelerationUnit.centimeterPerSecondSquared),
        );
      });
    });

    group('Special units', () {
      test('parses Galileo (Gal)', () {
        expect(
          Acceleration.parse('980.665 Gal'),
          const Acceleration(980.665, AccelerationUnit.centimeterPerSecondSquared),
        );
      });

      test('parses Galileo variant spellings', () {
        expect(
          Acceleration.parse('980.665 galileo'),
          const Acceleration(980.665, AccelerationUnit.centimeterPerSecondSquared),
        );
        expect(
          Acceleration.parse('980.665 GALILEO'),
          const Acceleration(980.665, AccelerationUnit.centimeterPerSecondSquared),
        );
      });
    });

    group('Spacing tolerance', () {
      test('parses with no space', () {
        expect(
          Acceleration.parse('9.80665m/s²'),
          const Acceleration(9.80665, AccelerationUnit.meterPerSecondSquared),
        );
      });

      test('parses with multiple spaces', () {
        expect(
          Acceleration.parse('1   g'),
          const Acceleration(1, AccelerationUnit.standardGravity),
        );
      });

      test('parses with leading/trailing whitespace', () {
        expect(
          Acceleration.parse('  27.8 km/h/s  '),
          const Acceleration(27.8, AccelerationUnit.kilometerPerHourPerSecond),
        );
      });
    });

    group('Case sensitivity', () {
      test('full names are case-insensitive', () {
        expect(
          Acceleration.parse('9.80665 METER PER SECOND SQUARED'),
          const Acceleration(9.80665, AccelerationUnit.meterPerSecondSquared),
        );
        expect(
          Acceleration.parse('1 Standard Gravity'),
          const Acceleration(1, AccelerationUnit.standardGravity),
        );
        expect(
          Acceleration.parse('12 mile per hour per second'),
          const Acceleration(12, AccelerationUnit.milePerHourPerSecond),
        );
      });

      test('non-SI abbreviations are case-insensitive', () {
        expect(Acceleration.parse('1 G'), const Acceleration(1, AccelerationUnit.standardGravity));
        expect(
          Acceleration.parse('1 GRAV'),
          const Acceleration(1, AccelerationUnit.standardGravity),
        );
        expect(
          Acceleration.parse('27.8 KM/H/S'),
          const Acceleration(27.8, AccelerationUnit.kilometerPerHourPerSecond),
        );
        expect(
          Acceleration.parse('12 MPH/S'),
          const Acceleration(12, AccelerationUnit.milePerHourPerSecond),
        );
        expect(
          Acceleration.parse('10 KN/S'),
          const Acceleration(10, AccelerationUnit.knotPerSecond),
        );
        expect(
          Acceleration.parse('980.665 GAL'),
          const Acceleration(980.665, AccelerationUnit.centimeterPerSecondSquared),
        );
      });
    });

    group('Error handling', () {
      test('throws on invalid number', () {
        expect(() => Acceleration.parse('abc m/s²'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on missing unit', () {
        expect(() => Acceleration.parse('9.80665'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on unknown unit', () {
        expect(() => Acceleration.parse('1 xyz'), throwsA(isA<QuantityParseException>()));
      });

      test('returns null with tryParse on invalid input', () {
        expect(Acceleration.tryParse('invalid'), isNull);
      });

      test('returns null with tryParse on missing unit', () {
        expect(Acceleration.tryParse('9.80665'), isNull);
      });
    });

    group('Round-trip', () {
      test('parse(toString()) preserves value and unit', () {
        const original = Acceleration(1, AccelerationUnit.standardGravity);
        final roundTrip = Acceleration.parse(original.toString());
        expect(roundTrip, equals(original));
      });

      test('parse(toString()) works for all units', () {
        for (final unit in AccelerationUnit.values) {
          final original = Acceleration(1, unit);
          final roundTrip = Acceleration.parse(original.toString());
          expect(roundTrip, equals(original));
        }
      });
    });
  });
}
