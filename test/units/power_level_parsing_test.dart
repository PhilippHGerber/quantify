import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('PowerLevel parsing —', () {
    group('Basic parsing', () {
      test('parses dBm symbol', () {
        expect(PowerLevel.parse('20 dBm'), const PowerLevel(20, PowerLevelUnit.dBm));
      });

      test('parses dBW symbol', () {
        expect(PowerLevel.parse('-10 dBW'), const PowerLevel(-10, PowerLevelUnit.dBW));
      });
    });

    group('Spacing tolerance', () {
      test('parses with no space', () {
        expect(PowerLevel.parse('20dBm'), const PowerLevel(20, PowerLevelUnit.dBm));
      });

      test('parses with leading and trailing whitespace', () {
        expect(PowerLevel.parse('  -10 dBW  '), const PowerLevel(-10, PowerLevelUnit.dBW));
      });
    });

    group('Aliases and names', () {
      test('lowercase abbreviations are accepted as normalized names', () {
        expect(PowerLevel.parse('20 dbm'), const PowerLevel(20, PowerLevelUnit.dBm));
        expect(PowerLevel.parse('-10 dbw'), const PowerLevel(-10, PowerLevelUnit.dBW));
      });

      test('full names are case-insensitive', () {
        expect(
          PowerLevel.parse('20 DECIBEL MILLIWATTS'),
          const PowerLevel(20, PowerLevelUnit.dBm),
        );
        expect(
          PowerLevel.parse('-10 decibel watts'),
          const PowerLevel(-10, PowerLevelUnit.dBW),
        );
      });
    });

    group('Error handling', () {
      test('throws on invalid input', () {
        expect(() => PowerLevel.parse('invalid'), throwsA(isA<QuantityParseException>()));
      });

      test('tryParse returns null on invalid input', () {
        expect(PowerLevel.tryParse('invalid'), isNull);
      });
    });

    group('Round-trip', () {
      test('parse(toString()) preserves value and unit', () {
        const original = PowerLevel(20, PowerLevelUnit.dBm);
        expect(PowerLevel.parse(original.toString()), equals(original));
      });
    });
  });
}
