import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('Voltage parsing —', () {
    group('Basic parsing (invariant format)', () {
      test('parses volt with symbol', () {
        expect(Voltage.parse('1.5 V'), const Voltage(1.5, VoltageUnit.volt));
      });

      test('parses nanovolt', () {
        expect(Voltage.parse('100 nV'), const Voltage(100, VoltageUnit.nanovolt));
      });

      test('parses microvolt', () {
        expect(Voltage.parse('500 µV'), const Voltage(500, VoltageUnit.microvolt));
      });

      test('parses millivolt', () {
        expect(Voltage.parse('20 mV'), const Voltage(20, VoltageUnit.millivolt));
      });

      test('parses kilovolt', () {
        expect(Voltage.parse('10 kV'), const Voltage(10, VoltageUnit.kilovolt));
      });

      test('parses megavolt', () {
        expect(Voltage.parse('50 MV'), const Voltage(50, VoltageUnit.megavolt));
      });

      test('parses gigavolt', () {
        expect(Voltage.parse('100 GV'), const Voltage(100, VoltageUnit.gigavolt));
      });

      test('parses statvolt', () {
        expect(Voltage.parse('1 statV'), const Voltage(1, VoltageUnit.statvolt));
      });

      test('parses abvolt', () {
        expect(Voltage.parse('1 abV'), const Voltage(1, VoltageUnit.abvolt));
      });
    });

    group('Spacing tolerance', () {
      test('parses with no space', () {
        expect(Voltage.parse('1.5V'), const Voltage(1.5, VoltageUnit.volt));
      });

      test('parses with multiple spaces', () {
        expect(Voltage.parse('20   mV'), const Voltage(20, VoltageUnit.millivolt));
      });

      test('parses with leading/trailing whitespace', () {
        expect(Voltage.parse('  500 µV  '), const Voltage(500, VoltageUnit.microvolt));
      });
    });

    group('Case sensitivity', () {
      test('SI symbols are case-sensitive (V vs v)', () {
        expect(() => Voltage.parse('1.5 v'), throwsA(isA<QuantityParseException>()));
      });

      test('SI symbols distinguish prefixes (mV vs MV)', () {
        expect(Voltage.parse('20 mV'), const Voltage(20, VoltageUnit.millivolt));
        expect(Voltage.parse('20 MV'), const Voltage(20, VoltageUnit.megavolt));
      });

      test('full names are case-insensitive', () {
        expect(Voltage.parse('1.5 VOLT'), const Voltage(1.5, VoltageUnit.volt));
        expect(Voltage.parse('1.5 Volt'), const Voltage(1.5, VoltageUnit.volt));
        expect(Voltage.parse('20 millivolt'), const Voltage(20, VoltageUnit.millivolt));
      });

      test('micro prefix uV works as alias for µV', () {
        expect(Voltage.parse('500 uV'), const Voltage(500, VoltageUnit.microvolt));
      });

      test('full names for CGS units are case-insensitive', () {
        expect(Voltage.parse('1 STATVOLT'), const Voltage(1, VoltageUnit.statvolt));
        expect(Voltage.parse('1 Statvolt'), const Voltage(1, VoltageUnit.statvolt));
        expect(Voltage.parse('1 ABVOLT'), const Voltage(1, VoltageUnit.abvolt));
        expect(Voltage.parse('1 Abvolt'), const Voltage(1, VoltageUnit.abvolt));
      });
    });

    group('Error handling', () {
      test('throws on invalid number', () {
        expect(() => Voltage.parse('abc V'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on missing unit', () {
        expect(() => Voltage.parse('1.5'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on unknown unit', () {
        expect(() => Voltage.parse('1.5 xyz'), throwsA(isA<QuantityParseException>()));
      });

      test('returns null with tryParse on invalid input', () {
        expect(Voltage.tryParse('invalid'), isNull);
      });

      test('returns null with tryParse on missing unit', () {
        expect(Voltage.tryParse('1.5'), isNull);
      });
    });

    group('Round-trip', () {
      test('parse(toString()) preserves value and unit', () {
        const original = Voltage(20, VoltageUnit.millivolt);
        final roundTrip = Voltage.parse(original.toString());
        expect(roundTrip, equals(original));
      });

      test('parse(toString()) works for all units', () {
        for (final unit in VoltageUnit.values) {
          final original = Voltage(1, unit);
          final roundTrip = Voltage.parse(original.toString());
          expect(roundTrip, equals(original));
        }
      });
    });
  });
}
