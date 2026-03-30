import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('FuelConsumption parsing —', () {
    group('Basic parsing', () {
      test('parses liters per 100 kilometers symbol', () {
        expect(
          FuelConsumption.parse('5.6 L/100km'),
          const FuelConsumption(5.6, FuelConsumptionUnit.litersPer100Km),
        );
      });

      test('parses kilometers per liter symbol', () {
        expect(
          FuelConsumption.parse('20 km/L'),
          const FuelConsumption(20, FuelConsumptionUnit.kilometerPerLiter),
        );
      });

      test('parses mpg symbol as US by default', () {
        expect(
          FuelConsumption.parse('42 mpg'),
          const FuelConsumption(42, FuelConsumptionUnit.mpgUs),
        );
      });

      test('parses mpg UK symbol', () {
        expect(
          FuelConsumption.parse('42 mpg(UK)'),
          const FuelConsumption(42, FuelConsumptionUnit.mpgUk),
        );
      });
    });

    group('Spacing tolerance', () {
      test('parses with no space', () {
        expect(
          FuelConsumption.parse('5.6L/100km'),
          const FuelConsumption(5.6, FuelConsumptionUnit.litersPer100Km),
        );
      });
    });

    group('Aliases and names', () {
      test('accepts lowercase normalized aliases', () {
        expect(
          FuelConsumption.parse('20 km/l'),
          const FuelConsumption(20, FuelConsumptionUnit.kilometerPerLiter),
        );
        expect(
          FuelConsumption.parse('42 mpg(us)'),
          const FuelConsumption(42, FuelConsumptionUnit.mpgUs),
        );
      });

      test('full names are case-insensitive', () {
        expect(
          FuelConsumption.parse('5.6 LITERS PER 100 KILOMETERS'),
          const FuelConsumption(5.6, FuelConsumptionUnit.litersPer100Km),
        );
        expect(
          FuelConsumption.parse('42 miles per imperial gallon'),
          const FuelConsumption(42, FuelConsumptionUnit.mpgUk),
        );
      });
    });

    group('Error handling', () {
      test('throws on invalid input', () {
        expect(() => FuelConsumption.parse('invalid'), throwsA(isA<QuantityParseException>()));
      });

      test('tryParse returns null on invalid input', () {
        expect(FuelConsumption.tryParse('invalid'), isNull);
      });
    });

    group('Round-trip', () {
      test('parse(toString()) preserves value and unit', () {
        const original = FuelConsumption(42, FuelConsumptionUnit.mpgUk);
        expect(FuelConsumption.parse(original.toString()), equals(original));
      });
    });
  });
}
