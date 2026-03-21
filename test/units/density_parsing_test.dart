import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('Density parsing —', () {
    group('Basic parsing (invariant format)', () {
      test('parses kilogram per cubic meter with symbol', () {
        expect(Density.parse('1000 kg/m³'), const Density(1000, DensityUnit.kilogramPerCubicMeter));
      });

      test('parses gram per cubic centimeter', () {
        expect(Density.parse('1 g/cm³'), const Density(1, DensityUnit.gramPerCubicCentimeter));
      });

      test('parses gram per milliliter', () {
        expect(Density.parse('0.92 g/mL'), const Density(0.92, DensityUnit.gramPerMilliliter));
      });
    });

    group('Spacing tolerance', () {
      test('parses with no space', () {
        expect(Density.parse('1000kg/m³'), const Density(1000, DensityUnit.kilogramPerCubicMeter));
      });

      test('parses with multiple spaces', () {
        expect(Density.parse('1   g/cm³'), const Density(1, DensityUnit.gramPerCubicCentimeter));
      });

      test('parses with leading/trailing whitespace', () {
        expect(Density.parse('  0.92 g/mL  '), const Density(0.92, DensityUnit.gramPerMilliliter));
      });
    });

    group('Case sensitivity', () {
      test('full names are case-insensitive', () {
        expect(
          Density.parse('1000 KILOGRAM PER CUBIC METER'),
          const Density(1000, DensityUnit.kilogramPerCubicMeter),
        );
        expect(
          Density.parse('1 Gram Per Cubic Centimeter'),
          const Density(1, DensityUnit.gramPerCubicCentimeter),
        );
        expect(
          Density.parse('0.92 gram per milliliter'),
          const Density(0.92, DensityUnit.gramPerMilliliter),
        );
      });

      test('abbreviated names are case-insensitive', () {
        expect(
          Density.parse('1000 KG PER M3'),
          const Density(1000, DensityUnit.kilogramPerCubicMeter),
        );
        expect(Density.parse('1 G PER CM3'), const Density(1, DensityUnit.gramPerCubicCentimeter));
        expect(Density.parse('0.92 G PER ML'), const Density(0.92, DensityUnit.gramPerMilliliter));
      });
    });

    group('Error handling', () {
      test('throws on invalid number', () {
        expect(() => Density.parse('abc kg/m³'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on missing unit', () {
        expect(() => Density.parse('1000'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on unknown unit', () {
        expect(() => Density.parse('1000 xyz'), throwsA(isA<QuantityParseException>()));
      });

      test('returns null with tryParse on invalid input', () {
        expect(Density.tryParse('invalid'), isNull);
      });

      test('returns null with tryParse on missing unit', () {
        expect(Density.tryParse('1000'), isNull);
      });
    });

    group('Round-trip', () {
      test('parse(toString()) preserves value and unit', () {
        const original = Density(1, DensityUnit.gramPerCubicCentimeter);
        final roundTrip = Density.parse(original.toString());
        expect(roundTrip, equals(original));
      });

      test('parse(toString()) works for all units', () {
        for (final unit in DensityUnit.values) {
          final original = Density(1, unit);
          final roundTrip = Density.parse(original.toString());
          expect(roundTrip, equals(original));
        }
      });
    });
  });
}
