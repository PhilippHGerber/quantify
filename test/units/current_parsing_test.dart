import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('Current parsing —', () {
    group('Basic parsing (invariant format)', () {
      test('parses ampere with symbol', () {
        expect(Current.parse('1.5 A'), const Current(1.5, CurrentUnit.ampere));
      });

      test('parses milliampere', () {
        expect(Current.parse('20 mA'), const Current(20, CurrentUnit.milliampere));
      });

      test('parses microampere', () {
        expect(Current.parse('500 µA'), const Current(500, CurrentUnit.microampere));
      });

      test('parses nanoampere', () {
        expect(Current.parse('100 nA'), const Current(100, CurrentUnit.nanoampere));
      });

      test('parses kiloampere', () {
        expect(Current.parse('10 kA'), const Current(10, CurrentUnit.kiloampere));
      });
    });

    group('CGS units', () {
      test('parses statampere', () {
        expect(Current.parse('1 statA'), const Current(1, CurrentUnit.statampere));
      });

      test('parses abampere', () {
        expect(Current.parse('1 abA'), const Current(1, CurrentUnit.abampere));
      });
    });

    group('Spacing tolerance', () {
      test('parses with no space', () {
        expect(Current.parse('1.5A'), const Current(1.5, CurrentUnit.ampere));
      });

      test('parses with multiple spaces', () {
        expect(Current.parse('20   mA'), const Current(20, CurrentUnit.milliampere));
      });

      test('parses with leading/trailing whitespace', () {
        expect(Current.parse('  500 µA  '), const Current(500, CurrentUnit.microampere));
      });
    });

    group('Case sensitivity', () {
      test('SI symbols are case-sensitive (A vs a)', () {
        expect(() => Current.parse('1.5 a'), throwsA(isA<QuantityParseException>()));
      });

      test('SI symbols distinguish prefixes (mA vs MA)', () {
        expect(Current.parse('20 mA'), const Current(20, CurrentUnit.milliampere));
        expect(() => Current.parse('20 MA'), throwsA(isA<QuantityParseException>()));
      });

      test('full names are case-insensitive', () {
        expect(Current.parse('1.5 AMPERE'), const Current(1.5, CurrentUnit.ampere));
        expect(Current.parse('1.5 Ampere'), const Current(1.5, CurrentUnit.ampere));
        expect(Current.parse('20 milliampere'), const Current(20, CurrentUnit.milliampere));
      });

      test('non-SI abbreviations are case-insensitive', () {
        expect(Current.parse('1 STATA'), const Current(1, CurrentUnit.statampere));
        expect(Current.parse('1 ABA'), const Current(1, CurrentUnit.abampere));
      });
    });

    group('Error handling', () {
      test('throws on invalid number', () {
        expect(() => Current.parse('abc A'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on missing unit', () {
        expect(() => Current.parse('1.5'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on unknown unit', () {
        expect(() => Current.parse('1.5 xyz'), throwsA(isA<QuantityParseException>()));
      });

      test('returns null with tryParse on invalid input', () {
        expect(Current.tryParse('invalid'), isNull);
      });

      test('returns null with tryParse on missing unit', () {
        expect(Current.tryParse('1.5'), isNull);
      });
    });

    group('Round-trip', () {
      test('parse(toString()) preserves value and unit', () {
        const original = Current(20, CurrentUnit.milliampere);
        final roundTrip = Current.parse(original.toString());
        expect(roundTrip, equals(original));
      });

      test('parse(toString()) works for all units', () {
        for (final unit in CurrentUnit.values) {
          final original = Current(1, unit);
          final roundTrip = Current.parse(original.toString());
          expect(roundTrip, equals(original));
        }
      });
    });
  });
}
