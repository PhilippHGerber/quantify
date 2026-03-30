import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('VoltageLevel parsing —', () {
    group('Basic parsing', () {
      test('parses dBV symbol', () {
        expect(VoltageLevel.parse('0 dBV'), const VoltageLevel(0, VoltageLevelUnit.dBV));
      });

      test('parses dBu symbol', () {
        expect(VoltageLevel.parse('4 dBu'), const VoltageLevel(4, VoltageLevelUnit.dBu));
      });

      test('parses dBv alias as dBV', () {
        expect(VoltageLevel.parse('0 dBv'), const VoltageLevel(0, VoltageLevelUnit.dBV));
      });
    });

    group('Spacing tolerance', () {
      test('parses with no space', () {
        expect(VoltageLevel.parse('4dBu'), const VoltageLevel(4, VoltageLevelUnit.dBu));
      });
    });

    group('Aliases and names', () {
      test('lowercase abbreviations are accepted as normalized names', () {
        expect(VoltageLevel.parse('0 dbv'), const VoltageLevel(0, VoltageLevelUnit.dBV));
        expect(VoltageLevel.parse('4 dbu'), const VoltageLevel(4, VoltageLevelUnit.dBu));
      });

      test('full names are case-insensitive', () {
        expect(
          VoltageLevel.parse('0 DECIBEL VOLTS'),
          const VoltageLevel(0, VoltageLevelUnit.dBV),
        );
        expect(
          VoltageLevel.parse('4 decibel unloaded'),
          const VoltageLevel(4, VoltageLevelUnit.dBu),
        );
      });
    });

    group('Error handling', () {
      test('throws on invalid input', () {
        expect(() => VoltageLevel.parse('invalid'), throwsA(isA<QuantityParseException>()));
      });

      test('tryParse returns null on invalid input', () {
        expect(VoltageLevel.tryParse('invalid'), isNull);
      });
    });

    group('Round-trip', () {
      test('parse(toString()) preserves value and unit', () {
        const original = VoltageLevel(4, VoltageLevelUnit.dBu);
        expect(VoltageLevel.parse(original.toString()), equals(original));
      });
    });
  });
}
