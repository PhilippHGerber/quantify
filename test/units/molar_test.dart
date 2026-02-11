// ignore_for_file: prefer_int_literals // All constants are doubles for precision.

import 'package:quantify/quantify.dart'; // Assuming MolarAmount and MolarUnit are exported
import 'package:test/test.dart';

void main() {
  group('MolarAmount', () {
    const tolerance = 1e-12; // Molar amounts can be very small, requiring higher precision
    const defaultTolerance = 1e-9; // For general comparisons

    // Helper for round trip tests
    void testRoundTrip(
      MolarUnit initialUnit,
      MolarUnit intermediateUnit,
      double initialValue, {
      double tol = tolerance, // Default to higher precision for molar round trips
    }) {
      final ma1 = MolarAmount(initialValue, initialUnit);
      final ma2 = ma1.convertTo(intermediateUnit);
      final ma3 = ma2.convertTo(initialUnit);
      expect(
        ma3.value,
        closeTo(initialValue, tol),
        reason:
            '${initialUnit.symbol} -> ${intermediateUnit.symbol} -> ${initialUnit.symbol} failed for $initialValue. Expected $initialValue, got ${ma3.value}',
      );
    }

    group('Constructors and Getters (from num extensions)', () {
      test('should create MolarAmount from num extensions and retrieve values correctly', () {
        final maMol = 0.5.mol;
        expect(maMol.value, 0.5);
        expect(maMol.unit, MolarUnit.mole);
        expect(maMol.inMillimoles, closeTo(500.0, tolerance));
        expect(maMol.asMillimoles.value, closeTo(500.0, tolerance));
        expect(maMol.asMillimoles.unit, MolarUnit.millimole);

        final maMmol = 2500.0.millimoles; // Using alias
        expect(maMmol.value, 2500.0);
        expect(maMmol.unit, MolarUnit.millimole);
        expect(maMmol.inMoles, closeTo(2.5, tolerance));

        final maUmol = 1234.0.umol;
        expect(maUmol.value, 1234.0);
        expect(maUmol.unit, MolarUnit.micromole);
        expect(maUmol.inMoles, closeTo(0.001234, tolerance));
        expect(maUmol.inNanomoles, closeTo(1234000.0, 1e-9));
      });

      test('getValue should return correct value for same unit', () {
        const molarAmount = MolarAmount(0.025, MolarUnit.mole);
        expect(molarAmount.getValue(MolarUnit.mole), 0.025);
      });
    });

    group('Conversions between various molar units', () {
      final oneMole = 1.0.mol;
      test('1 Mole to other units', () {
        expect(oneMole.inKilomoles, closeTo(0.001, tolerance));
        expect(oneMole.inMillimoles, closeTo(1000.0, tolerance));
        expect(oneMole.inMicromoles, closeTo(1000000.0, tolerance));
        expect(oneMole.inNanomoles, closeTo(1.0e9, 1e-6));
        expect(oneMole.inPicomoles, closeTo(1.0e12, tolerance));
      });

      final oneKiloMole = 1.0.kmol;
      test('1 Kilomole to moles', () {
        expect(oneKiloMole.inMoles, closeTo(1000.0, tolerance));
      });

      final oneMilliMole = 1.0.mmol;
      test('1 Millimole to micromoles and moles', () {
        expect(oneMilliMole.inMicromoles, closeTo(1000.0, tolerance));
        expect(oneMilliMole.inMoles, closeTo(0.001, tolerance));
      });

      final oneNanoMole = 123.0.nmol;
      test('123 Nanomoles to picomoles and micromoles', () {
        expect(oneNanoMole.inPicomoles, closeTo(123000.0, 1e-10));
        expect(oneNanoMole.inMicromoles, closeTo(0.123, tolerance));
      });
    });

    group('convertTo method', () {
      test('should return new MolarAmount object with converted value and unit', () {
        final maMmol = 1500.0.mmol;
        final maMol = maMmol.convertTo(MolarUnit.mole);

        expect(maMol.unit, MolarUnit.mole);
        expect(maMol.value, closeTo(1.5, tolerance));
        expect(maMmol.unit, MolarUnit.millimole); // Original should be unchanged
        expect(maMmol.value, 1500.0);
      });

      test('convertTo same unit should return same instance (immutable optimization)', () {
        final ma1 = 0.1.mol;
        final ma2 = ma1.convertTo(MolarUnit.mole);
        expect(identical(ma1, ma2), isTrue);
      });
    });

    group('Comparison (compareTo)', () {
      final ma1Mol = 1.0.mol;
      final ma1000Mmol = 1000.0.mmol;
      final ma999Mmol = 999.0.mmol;
      final ma0_1Kmol = 0.1.kmol; // 100 mol
      final ma0_0001Kmol = 0.0001.kmol; // 0.1 mol

      test('should correctly compare molar amounts of different units', () {
        expect(ma1Mol.compareTo(ma999Mmol), greaterThan(0)); // 1mol > 999mmol
        expect(ma999Mmol.compareTo(ma1Mol), lessThan(0)); // 999mmol < 1mol
        expect(ma1Mol.compareTo(ma1000Mmol), 0); // 1mol == 1000mmol

        expect(ma1Mol.compareTo(ma0_1Kmol), lessThan(0)); // 1mol < 100mol
        expect(ma1Mol.compareTo(ma0_0001Kmol), greaterThan(0)); // 1mol > 0.1mol
      });

      test('should return 0 for equal molar amounts in different units', () {
        final maInUmol = 1000000.0.umol; // 1 mol in micromoles
        expect(ma1Mol.compareTo(maInUmol), 0);
      });
    });

    group('Equality (operator ==) and HashCode', () {
      test('should be equal for same value and unit', () {
        const ma1 = MolarAmount(0.05, MolarUnit.mole);
        const ma2 = MolarAmount(0.05, MolarUnit.mole);
        expect(ma1 == ma2, isTrue);
        expect(ma1.hashCode == ma2.hashCode, isTrue);
      });

      test('should not be equal for different values or units', () {
        const ma1 = MolarAmount(0.05, MolarUnit.mole);
        const ma2Diffval = MolarAmount(0.051, MolarUnit.mole);
        const ma3Diffunit = MolarAmount(0.05, MolarUnit.millimole);
        const ma4Diffvalandunit = MolarAmount(1.0, MolarUnit.kilomole);

        expect(ma1 == ma2Diffval, isFalse);
        expect(ma1 == ma3Diffunit, isFalse);
        expect(ma1 == ma4Diffvalandunit, isFalse);

        expect(ma1.hashCode == ma2Diffval.hashCode, isFalse);
        expect(ma1.hashCode == ma3Diffunit.hashCode, isFalse);
      });

      test('equality is strict, 1.mol is not equal to 1000.mmol', () {
        final oneMol = 1.mol;
        final thousandMmol = 1000.mmol;
        expect(oneMol == thousandMmol, isFalse);
        expect(oneMol.compareTo(thousandMmol), 0);
      });
    });

    group('toString() (basic check, formatting is in Quantity class)', () {
      test('should return formatted string with default non-breaking space', () {
        expect(0.25.mol.toString(), '0.25\u00A0mol');
        expect(123.micromoles.toString(), '123.0\u00A0µmol'); // Note µ symbol
        expect(
          1.5e-9.nmol.toString(),
          '1.5e-9\u00A0nmol',
        ); // Scientific notation from double.toString()
      });
    });

    group('Round Trip Conversions (thorough)', () {
      const testValue = 0.0123456789;

      // Test all units via Mole (the base for MolarUnit)
      for (final unit in MolarUnit.values) {
        test('Round trip ${unit.symbol} <-> mol', () {
          testRoundTrip(
            unit,
            MolarUnit.mole,
            testValue,
            tol: (unit == MolarUnit.mole) ? tolerance : tolerance, // Use high precision always
          );
        });
      }

      // Test some other common pairs
      test('Round trip mmol <-> µmol', () {
        testRoundTrip(MolarUnit.millimole, MolarUnit.micromole, 0.5);
      });
      test('Round trip nmol <-> pmol', () {
        testRoundTrip(MolarUnit.nanomole, MolarUnit.picomole, 0.005);
      });
      test('Round trip mol <-> kmol', () {
        testRoundTrip(MolarUnit.mole, MolarUnit.kilomole, 2500.0);
      });
    });

    group('Edge Cases', () {
      test('Conversion with zero value', () {
        final maZeroMol = 0.0.mol;
        for (final unit in MolarUnit.values) {
          expect(maZeroMol.getValue(unit), 0.0, reason: '0 mol to ${unit.symbol} should be 0');
        }
      });

      test('Conversion with very small and large values', () {
        final verySmall = 1.0e-15.mol; // femtomoles range
        expect(verySmall.inPicomoles, closeTo(0.001, tolerance));

        final veryLarge = 1.0e6.mol; // megamoles range
        expect(veryLarge.inKilomoles, closeTo(1000.0, tolerance));
      });
    });

    group('Arithmetic Operators for MolarAmount', () {
      final ma1mol = 1.0.mol;
      final ma2mol = 2.0.mol;
      final ma500mmol = 500.mmol; // 0.5 mol
      final ma100umol = 100.umol; // 0.0001 mol

      // Operator +
      test('operator + combines molar amounts, result in unit of left operand', () {
        final sum1 = ma2mol + ma1mol;
        expect(sum1.value, closeTo(3.0, defaultTolerance));
        expect(sum1.unit, MolarUnit.mole);

        final sum2 = ma1mol + ma500mmol; // 1mol + 0.5mol = 1.5mol
        expect(sum2.value, closeTo(1.5, defaultTolerance));
        expect(sum2.unit, MolarUnit.mole);

        final sum3 = ma500mmol + ma1mol; // 500mmol + 1000mmol = 1500mmol
        expect(sum3.value, closeTo(1500.0, defaultTolerance));
        expect(sum3.unit, MolarUnit.millimole);

        final sum4 = ma1mol + ma100umol; // 1mol + 0.0001mol
        expect(sum4.value, closeTo(1.0 + 0.0001, tolerance));
        expect(sum4.unit, MolarUnit.mole);
      });

      // Operator -
      test('operator - subtracts molar amounts, result in unit of left operand', () {
        final diff1 = ma2mol - ma1mol;
        expect(diff1.value, closeTo(1.0, defaultTolerance));
        expect(diff1.unit, MolarUnit.mole);

        final diff2 = ma1mol - ma500mmol; // 1mol - 0.5mol = 0.5mol
        expect(diff2.value, closeTo(0.5, defaultTolerance));
        expect(diff2.unit, MolarUnit.mole);

        final diff3 = ma1mol - ma100umol; // 1mol - 0.0001mol
        expect(diff3.value, closeTo(1.0 - 0.0001, tolerance));
        expect(diff3.unit, MolarUnit.mole);
      });

      // Operator * (scalar)
      test('operator * scales molar amount by a scalar', () {
        final scaled1 = ma2mol * 3.5;
        expect(scaled1.value, closeTo(7.0, defaultTolerance));
        expect(scaled1.unit, MolarUnit.mole);

        final scaled2 = ma500mmol * 0.1;
        expect(scaled2.value, closeTo(50.0, defaultTolerance));
        expect(scaled2.unit, MolarUnit.millimole);
      });

      // Operator / (scalar)
      test('operator / scales molar amount by a scalar', () {
        final scaled1 = ma2mol / 4.0;
        expect(scaled1.value, closeTo(0.5, defaultTolerance));
        expect(scaled1.unit, MolarUnit.mole);

        final scaled2 = ma1mol / 0.01;
        expect(scaled2.value, closeTo(100.0, defaultTolerance));
        expect(scaled2.unit, MolarUnit.mole);

        expect(() => ma1mol / 0.0, throwsArgumentError, reason: 'Division by zero should throw');
      });

      test('operator chaining preserves immutability', () {
        final initialAmount = 0.1.mol;
        final maAdd = initialAmount + 50.mmol; // 0.1mol + 0.05mol = 0.15mol
        final maMul = maAdd * 10.0; // 0.15mol * 10 = 1.5mol
        final maSub = maMul - 100000.umol; // 1.5mol - 0.1mol = 1.4mol

        expect(initialAmount.value, 0.1); // Original unchanged
        expect(initialAmount.unit, MolarUnit.mole);

        expect(maAdd.value, closeTo(0.15, tolerance));
        expect(maAdd.unit, MolarUnit.mole);

        expect(maMul.value, closeTo(1.5, tolerance));
        expect(maMul.unit, MolarUnit.mole);

        final expectedMaSubVal = 1.5 - 100000.0.umol.getValue(MolarUnit.mole);
        expect(maSub.value, closeTo(expectedMaSubVal, tolerance));
        expect(maSub.unit, MolarUnit.mole);
      });
    });

    group('Comprehensive Extension Coverage', () {
      test('all creation extension aliases', () {
        expect(0.5.mol.unit, MolarUnit.mole);
        expect(0.5.moles.unit, MolarUnit.mole);
        expect(1.0.mmol.unit, MolarUnit.millimole);
        expect(1.0.millimoles.unit, MolarUnit.millimole);
        expect(1.0.umol.unit, MolarUnit.micromole);
        expect(1.0.micromoles.unit, MolarUnit.micromole);
        expect(1.0.nmol.unit, MolarUnit.nanomole);
        expect(1.0.nanomoles.unit, MolarUnit.nanomole);
        expect(1.0.pmol.unit, MolarUnit.picomole);
        expect(1.0.picomoles.unit, MolarUnit.picomole);
        expect(1.0.kmol.unit, MolarUnit.kilomole);
        expect(1.0.kilomoles.unit, MolarUnit.kilomole);
        expect(5.0.moles.value, 5.0);
        expect(500.0.mmol.inMoles, closeTo(0.5, tolerance));
      });

      test('all as* conversion getters', () {
        final base = 1.0.mol;

        final asMol = base.asMoles;
        expect(asMol.unit, MolarUnit.mole);
        expect(asMol.value, closeTo(1.0, tolerance));

        final asMmol = base.asMillimoles;
        expect(asMmol.unit, MolarUnit.millimole);
        expect(asMmol.value, closeTo(1000.0, tolerance));

        final asUmol = base.asMicromoles;
        expect(asUmol.unit, MolarUnit.micromole);
        expect(asUmol.value, closeTo(1e6, tolerance));

        final asNmol = base.asNanomoles;
        expect(asNmol.unit, MolarUnit.nanomole);
        expect(asNmol.value, closeTo(1e9, 1e-3));

        final asPmol = base.asPicomoles;
        expect(asPmol.unit, MolarUnit.picomole);
        expect(asPmol.value, closeTo(1e12, tolerance));

        final asKmol = base.asKilomoles;
        expect(asKmol.unit, MolarUnit.kilomole);
        expect(asKmol.value, closeTo(0.001, tolerance));
      });
    });
  });
}
