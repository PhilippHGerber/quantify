import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('LevelRatio parsing —', () {
    group('Basic parsing (invariant format)', () {
      test('parses decibel symbol', () {
        expect(LevelRatio.parse('3 dB'), const LevelRatio(3, LevelRatioUnit.decibel));
      });

      test('parses neper symbol', () {
        expect(LevelRatio.parse('1 Np'), const LevelRatio(1, LevelRatioUnit.neper));
      });
    });

    group('Spacing tolerance', () {
      test('parses with no space', () {
        expect(LevelRatio.parse('3dB'), const LevelRatio(3, LevelRatioUnit.decibel));
      });

      test('parses with multiple spaces', () {
        expect(LevelRatio.parse('1   Np'), const LevelRatio(1, LevelRatioUnit.neper));
      });

      test('parses with leading and trailing whitespace', () {
        expect(LevelRatio.parse('  3 dB  '), const LevelRatio(3, LevelRatioUnit.decibel));
      });
    });

    group('Case sensitivity', () {
      test('symbols are case-sensitive', () {
        expect(() => LevelRatio.parse('3 db'), throwsA(isA<QuantityParseException>()));
        expect(() => LevelRatio.parse('1 np'), throwsA(isA<QuantityParseException>()));
      });

      test('full names are case-insensitive', () {
        expect(LevelRatio.parse('3 DECIBELS'), const LevelRatio(3, LevelRatioUnit.decibel));
        expect(LevelRatio.parse('1 NePer'), const LevelRatio(1, LevelRatioUnit.neper));
      });
    });

    group('Error handling', () {
      test('throws on invalid number', () {
        expect(() => LevelRatio.parse('abc dB'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on missing unit', () {
        expect(() => LevelRatio.parse('3'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on unknown unit', () {
        expect(() => LevelRatio.parse('3 xyz'), throwsA(isA<QuantityParseException>()));
      });

      test('returns null with tryParse on invalid input', () {
        expect(LevelRatio.tryParse('invalid'), isNull);
      });
    });

    group('Round-trip', () {
      test('parse(toString()) preserves value and unit', () {
        const original = LevelRatio(3, LevelRatioUnit.decibel);
        expect(LevelRatio.parse(original.toString()), equals(original));
      });

      test('parse(toString()) works for all units', () {
        for (final unit in LevelRatioUnit.values) {
          final original = LevelRatio(1.25, unit);
          final roundTrip = LevelRatio.parse(original.toString());
          expect(roundTrip, equals(original));
        }
      });
    });
  });
}
