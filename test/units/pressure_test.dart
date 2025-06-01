import 'package:quantify/quantify.dart'; // Assuming you export Pressure types from here
import 'package:test/test.dart';

void main() {
  group('Pressure', () {
    group('Constructors and Getters', () {
      test('should create Pressure from num extensions and retrieve values', () {
        final p1 = 101325.0.pascals;
        expect(p1.value, 101325.0);
        expect(p1.unit, PressureUnit.pascal);
        expect(p1.inAtmospheres, closeTo(1.0, 1e-9));

        final p2 = 1.atmospheres;
        expect(p2.value, 1.0);
        expect(p2.unit, PressureUnit.atmosphere);
        expect(p2.inPascals, closeTo(101325.0, 1e-9));
      });

      test('getValue should return correct value for same unit', () {
        const p = Pressure(15, PressureUnit.psi);
        expect(p.getValue(PressureUnit.psi), 15.0);
      });
    });

    group('Conversions', () {
      // Example: 1 atm to other units
      final oneAtm = 1.0.atmospheres;

      test('1 atm to Pascals', () {
        expect(oneAtm.inPascals, closeTo(101325.0, 1e-9));
      });
      test('1 atm to Bars', () {
        expect(oneAtm.inBars, closeTo(1.01325, 1e-9));
      });
      test('1 atm to PSI', () {
        // 1 atm = 101325 Pa; 1 psi = 6894.757293168361 Pa
        // 101325 / 6894.757293168361 = 14.6959...
        expect(oneAtm.inPsi, closeTo(14.6959487755, 1e-7)); // Adjusted tolerance
      });
      test('1 atm to Torr (mmHg)', () {
        expect(oneAtm.inTorrs, closeTo(760.0, 1e-9));
        expect(oneAtm.inMillimetersOfMercury, closeTo(760.0, 1e-9));
      });
      test('1 bar to PSI', () {
        final oneBar = 1.0.bars;
        // 1 bar = 100000 Pa
        // 100000 / 6894.757293168361 = 14.50377...
        expect(oneBar.inPsi, closeTo(14.503773773, 1e-7));
      });
      // Add more conversion tests for various pairs...
    });

    group('convertTo method', () {
      test('should return new Pressure object with converted value and unit', () {
        final pPsi = 29.0.psi;
        final pBar = pPsi.convertTo(PressureUnit.bar);
        expect(pBar.unit, PressureUnit.bar);
        expect(pBar.value, closeTo(pPsi.inBars, 1e-9)); // Compare with getter
        expect(pPsi.unit, PressureUnit.psi); // Original should be unchanged
      });

      test('convertTo same unit should return same instance (or equal)', () {
        final p1 = 10.0.pascals;
        final p2 = p1.convertTo(PressureUnit.pascal);
        expect(identical(p1, p2), isTrue); // Due to optimization in convertTo
      });
    });

    group('Comparison (compareTo)', () {
      final pBar = 1.0.bars; // 100000 Pa
      final pPsi = 14.5.psi; // 14.5 * 6894.757... approx 99974 Pa
      final pAtm = 1.0.atmospheres; // 101325 Pa

      test('should correctly compare pressures of different units', () {
        expect(pBar.compareTo(pPsi), greaterThan(0)); // 1 bar > 14.5 psi
        expect(pPsi.compareTo(pBar), lessThan(0)); // 14.5 psi < 1 bar
        expect(pBar.compareTo(pAtm), lessThan(0)); // 1 bar < 1 atm
      });

      test('should return 0 for equal pressures in different units', () {
        final pPascals = 100000.0.pascals;
        expect(pBar.compareTo(pPascals), 0);
        expect(pPascals.compareTo(pBar), 0);
      });
    });

    group('Equality and HashCode', () {
      test('should be equal for same value and unit', () {
        const p1 = Pressure(10, PressureUnit.bar);
        const p2 = Pressure(10, PressureUnit.bar);
        expect(p1 == p2, isTrue);
        expect(p1.hashCode == p2.hashCode, isTrue);
      });

      test('should not be equal for different values or units', () {
        const p1 = Pressure(10, PressureUnit.bar);
        const p2 = Pressure(10.1, PressureUnit.bar);
        const p3 = Pressure(10, PressureUnit.psi);
        expect(p1 == p2, isFalse);
        expect(p1 == p3, isFalse);
      });
    });

    group('toString()', () {
      test('should return formatted string', () {
        final p = 14.7.psi;
        expect(p.toString(), '14.7 psi');
      });
    });

    // TODO: Add round-trip conversion tests
    // Example:
    // test('Round trip psi -> bar -> psi', () {
    //   const originalValue = 30.0;
    //   final p1 = originalValue.psi;
    //   final p2 = p1.convertTo(PressureUnit.bar).convertTo(PressureUnit.psi);
    //   expect(p2.value, closeTo(originalValue, 1e-9)); // Adjust tolerance
    // });
  });
}
