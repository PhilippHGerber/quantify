import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('MolarAmount parsing —', () {
    group('Basic parsing (invariant format)', () {
      test('parses mole with symbol', () {
        expect(MolarAmount.parse('0.5 mol'), const MolarAmount(0.5, MolarUnit.mole));
      });

      test('parses millimole', () {
        expect(MolarAmount.parse('25 mmol'), const MolarAmount(25, MolarUnit.millimole));
      });

      test('parses micromole', () {
        expect(MolarAmount.parse('100 µmol'), const MolarAmount(100, MolarUnit.micromole));
      });

      test('parses nanomole', () {
        expect(MolarAmount.parse('50 nmol'), const MolarAmount(50, MolarUnit.nanomole));
      });

      test('parses picomole', () {
        expect(MolarAmount.parse('10 pmol'), const MolarAmount(10, MolarUnit.picomole));
      });

      test('parses kilomole', () {
        expect(MolarAmount.parse('2 kmol'), const MolarAmount(2, MolarUnit.kilomole));
      });

      test('parses pound-mole by symbol', () {
        expect(MolarAmount.parse('1 lb-mol'), const MolarAmount(1, MolarUnit.poundMole));
      });

      test('parses pound-mole by full name', () {
        expect(MolarAmount.parse('1 pound-mole'), const MolarAmount(1, MolarUnit.poundMole));
      });
    });

    group('Spacing tolerance', () {
      test('parses with no space', () {
        expect(MolarAmount.parse('0.5mol'), const MolarAmount(0.5, MolarUnit.mole));
      });

      test('parses with multiple spaces', () {
        expect(MolarAmount.parse('25   mmol'), const MolarAmount(25, MolarUnit.millimole));
      });

      test('parses with leading/trailing whitespace', () {
        expect(MolarAmount.parse('  100 µmol  '), const MolarAmount(100, MolarUnit.micromole));
      });
    });

    group('Case sensitivity', () {
      test('SI symbols are case-sensitive (mol vs MOL)', () {
        expect(() => MolarAmount.parse('0.5 MOL'), throwsA(isA<QuantityParseException>()));
      });

      test('SI symbols distinguish prefixes (mmol vs Mmol)', () {
        expect(MolarAmount.parse('25 mmol'), const MolarAmount(25, MolarUnit.millimole));
        expect(() => MolarAmount.parse('25 Mmol'), throwsA(isA<QuantityParseException>()));
      });

      test('full names are case-insensitive', () {
        expect(MolarAmount.parse('0.5 MOLE'), const MolarAmount(0.5, MolarUnit.mole));
        expect(MolarAmount.parse('25 Millimole'), const MolarAmount(25, MolarUnit.millimole));
        expect(MolarAmount.parse('100 micromole'), const MolarAmount(100, MolarUnit.micromole));
      });
    });

    group('Error handling', () {
      test('throws on invalid number', () {
        expect(() => MolarAmount.parse('abc mol'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on missing unit', () {
        expect(() => MolarAmount.parse('0.5'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on unknown unit', () {
        expect(() => MolarAmount.parse('0.5 xyz'), throwsA(isA<QuantityParseException>()));
      });

      test('returns null with tryParse on invalid input', () {
        expect(MolarAmount.tryParse('invalid'), isNull);
      });

      test('returns null with tryParse on missing unit', () {
        expect(MolarAmount.tryParse('0.5'), isNull);
      });
    });

    group('Round-trip', () {
      test('parse(toString()) preserves value and unit', () {
        const original = MolarAmount(25, MolarUnit.millimole);
        final roundTrip = MolarAmount.parse(original.toString());
        expect(roundTrip, equals(original));
      });

      test('parse(toString()) works for all units', () {
        for (final unit in MolarUnit.values) {
          final original = MolarAmount(1, unit);
          final roundTrip = MolarAmount.parse(original.toString());
          expect(roundTrip, equals(original));
        }
      });

      test('pound-mole round-trip: parse(toString())', () {
        const original = MolarAmount(2.5, MolarUnit.poundMole);
        final roundTrip = MolarAmount.parse(original.toString());
        expect(roundTrip, equals(original));
      });
    });
  });
}
