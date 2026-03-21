import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('LuminousIntensity parsing —', () {
    group('Basic parsing (invariant format)', () {
      test('parses candela with symbol', () {
        expect(
          LuminousIntensity.parse('800 cd'),
          const LuminousIntensity(800, LuminousIntensityUnit.candela),
        );
      });

      test('parses millicandela', () {
        expect(
          LuminousIntensity.parse('150 mcd'),
          const LuminousIntensity(150, LuminousIntensityUnit.millicandela),
        );
      });

      test('parses kilocandela', () {
        expect(
          LuminousIntensity.parse('2 kcd'),
          const LuminousIntensity(2, LuminousIntensityUnit.kilocandela),
        );
      });
    });

    group('Spacing tolerance', () {
      test('parses with no space', () {
        expect(
          LuminousIntensity.parse('800cd'),
          const LuminousIntensity(800, LuminousIntensityUnit.candela),
        );
      });

      test('parses with multiple spaces', () {
        expect(
          LuminousIntensity.parse('150   mcd'),
          const LuminousIntensity(150, LuminousIntensityUnit.millicandela),
        );
      });

      test('parses with leading/trailing whitespace', () {
        expect(
          LuminousIntensity.parse('  2 kcd  '),
          const LuminousIntensity(2, LuminousIntensityUnit.kilocandela),
        );
      });
    });

    group('Case sensitivity', () {
      test('SI symbols are case-sensitive (cd vs CD)', () {
        expect(() => LuminousIntensity.parse('800 CD'), throwsA(isA<QuantityParseException>()));
      });

      test('SI symbols distinguish prefixes (mcd vs Mcd)', () {
        expect(
          LuminousIntensity.parse('150 mcd'),
          const LuminousIntensity(150, LuminousIntensityUnit.millicandela),
        );
        expect(() => LuminousIntensity.parse('150 Mcd'), throwsA(isA<QuantityParseException>()));
      });

      test('full names are case-insensitive', () {
        expect(
          LuminousIntensity.parse('800 CANDELA'),
          const LuminousIntensity(800, LuminousIntensityUnit.candela),
        );
        expect(
          LuminousIntensity.parse('150 Millicandela'),
          const LuminousIntensity(150, LuminousIntensityUnit.millicandela),
        );
        expect(
          LuminousIntensity.parse('2 kilocandela'),
          const LuminousIntensity(2, LuminousIntensityUnit.kilocandela),
        );
      });
    });

    group('Error handling', () {
      test('throws on invalid number', () {
        expect(() => LuminousIntensity.parse('abc cd'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on missing unit', () {
        expect(() => LuminousIntensity.parse('800'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on unknown unit', () {
        expect(() => LuminousIntensity.parse('800 xyz'), throwsA(isA<QuantityParseException>()));
      });

      test('returns null with tryParse on invalid input', () {
        expect(LuminousIntensity.tryParse('invalid'), isNull);
      });

      test('returns null with tryParse on missing unit', () {
        expect(LuminousIntensity.tryParse('800'), isNull);
      });
    });

    group('Round-trip', () {
      test('parse(toString()) preserves value and unit', () {
        const original = LuminousIntensity(150, LuminousIntensityUnit.millicandela);
        final roundTrip = LuminousIntensity.parse(original.toString());
        expect(roundTrip, equals(original));
      });

      test('parse(toString()) works for all units', () {
        for (final unit in LuminousIntensityUnit.values) {
          final original = LuminousIntensity(1, unit);
          final roundTrip = LuminousIntensity.parse(original.toString());
          expect(roundTrip, equals(original));
        }
      });
    });
  });
}
