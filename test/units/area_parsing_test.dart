import 'package:quantify/quantify.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  const tolerance = 1e-9;

  group('Area Parsing', () {
    group('Basic parsing', () {
      test('parses standard valid inputs with invariant format', () {
        expect(Area.parse('100 m²').inSquareMeters, 100.0);
        expect(Area.parse('50 km²').inSquareKilometers, 50.0);
        expect(Area.parse('2.5 ha').inHectares, 2.5);
        expect(Area.parse('1000 cm²').inSquareCentimeters, 1000.0);
      });

      test('parses by symbol', () {
        final a = Area.parse('500 m²');
        expect(a.value, 500.0);
        expect(a.unit, AreaUnit.squareMeter);
      });

      test('parses by full name', () {
        final a = Area.parse('10 square meters');
        expect(a.value, 10.0);
        expect(a.unit, AreaUnit.squareMeter);
      });

      test('parses scientific notation', () {
        final a = Area.parse('1.5e3 m²');
        expect(a.value, 1500.0);
        expect(a.unit, AreaUnit.squareMeter);
      });

      test('parses negative values', () {
        final a = Area.parse('-25 m²');
        expect(a.value, -25.0);
        expect(a.unit, AreaUnit.squareMeter);
      });
    });

    group('Spacing', () {
      test('parses correctly regardless of spacing', () {
        expect(Area.parse('100m²').inSquareMeters, 100.0);
        expect(Area.parse('100   m²').inSquareMeters, 100.0);
        expect(Area.parse('  100 m²  ').inSquareMeters, 100.0);
      });
    });

    group('Case-insensitive names', () {
      test('full names are case-insensitive', () {
        expect(Area.parse('10 SQUARE METER').unit, AreaUnit.squareMeter);
        expect(Area.parse('10 Square Meters').unit, AreaUnit.squareMeter);
        expect(Area.parse('5 HECTARE').unit, AreaUnit.hectare);
        expect(Area.parse('5 Hectares').unit, AreaUnit.hectare);
      });

      test('abbreviations in nameAliases are case-insensitive', () {
        expect(Area.parse('10 HA').unit, AreaUnit.hectare);
        expect(Area.parse('10 Ha').unit, AreaUnit.hectare);
        expect(Area.parse('10 AC').unit, AreaUnit.acre);
        expect(Area.parse('10 Ac').unit, AreaUnit.acre);
      });
    });

    group('Unit coverage', () {
      test('parses metric square units', () {
        expect(Area.parse('1 km²').unit, AreaUnit.squareKilometer);
        expect(Area.parse('1 m²').unit, AreaUnit.squareMeter);
        expect(Area.parse('1 cm²').unit, AreaUnit.squareCentimeter);
        expect(Area.parse('1 mm²').unit, AreaUnit.squareMillimeter);
      });

      test('parses hectare', () {
        final ha = Area.parse('5 ha');
        expect(ha.value, 5.0);
        expect(ha.unit, AreaUnit.hectare);
      });

      test('parses imperial square units', () {
        expect(Area.parse('100 sq ft').unit, AreaUnit.squareFoot);
        expect(Area.parse('500 sq in').unit, AreaUnit.squareInch);
        expect(Area.parse('10 sq mi').unit, AreaUnit.squareMile);
      });

      test('parses acre', () {
        final ac = Area.parse('2.5 acres');
        expect(ac.value, 2.5);
        expect(ac.unit, AreaUnit.acre);
      });

      test('parsed value should be usable in conversions', () {
        final a = Area.parse('1 km²');
        expect(a.getValue(AreaUnit.squareMeter), closeTo(1000000.0, tolerance));
      });
    });

    group('Invariant format strictness', () {
      test('invariant format accepts visual grouping separators', () {
        expect(Area.parse('1 000 m²').inSquareMeters, 1000.0);
        expect(Area.parse('1\u00A0000 m²').inSquareMeters, 1000.0);
      });

      test('invariant format still rejects locale decimal separators', () {
        expect(Area.tryParse('10,5 m²'), isNull);
        expect(Area.tryParse('10;5 m²'), isNull);
      });
    });

    group('Error handling', () {
      test('tryParse returns null for invalid input', () {
        expect(Area.tryParse('invalid'), isNull);
        expect(Area.tryParse('10'), isNull);
        expect(Area.tryParse('10 xyz'), isNull);
      });

      test('parse throws QuantityParseException for invalid input', () {
        expect(
          () => Area.parse('invalid'),
          throwsA(isA<QuantityParseException>()),
        );
        expect(
          () => Area.parse('10'),
          throwsA(isA<QuantityParseException>()),
        );
      });
    });

    group('Round-trip', () {
      test('parse and format round-trip correctly', () {
        const original = Area(100, AreaUnit.squareMeter);
        final formatted = original.toString(format: QuantityFormat.invariant);
        final parsed = Area.parse(formatted);

        expect(parsed.value, closeTo(original.value, tolerance));
        expect(parsed.unit, original.unit);
      });
    });
  });
}
