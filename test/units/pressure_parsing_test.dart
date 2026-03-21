import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('Pressure parsing —', () {
    group('Basic parsing (invariant format)', () {
      test('parses pascal with symbol', () {
        expect(Pressure.parse('101325 Pa'), const Pressure(101325, PressureUnit.pascal));
      });

      test('parses atmosphere', () {
        expect(Pressure.parse('1 atm'), const Pressure(1, PressureUnit.atmosphere));
      });

      test('parses bar', () {
        expect(Pressure.parse('1.01325 bar'), const Pressure(1.01325, PressureUnit.bar));
      });

      test('parses psi', () {
        expect(Pressure.parse('14.7 psi'), const Pressure(14.7, PressureUnit.psi));
      });

      test('parses torr', () {
        expect(Pressure.parse('760 Torr'), const Pressure(760, PressureUnit.torr));
      });

      test('parses millimeters of mercury', () {
        expect(Pressure.parse('760 mmHg'), const Pressure(760, PressureUnit.millimeterOfMercury));
      });

      test('parses inches of mercury', () {
        expect(Pressure.parse('29.92 inHg'), const Pressure(29.92, PressureUnit.inchOfMercury));
      });
    });

    group('SI prefixes', () {
      test('parses megapascal', () {
        expect(Pressure.parse('10 MPa'), const Pressure(10, PressureUnit.megapascal));
      });

      test('parses kilopascal', () {
        expect(Pressure.parse('101.325 kPa'), const Pressure(101.325, PressureUnit.kilopascal));
      });

      test('parses hectopascal', () {
        expect(Pressure.parse('1013.25 hPa'), const Pressure(1013.25, PressureUnit.hectopascal));
      });

      test('parses millibar', () {
        expect(Pressure.parse('1013.25 mbar'), const Pressure(1013.25, PressureUnit.millibar));
      });
    });

    group('Spacing tolerance', () {
      test('parses with no space', () {
        expect(Pressure.parse('101325Pa'), const Pressure(101325, PressureUnit.pascal));
      });

      test('parses with multiple spaces', () {
        expect(Pressure.parse('1   atm'), const Pressure(1, PressureUnit.atmosphere));
      });

      test('parses with leading/trailing whitespace', () {
        expect(Pressure.parse('  1.01325 bar  '), const Pressure(1.01325, PressureUnit.bar));
      });
    });

    group('Case sensitivity', () {
      test('SI symbols are case-sensitive (Pa vs pa)', () {
        expect(() => Pressure.parse('101325 pa'), throwsA(isA<QuantityParseException>()));
      });

      test('SI symbols distinguish prefixes (MPa vs mPa)', () {
        expect(Pressure.parse('10 MPa'), const Pressure(10, PressureUnit.megapascal));
        expect(() => Pressure.parse('10 mPa'), throwsA(isA<QuantityParseException>()));
      });

      test('full names are case-insensitive', () {
        expect(Pressure.parse('1 PASCAL'), const Pressure(1, PressureUnit.pascal));
        expect(Pressure.parse('1 Pascal'), const Pressure(1, PressureUnit.pascal));
        expect(Pressure.parse('1 atmosphere'), const Pressure(1, PressureUnit.atmosphere));
        expect(Pressure.parse('1 ATMOSPHERE'), const Pressure(1, PressureUnit.atmosphere));
      });

      test('non-SI abbreviations are case-insensitive', () {
        expect(Pressure.parse('1 ATM'), const Pressure(1, PressureUnit.atmosphere));
        expect(Pressure.parse('14.7 PSI'), const Pressure(14.7, PressureUnit.psi));
        expect(Pressure.parse('760 TORR'), const Pressure(760, PressureUnit.torr));
        expect(Pressure.parse('760 MMHG'), const Pressure(760, PressureUnit.millimeterOfMercury));
      });
    });

    group('Error handling', () {
      test('throws on invalid number', () {
        expect(() => Pressure.parse('abc Pa'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on missing unit', () {
        expect(() => Pressure.parse('101325'), throwsA(isA<QuantityParseException>()));
      });

      test('throws on unknown unit', () {
        expect(() => Pressure.parse('1 xyz'), throwsA(isA<QuantityParseException>()));
      });

      test('returns null with tryParse on invalid input', () {
        expect(Pressure.tryParse('invalid'), isNull);
      });

      test('returns null with tryParse on missing unit', () {
        expect(Pressure.tryParse('101325'), isNull);
      });
    });

    group('Round-trip', () {
      test('parse(toString()) preserves value and unit', () {
        const original = Pressure(14.7, PressureUnit.psi);
        final roundTrip = Pressure.parse(original.toString());
        expect(roundTrip, equals(original));
      });

      test('parse(toString()) works for all units', () {
        for (final unit in PressureUnit.values) {
          final original = Pressure(1, unit);
          final roundTrip = Pressure.parse(original.toString());
          expect(roundTrip, equals(original));
        }
      });
    });
  });
}
