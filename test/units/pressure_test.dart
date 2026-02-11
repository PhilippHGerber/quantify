import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  const tolerance = 1e-9; // Tolerance for double comparisons
  const highTolerance = 1e-6; // For conversions with rounding

  group('Pressure', () {
    // Helper for round trip tests
    void testRoundTrip(
      PressureUnit initialUnit,
      PressureUnit intermediateUnit,
      double initialValue, {
      double tolerance = 1e-9,
    }) {
      final p1 = Pressure(initialValue, initialUnit);
      final p2 = p1.convertTo(intermediateUnit);
      final p3 = p2.convertTo(initialUnit);
      expect(
        p3.value,
        closeTo(initialValue, tolerance),
        reason:
            '${initialUnit.symbol} -> ${intermediateUnit.symbol} -> ${initialUnit.symbol} failed for $initialValue',
      );
    }

    group('Constructors and Getters', () {
      test('should create Pressure from num extensions and retrieve values', () {
        final p1 = 101325.0.pa;
        expect(p1.value, 101325.0);
        expect(p1.unit, PressureUnit.pascal);
        expect(p1.inAtm, closeTo(1.0, 1e-9));

        final p2 = 1.0.atm;
        expect(p2.value, 1.0);
        expect(p2.unit, PressureUnit.atmosphere);
        expect(p2.inPa, closeTo(101325.0, 1e-9));

        final p3 = 30.0.psi;
        expect(p3.inPsi, 30.0);
        expect(p3.unit, PressureUnit.psi);

        final p4 = 1000.mbar; // millibars
        expect(p4.inMbar, 1000.0);
        expect(p4.inHPa, closeTo(1000.0, 1e-9)); // mbar and hPa are often same scale
        expect(p4.inBar, closeTo(1.0, 1e-9));
      });

      test('getValue should return correct value for same unit', () {
        const p = Pressure(15, PressureUnit.psi);
        expect(p.getValue(PressureUnit.psi), 15.0);
      });

      test('getValue for all units from Pascal base', () {
        final p = 100000.0.pa; // 1 bar
        expect(p.inPa, 100000.0);
        expect(p.inAtm, closeTo(100000.0 / 101325.0, 1e-7));
        expect(p.inBar, closeTo(1.0, 1e-9));
        expect(p.inPsi, closeTo(100000.0 / 6894.757293168361, 1e-7));
        // Torr is defined as exactly 1/760 of an atmosphere
        expect(p.inTorr, closeTo(100000.0 / (101325.0 / 760.0), 1e-7));
        // mmHg is based on actual mercury density at 0°C (slightly different from Torr)
        expect(p.inMmHg, closeTo(100000.0 / 133.322387415, 1e-7));
        // inHg is based on mmHg, not Torr
        expect(
          p.inInHg,
          closeTo(
            100000.0 / (133.322387415 * 25.4),
            1e-6,
          ),
        ); // Higher tolerance due to more factors
        expect(p.inKPa, closeTo(100.0, 1e-9));
        expect(p.inHPa, closeTo(1000.0, 1e-9));
        expect(p.inMbar, closeTo(1000.0, 1e-9));
        expect(p.inCmH2O, closeTo(100000.0 / 98.0665, 1e-7));
        expect(p.inInH2O, closeTo(100000.0 / 249.08891, 1e-7));
      });
    });

    group('Conversions', () {
      final oneAtm = 1.0.atm;

      test('1 atm to Pascals', () {
        expect(oneAtm.inPa, closeTo(101325.0, 1e-9));
      });
      test('1 atm to Bars', () {
        expect(oneAtm.inBar, closeTo(1.01325, 1e-9));
      });
      test('1 atm to PSI', () {
        expect(oneAtm.inPsi, closeTo(14.695948775513, 1e-7));
      });
      test('1 atm to Torr', () {
        // Torr is defined as exactly 1/760 of an atmosphere
        expect(oneAtm.inTorr, closeTo(760.0, 1e-9));
      });
      test('1 atm to mmHg', () {
        // mmHg is based on actual mercury density at 0°C (slightly different from Torr)
        // 1 atm = 101325 Pa, 1 mmHg = 133.322387415 Pa
        expect(oneAtm.inMmHg, closeTo(101325.0 / 133.322387415, 1e-7));
      });
      test('1 atm to Inches of Mercury', () {
        // inHg is based on mmHg, not Torr: 1 inHg = 133.322387415 * 25.4 Pa
        expect(oneAtm.inInHg, closeTo(101325.0 / (133.322387415 * 25.4), 1e-7));
      });
      test('1 atm to Kilopascals', () {
        expect(oneAtm.inKPa, closeTo(101.325, 1e-9));
      });
      test('1 atm to Hectopascals/Millibars', () {
        expect(oneAtm.inHPa, closeTo(1013.25, 1e-9));
        expect(oneAtm.inMbar, closeTo(1013.25, 1e-9));
      });
      test('1 atm to cmH2O', () {
        expect(oneAtm.inCmH2O, closeTo(101325.0 / 98.0665, 1e-7));
      });
      test('1 atm to inH2O', () {
        expect(oneAtm.inInH2O, closeTo(101325.0 / 249.08891, 1e-7));
      });

      // Test specific tricky conversions
      test('PSI to Bar', () {
        final pPsi = 29.0.psi; // Approx 1.99948 bar
        expect(pPsi.inBar, closeTo(29.0 * 6894.757293168361 / 100000.0, 1e-7));
      });

      test('Bar to PSI', () {
        final pBar = 2.0.bar; // Approx 29.0075 psi
        expect(pBar.inPsi, closeTo(2.0 * 100000.0 / 6894.757293168361, 1e-7));
      });

      test('inH2O to Pa', () {
        final pInH2O = 10.0.inH2O;
        expect(pInH2O.inPa, closeTo(10.0 * 249.08891, 1e-7));
      });
    });

    group('convertTo method', () {
      test('should return new Pressure object with converted value and unit', () {
        final pPsi = 29.0.psi;
        final pBar = pPsi.convertTo(PressureUnit.bar);
        expect(pBar.unit, PressureUnit.bar);
        expect(pBar.value, closeTo(pPsi.inBar, 1e-9));
        expect(pPsi.unit, PressureUnit.psi); // Original should be unchanged
      });

      test('convertTo same unit should return same instance (or equal if optimized)', () {
        final p1 = 10.0.pa;
        final p2 = p1.convertTo(PressureUnit.pascal);
        expect(identical(p1, p2), isTrue);
      });
    });

    group('Comparison (compareTo)', () {
      final pBar = 1.0.bar; // 100000 Pa
      final pPsiSlightlyLess = 14.5.psi; // 14.5 * 6894.757... ≈ 99973.98 Pa
      final pPsiSlightlyMore = 14.6.psi; // 14.6 * 6894.757... ≈ 100663.4 Pa
      final pAtm = 1.0.atm; // 101325 Pa

      test('should correctly compare pressures of different units', () {
        expect(pBar.compareTo(pPsiSlightlyLess), greaterThan(0)); // 1 bar > 14.5 psi
        expect(pPsiSlightlyLess.compareTo(pBar), lessThan(0)); // 14.5 psi < 1 bar
        expect(pBar.compareTo(pPsiSlightlyMore), lessThan(0)); // 1 bar < 14.6 psi
        expect(pBar.compareTo(pAtm), lessThan(0)); // 1 bar < 1 atm
      });

      test('should return 0 for equal pressures in different units', () {
        final pPascals = 100000.0.pa;
        final pMillibars = 1000.0.mbar;
        expect(pBar.compareTo(pPascals), 0);
        expect(pPascals.compareTo(pBar), 0);
        expect(pBar.compareTo(pMillibars), 0);
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
        expect(p1.hashCode == p2.hashCode, isFalse); // Likely false
        expect(p1.hashCode == p3.hashCode, isFalse); // Likely false
      });
    });

    group('toString()', () {
      test('should return formatted string', () {
        expect(14.7.psi.toString(), '14.7 psi');
        expect(1013.25.mbar.toString(), '1013.25 mbar');
        expect(1.0.atm.toString(), '1.0 atm');
        expect(25.0.cmH2O.toString(), '25.0 cmH₂O');
      });
    });

    group('Round Trip Conversions', () {
      const testValue = 123.456;
      const highTolerance = 1e-6; // For chains of conversions

      // Test all units via Pascal
      for (final unit in PressureUnit.values) {
        test('Round trip ${unit.symbol} <-> Pa', () {
          testRoundTrip(
            unit,
            PressureUnit.pascal,
            testValue,
            tolerance: (unit == PressureUnit.pascal) ? 1e-9 : highTolerance,
          );
        });
      }

      // Test some other common pairs
      test('Round trip psi <-> bar', () {
        testRoundTrip(PressureUnit.psi, PressureUnit.bar, testValue, tolerance: highTolerance);
      });
      test('Round trip atm <-> mmHg', () {
        testRoundTrip(
          PressureUnit.atmosphere,
          PressureUnit.millimeterOfMercury,
          2.5,
          tolerance: highTolerance,
        );
      });
      test('Round trip kPa <-> psi', () {
        testRoundTrip(PressureUnit.kilopascal, PressureUnit.psi, 350, tolerance: highTolerance);
      });
      test('Round trip inH2O <-> cmH2O', () {
        testRoundTrip(
          PressureUnit.inchOfWater,
          PressureUnit.centimeterOfWater,
          10,
          tolerance: highTolerance,
        );
      });
    });

    group('Edge Cases', () {
      test('Conversion with zero value', () {
        final pZero = 0.0.pa;
        for (final unit in PressureUnit.values) {
          expect(pZero.getValue(unit), 0.0, reason: '0 Pa to ${unit.symbol} should be 0');
        }
        final pPsiZero = 0.0.psi;
        for (final unit in PressureUnit.values) {
          expect(pPsiZero.getValue(unit), 0.0, reason: '0 psi to ${unit.symbol} should be 0');
        }
      });

      test('Conversion with negative value (if meaningful for pressure, though usually positive)',
          () {
        // Pressure is typically positive, but the math should still work.
        final pNegative = (-100.0).pa;
        expect(pNegative.inBar, closeTo(-0.001, 1e-9));
      });
    });

    group('Arithmetic Operators for Pressure', () {
      final p1Bar = 1.0.bar;
      final p2Bar = 2.0.bar;
      final p10Psi = 10.psi; // approx 0.689 bar

      // Operator +
      test('operator + combines pressures', () {
        final sum1 = p2Bar + p1Bar;
        expect(sum1.value, closeTo(3.0, tolerance));
        expect(sum1.unit, PressureUnit.bar);

        final sum2 = p1Bar + p10Psi; // 1 bar + ~0.689 bar
        final expectedSum2Value = 1.0 + p10Psi.getValue(PressureUnit.bar);
        expect(sum2.value, closeTo(expectedSum2Value, tolerance));
        expect(sum2.unit, PressureUnit.bar);

        final sum3 = p10Psi + p1Bar; // 10 psi + (1 bar in psi)
        final expectedSum3Value = 10.0 + p1Bar.getValue(PressureUnit.psi);
        expect(sum3.value, closeTo(expectedSum3Value, tolerance));
        expect(sum3.unit, PressureUnit.psi);
      });

      // Operator -
      test('operator - subtracts pressures', () {
        final diff1 = p2Bar - p1Bar;
        expect(diff1.value, closeTo(1.0, tolerance));
        expect(diff1.unit, PressureUnit.bar);

        final diff2 = p1Bar - p10Psi; // 1 bar - ~0.689 bar
        final expectedDiff2Value = 1.0 - p10Psi.getValue(PressureUnit.bar);
        expect(diff2.value, closeTo(expectedDiff2Value, tolerance));
        expect(diff2.unit, PressureUnit.bar);
      });

      // Operator * (scalar)
      test('operator * scales pressure by a scalar', () {
        final scaled = p2Bar * 1.5;
        expect(scaled.value, closeTo(3.0, tolerance));
        expect(scaled.unit, PressureUnit.bar);
      });

      // Operator / (scalar)
      test('operator / scales pressure by a scalar', () {
        final scaled = p2Bar / 4.0;
        expect(scaled.value, closeTo(0.5, tolerance));
        expect(scaled.unit, PressureUnit.bar);
        expect(() => p1Bar / 0.0, throwsArgumentError);
      });
    });

    group('Untested Extension Getters', () {
      test('inMegaPascals value getter', () {
        final p = 2.0.megaPascals; // 2 MPa = 2,000,000 Pa
        expect(p.inMegaPascals, closeTo(2.0, tolerance));
        expect(p.inPa, closeTo(2000000.0, tolerance));
        expect(1000000.0.pa.inMegaPascals, closeTo(1.0, tolerance));
      });

      test('asMegaPascals conversion getter', () {
        final p = 2000000.0.pa;
        final asMpa = p.asMegaPascals;
        expect(asMpa.unit, PressureUnit.megapascal);
        expect(asMpa.value, closeTo(2.0, tolerance));
      });

      test('megaPascals and mpa creation extensions', () {
        final fromMegaPascals = 5.0.megaPascals;
        final fromMpa = 5.0.mpa;
        expect(fromMegaPascals.unit, PressureUnit.megapascal);
        expect(fromMpa.unit, PressureUnit.megapascal);
        expect(fromMegaPascals.value, fromMpa.value);
        expect(fromMegaPascals.inPa, closeTo(5000000.0, tolerance));
      });

      test('kiloPascals creation extension (vs kPa alias)', () {
        final fromKiloPascals = 100.0.kiloPascals;
        final fromKPa = 100.0.kPa;
        expect(fromKiloPascals.unit, PressureUnit.kilopascal);
        expect(fromKPa.unit, PressureUnit.kilopascal);
        expect(fromKiloPascals.value, fromKPa.value);
      });

      test('asTorr conversion getter', () {
        final p = 760.0.torr;
        final asTorr = p.asTorr;
        expect(identical(p, asTorr), isTrue); // same unit → same instance
        final pAtm = 1.0.atm;
        expect(pAtm.asTorr.unit, PressureUnit.torr);
        expect(pAtm.asTorr.value, closeTo(760.0, tolerance));
      });

      test('asHPa conversion getter', () {
        final p = 1013.25.hPa;
        final asHPa = p.asHPa;
        expect(identical(p, asHPa), isTrue);
        expect(1.0.atm.asHPa.unit, PressureUnit.hectopascal);
        expect(1.0.atm.asHPa.value, closeTo(1013.25, tolerance));
      });

      test('asInH2O conversion getter', () {
        final p = 10.0.inH2O;
        final asInH2O = p.asInH2O;
        expect(identical(p, asInH2O), isTrue);
        expect(249.08891.pa.asInH2O.unit, PressureUnit.inchOfWater);
        expect(249.08891.pa.asInH2O.value, closeTo(1.0, highTolerance));
      });
    });

    group('Common Pressure Unit Extensions', () {
      test('should create and convert PSI (pounds per square inch)', () {
        // 1 psi = 6894.76 Pa
        final pressure = 30.psi; // Typical car tire pressure
        expect(pressure.value, 30.0);
        expect(pressure.unit, PressureUnit.psi);
        expect(pressure.inKiloPascals, closeTo(206.84, 0.01));
        expect(pressure.inBar, closeTo(2.068, 0.001));

        final pressureAsBar = pressure.asBar;
        expect(pressureAsBar.value, closeTo(2.068, 0.001));
        expect(pressureAsBar.unit, PressureUnit.bar);
      });

      test('should create and convert mmHg (millimeters of mercury)', () {
        // 1 mmHg = 133.322 Pa, normal blood pressure ~120 mmHg
        final pressure = 120.mmHg;
        expect(pressure.value, 120.0);
        expect(pressure.unit, PressureUnit.millimeterOfMercury);
        expect(pressure.inKiloPascals, closeTo(15.999, 0.001));
        expect(pressure.inPsi, closeTo(2.32, 0.01));

        final pressureAsPa = pressure.asPa;
        expect(pressureAsPa.value, closeTo(15998.64, 1.0));
        expect(pressureAsPa.unit, PressureUnit.pascal);
      });

      test('should create and convert inHg (inches of mercury)', () {
        // 1 inHg = 3386.39 Pa, typical barometric pressure ~30 inHg
        final pressure = 29.92.inHg; // Standard atmospheric pressure
        expect(pressure.value, closeTo(29.92, tolerance));
        expect(pressure.unit, PressureUnit.inchOfMercury);
        expect(pressure.inMbar, closeTo(1013.25, 0.1)); // Standard atmosphere
        expect(pressure.inAtm, closeTo(1.0, 0.01));

        final pressureAsMbar = pressure.asMbar;
        expect(pressureAsMbar.value, closeTo(1013.25, 0.1));
        expect(pressureAsMbar.unit, PressureUnit.millibar);
      });

      test('practical pressure unit conversions', () {
        // Sea level pressure
        final seaLevel = 1.atm;
        expect(seaLevel.inBar, closeTo(1.01325, tolerance));
        expect(seaLevel.inPsi, closeTo(14.6959, 0.001)); // 1 atm = 14.6959 psi
        expect(seaLevel.inMmHg, closeTo(760.0, 0.001)); // 760 mmHg = 1 atm

        // Scuba diving depth pressure (2 atm at 10m depth)
        final divingPressure = 2.atm;
        expect(divingPressure.inBar, closeTo(2.0265, tolerance));
      });

      test('round trip conversions for pressure units', () {
        const testValue = 15.5;

        final psiOrig = testValue.psi;
        final psiRoundTrip = psiOrig.asKiloPascals.asPsi;
        expect(psiRoundTrip.value, closeTo(testValue, highTolerance));

        final mmHgOrig = testValue.mmHg;
        final mmHgRoundTrip = mmHgOrig.asPa.asMmHg;
        expect(mmHgRoundTrip.value, closeTo(testValue, highTolerance));

        final inHgOrig = testValue.inHg;
        final inHgRoundTrip = inHgOrig.asMbar.asInHg;
        expect(inHgRoundTrip.value, closeTo(testValue, highTolerance));
      });
    });
  });
}
