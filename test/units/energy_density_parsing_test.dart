import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('EnergyDensity parsing —', () {
    group('Basic parsing (invariant format)', () {
      test('parses joule per cubic meter with symbol', () {
        expect(
          EnergyDensity.parse('1000 J/m³'),
          const EnergyDensity(1000, EnergyDensityUnit.joulePerCubicMeter),
        );
      });

      test('parses joule per liter', () {
        expect(EnergyDensity.parse('1 J/L'), const EnergyDensity(1, EnergyDensityUnit.joulePerLiter));
      });

      test('parses watt-hour per liter', () {
        expect(
          EnergyDensity.parse('0.92 Wh/L'),
          const EnergyDensity(0.92, EnergyDensityUnit.wattHourPerLiter),
        );
      });
    });

    group('Spacing tolerance', () {
      test('parses with no space', () {
        expect(
          EnergyDensity.parse('1000J/m³'),
          const EnergyDensity(1000, EnergyDensityUnit.joulePerCubicMeter),
        );
      });

      test('parses with multiple spaces', () {
        expect(
          EnergyDensity.parse('1   J/L'),
          const EnergyDensity(1, EnergyDensityUnit.joulePerLiter),
        );
      });

      test('parses with leading/trailing whitespace', () {
        expect(
          EnergyDensity.parse('  0.92 Wh/L  '),
          const EnergyDensity(0.92, EnergyDensityUnit.wattHourPerLiter),
        );
      });
    });

    group('Case sensitivity', () {
      test('full names are case-insensitive', () {
        expect(
          EnergyDensity.parse('1000 JOULE PER CUBIC METER'),
          const EnergyDensity(1000, EnergyDensityUnit.joulePerCubicMeter),
        );
        expect(
          EnergyDensity.parse('1 Joule Per Liter'),
          const EnergyDensity(1, EnergyDensityUnit.joulePerLiter),
        );
        expect(
          EnergyDensity.parse('0.92 watt hour per liter'),
          const EnergyDensity(0.92, EnergyDensityUnit.wattHourPerLiter),
        );
      });

      test('abbreviated names are case-insensitive', () {
        expect(
          EnergyDensity.parse('1000 J PER M3'),
          const EnergyDensity(1000, EnergyDensityUnit.joulePerCubicMeter),
        );
        expect(
          EnergyDensity.parse('1 J PER L'),
          const EnergyDensity(1, EnergyDensityUnit.joulePerLiter),
        );
        expect(
          EnergyDensity.parse('0.92 WH PER L'),
          const EnergyDensity(0.92, EnergyDensityUnit.wattHourPerLiter),
        );
      });
    });

    group('Error handling', () {
      test('throws on invalid number', () {
        expect(() => EnergyDensity.parse('abc J/m³'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on missing unit', () {
        expect(() => EnergyDensity.parse('1000'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on unknown unit', () {
        expect(() => EnergyDensity.parse('1000 xyz'), throwsA(isA<QuantityParseException>()));
      });

      test('returns null with tryParse on invalid input', () {
        expect(EnergyDensity.tryParse('invalid'), isNull);
      });

      test('returns null with tryParse on missing unit', () {
        expect(EnergyDensity.tryParse('1000'), isNull);
      });
    });

    group('Round-trip', () {
      test('parse(toString()) preserves value and unit', () {
        const original = EnergyDensity(1, EnergyDensityUnit.joulePerLiter);
        final roundTrip = EnergyDensity.parse(original.toString());
        expect(roundTrip, equals(original));
      });

      test('parse(toString()) works for all units', () {
        for (final unit in EnergyDensityUnit.values) {
          final original = EnergyDensity(1, unit);
          final roundTrip = EnergyDensity.parse(original.toString());
          expect(roundTrip, equals(original));
        }
      });
    });
  });
}
