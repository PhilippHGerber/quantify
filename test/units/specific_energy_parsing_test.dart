import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('SpecificEnergy parsing —', () {
    group('Basic parsing (invariant format)', () {
      test('parses joule per kilogram with symbol', () {
        expect(
          SpecificEnergy.parse('1000 J/kg'),
          const SpecificEnergy(1000, SpecificEnergyUnit.joulePerKilogram),
        );
      });

      test('parses kilojoule per kilogram', () {
        expect(
          SpecificEnergy.parse('1 kJ/kg'),
          const SpecificEnergy(1, SpecificEnergyUnit.kilojoulePerKilogram),
        );
      });

      test('parses watt-hour per kilogram', () {
        expect(
          SpecificEnergy.parse('250 Wh/kg'),
          const SpecificEnergy(250, SpecificEnergyUnit.wattHourPerKilogram),
        );
      });

      test('parses kilowatt-hour per kilogram', () {
        expect(
          SpecificEnergy.parse('0.25 kWh/kg'),
          const SpecificEnergy(0.25, SpecificEnergyUnit.kilowattHourPerKilogram),
        );
      });
    });

    group('Spacing tolerance', () {
      test('parses with no space', () {
        expect(
          SpecificEnergy.parse('1000J/kg'),
          const SpecificEnergy(1000, SpecificEnergyUnit.joulePerKilogram),
        );
      });

      test('parses with multiple spaces', () {
        expect(
          SpecificEnergy.parse('1   kJ/kg'),
          const SpecificEnergy(1, SpecificEnergyUnit.kilojoulePerKilogram),
        );
      });

      test('parses with leading/trailing whitespace', () {
        expect(
          SpecificEnergy.parse('  250 Wh/kg  '),
          const SpecificEnergy(250, SpecificEnergyUnit.wattHourPerKilogram),
        );
      });
    });

    group('Case sensitivity', () {
      test('SI symbols are case-sensitive (J vs j)', () {
        expect(() => SpecificEnergy.parse('1000 j/kg'), throwsA(isA<QuantityParseException>()));
      });

      test('SI symbols distinguish prefixes (kJ vs KJ)', () {
        expect(
          SpecificEnergy.parse('1 kJ/kg'),
          const SpecificEnergy(1, SpecificEnergyUnit.kilojoulePerKilogram),
        );
        expect(() => SpecificEnergy.parse('1 KJ/kg'), throwsA(isA<QuantityParseException>()));
      });

      test('full names are case-insensitive', () {
        expect(
          SpecificEnergy.parse('1000 JOULE PER KILOGRAM'),
          const SpecificEnergy(1000, SpecificEnergyUnit.joulePerKilogram),
        );
        expect(
          SpecificEnergy.parse('1 Kilojoule Per Kilogram'),
          const SpecificEnergy(1, SpecificEnergyUnit.kilojoulePerKilogram),
        );
        expect(
          SpecificEnergy.parse('250 watt hour per kilogram'),
          const SpecificEnergy(250, SpecificEnergyUnit.wattHourPerKilogram),
        );
      });

      test('abbreviated names are case-insensitive', () {
        expect(
          SpecificEnergy.parse('1000 J PER KG'),
          const SpecificEnergy(1000, SpecificEnergyUnit.joulePerKilogram),
        );
        expect(
          SpecificEnergy.parse('1 KJ PER KG'),
          const SpecificEnergy(1, SpecificEnergyUnit.kilojoulePerKilogram),
        );
        expect(
          SpecificEnergy.parse('250 WH PER KG'),
          const SpecificEnergy(250, SpecificEnergyUnit.wattHourPerKilogram),
        );
      });
    });

    group('Error handling', () {
      test('throws on invalid number', () {
        expect(() => SpecificEnergy.parse('abc J/kg'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on missing unit', () {
        expect(() => SpecificEnergy.parse('1000'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on unknown unit', () {
        expect(() => SpecificEnergy.parse('1000 xyz'), throwsA(isA<QuantityParseException>()));
      });

      test('returns null with tryParse on invalid input', () {
        expect(SpecificEnergy.tryParse('invalid'), isNull);
      });

      test('returns null with tryParse on missing unit', () {
        expect(SpecificEnergy.tryParse('1000'), isNull);
      });
    });

    group('Round-trip', () {
      test('parse(toString()) preserves value and unit', () {
        const original = SpecificEnergy(250, SpecificEnergyUnit.wattHourPerKilogram);
        final roundTrip = SpecificEnergy.parse(original.toString());
        expect(roundTrip, equals(original));
      });

      test('parse(toString()) works for all units', () {
        for (final unit in SpecificEnergyUnit.values) {
          final original = SpecificEnergy(1, unit);
          final roundTrip = SpecificEnergy.parse(original.toString());
          expect(roundTrip, equals(original));
        }
      });
    });
  });
}
