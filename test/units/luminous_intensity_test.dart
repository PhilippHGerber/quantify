// ignore_for_file: prefer_int_literals // All constants are doubles for precision.

import 'package:quantify/quantify.dart'; // Assuming LuminousIntensity and Unit are exported
import 'package:test/test.dart';

void main() {
  group('LuminousIntensity', () {
    const strictTolerance = 1e-12; // For "exact" conversions
    const defaultTolerance = 1e-9; // General purpose

    // Helper for round trip tests
    void testRoundTrip(
      LuminousIntensityUnit initialUnit,
      LuminousIntensityUnit intermediateUnit,
      double initialValue, {
      double tol = defaultTolerance,
    }) {
      final li1 = LuminousIntensity(initialValue, initialUnit);
      final li2 = li1.convertTo(intermediateUnit);
      final li3 = li2.convertTo(initialUnit);
      expect(
        li3.value,
        closeTo(initialValue, tol),
        reason:
            '${initialUnit.symbol} -> ${intermediateUnit.symbol} -> ${initialUnit.symbol} failed for $initialValue. Expected $initialValue, got ${li3.value}',
      );
    }

    group('Constructors and Getters (from num extensions)', () {
      test('should create LuminousIntensity from num extensions and retrieve values', () {
        final liCd = 100.0.cd;
        expect(liCd.value, 100.0);
        expect(liCd.unit, LuminousIntensityUnit.candela);
        expect(liCd.inMillicandelas, closeTo(100000.0, strictTolerance));
        expect(liCd.asMillicandelas.value, closeTo(100000.0, strictTolerance));
        expect(liCd.asMillicandelas.unit, LuminousIntensityUnit.millicandela);

        final liMcd = 250.0.millicandelas; // Using alias
        expect(liMcd.value, 250.0);
        expect(liMcd.unit, LuminousIntensityUnit.millicandela);
        expect(liMcd.inCandelas, closeTo(0.25, strictTolerance));

        final liKcd = 0.5.kcd;
        expect(liKcd.value, 0.5);
        expect(liKcd.unit, LuminousIntensityUnit.kilocandela);
        expect(liKcd.inCandelas, closeTo(500.0, strictTolerance));
      });

      test('getValue should return correct value for same unit', () {
        const intensity = LuminousIntensity(15.0, LuminousIntensityUnit.candela);
        expect(intensity.getValue(LuminousIntensityUnit.candela), 15.0);
      });

      test('kilocandelas num alias matches kcd', () {
        final fromAlias = 2.0.kilocandelas;
        final fromShort = 2.0.kcd;
        expect(fromAlias.value, fromShort.value);
        expect(fromAlias.unit, LuminousIntensityUnit.kilocandela);
      });
    });

    group('Conversions between various luminous intensity units', () {
      final oneCandela = 1.0.cd;
      test('1 Candela to other units', () {
        expect(oneCandela.inMillicandelas, closeTo(1000.0, strictTolerance));
        expect(oneCandela.inKilocandelas, closeTo(0.001, strictTolerance));
      });

      final oneKilocandela = 1.0.kcd;
      test('1 Kilocandela to candelas and millicandelas', () {
        expect(oneKilocandela.inCandelas, closeTo(1000.0, strictTolerance));
        expect(oneKilocandela.inMillicandelas, closeTo(1000000.0, strictTolerance));
      });

      final oneMillicandela = 1.0.mcd;
      test('1 Millicandela to candelas', () {
        expect(oneMillicandela.inCandelas, closeTo(0.001, strictTolerance));
      });

      test('asKilocandelas returns correct object', () {
        final li = 5000.0.cd;
        final asKcd = li.asKilocandelas;
        expect(asKcd.unit, LuminousIntensityUnit.kilocandela);
        expect(asKcd.value, closeTo(5.0, strictTolerance));
      });
    });

    group('convertTo method', () {
      test('should return new LuminousIntensity object with converted value and unit', () {
        final liMcd = 12500.0.mcd;
        final liCd = liMcd.convertTo(LuminousIntensityUnit.candela);

        expect(liCd.unit, LuminousIntensityUnit.candela);
        expect(liCd.value, closeTo(12.5, strictTolerance));
        expect(liMcd.unit, LuminousIntensityUnit.millicandela); // Original unchanged
        expect(liMcd.value, 12500.0);
      });

      test('convertTo same unit should return same instance (immutable optimization)', () {
        final li1 = 10.0.cd;
        final li2 = li1.convertTo(LuminousIntensityUnit.candela);
        expect(identical(li1, li2), isTrue);
      });
    });

    group('Comparison (compareTo)', () {
      final li1Cd = 1.0.cd;
      final li1000Mcd = 1000.0.mcd;
      final li999Mcd = 999.0.mcd;
      final li0_002Kcd = 0.002.kcd; // 2 cd
      final li0_0005Kcd = 0.0005.kcd; // 0.5 cd

      test('should correctly compare luminous intensities of different units', () {
        expect(li1Cd.compareTo(li999Mcd), greaterThan(0)); // 1cd > 999mcd
        expect(li999Mcd.compareTo(li1Cd), lessThan(0)); // 999mcd < 1cd
        expect(li1Cd.compareTo(li1000Mcd), 0); // 1cd == 1000mcd

        expect(li1Cd.compareTo(li0_002Kcd), lessThan(0)); // 1cd < 2cd
        expect(li1Cd.compareTo(li0_0005Kcd), greaterThan(0)); // 1cd > 0.5cd
      });

      test('should return 0 for equal luminous intensities in different units', () {
        final liInKcd = 0.001.kcd; // 1 cd in kilocandelas
        expect(li1Cd.compareTo(liInKcd), 0);
      });
    });

    group('Equality (operator ==) and HashCode', () {
      test('should be equal for same value and unit', () {
        const li1 = LuminousIntensity(50.0, LuminousIntensityUnit.candela);
        const li2 = LuminousIntensity(50.0, LuminousIntensityUnit.candela);
        expect(li1 == li2, isTrue);
        expect(li1.hashCode == li2.hashCode, isTrue);
      });

      test('should not be equal for different values or units', () {
        const li1 = LuminousIntensity(50.0, LuminousIntensityUnit.candela);
        const li2Diffval = LuminousIntensity(50.1, LuminousIntensityUnit.candela);
        const li3Diffunit = LuminousIntensity(50.0, LuminousIntensityUnit.millicandela);

        expect(li1 == li2Diffval, isFalse);
        expect(li1 == li3Diffunit, isFalse);

        expect(li1.hashCode == li2Diffval.hashCode, isFalse);
        expect(li1.hashCode == li3Diffunit.hashCode, isFalse);
      });

      test('equality is strict, 1.cd is not equal to 1000.mcd', () {
        final oneCd = 1.cd;
        final thousandMcd = 1000.mcd;
        expect(oneCd == thousandMcd, isFalse);
        expect(oneCd.compareTo(thousandMcd), 0);
      });
    });

    group('toString() (basic check)', () {
      test('should return formatted string with default non-breaking space', () {
        expect(75.5.cd.toString(), '75.5\u00A0cd');
        expect(120.mcd.toString(), '120.0\u00A0mcd');
      });
    });

    group('Round Trip Conversions (thorough)', () {
      const testValue = 123.456;

      for (final unit in LuminousIntensityUnit.values) {
        test('Round trip ${unit.symbol} <-> cd', () {
          testRoundTrip(
            unit,
            LuminousIntensityUnit.candela,
            testValue,
            tol: strictTolerance, // Factors are exact powers of 10
          );
        });
      }

      test('Round trip mcd <-> kcd', () {
        // Test with a value that doesn't become too small/large after conversion
        testRoundTrip(
          LuminousIntensityUnit.millicandela,
          LuminousIntensityUnit.kilocandela,
          500000.0,
          tol: strictTolerance,
        );
      });
    });

    group('Edge Cases', () {
      test('Conversion with zero value', () {
        final liZeroCd = 0.0.cd;
        for (final unit in LuminousIntensityUnit.values) {
          expect(liZeroCd.getValue(unit), 0.0, reason: '0 cd to ${unit.symbol} should be 0');
        }
      });

      test('Conversion with negative value', () {
        // Not physically meaningful, but the arithmetic must hold.
        final liNeg = (-500.0).mcd;
        expect(liNeg.inCandelas, closeTo(-0.5, strictTolerance));
        expect(liNeg.inKilocandelas, closeTo(-0.0005, strictTolerance));
      });
    });

    group('Arithmetic Operators for LuminousIntensity', () {
      final li100cd = 100.0.cd;
      final li200cd = 200.0.cd;
      final li50000mcd = 50000.0.mcd; // 50 cd

      // Operator +
      test('operator + combines luminous intensities', () {
        final sum1 = li200cd + li100cd;
        expect(sum1.value, closeTo(300.0, defaultTolerance));
        expect(sum1.unit, LuminousIntensityUnit.candela);

        final sum2 = li100cd + li50000mcd; // 100cd + 50cd = 150cd
        expect(sum2.value, closeTo(150.0, defaultTolerance));
        expect(sum2.unit, LuminousIntensityUnit.candela);

        final sum3 = li50000mcd + li100cd; // 50000mcd + 100000mcd = 150000mcd
        expect(sum3.value, closeTo(150000.0, defaultTolerance));
        expect(sum3.unit, LuminousIntensityUnit.millicandela);
      });

      // Operator -
      test('operator - subtracts luminous intensities', () {
        final diff1 = li200cd - li100cd;
        expect(diff1.value, closeTo(100.0, defaultTolerance));
        expect(diff1.unit, LuminousIntensityUnit.candela);

        final diff2 = li100cd - li50000mcd; // 100cd - 50cd = 50cd
        expect(diff2.value, closeTo(50.0, defaultTolerance));
        expect(diff2.unit, LuminousIntensityUnit.candela);
      });

      // Operator * (scalar)
      test('operator * scales luminous intensity by a scalar', () {
        final scaled1 = li100cd * 2.5;
        expect(scaled1.value, closeTo(250.0, defaultTolerance));
        expect(scaled1.unit, LuminousIntensityUnit.candela);
      });

      // Operator / (scalar)
      test('operator / scales luminous intensity by a scalar', () {
        final scaled1 = li200cd / 4.0;
        expect(scaled1.value, closeTo(50.0, defaultTolerance));
        expect(scaled1.unit, LuminousIntensityUnit.candela);

        expect(() => li100cd / 0.0, throwsArgumentError);
      });

      test('operator chaining preserves immutability', () {
        final initialIntensity = 50.cd;
        final liAdd = initialIntensity + 10000.mcd; // 50cd + 10cd = 60cd
        final liMul = liAdd * 2.0; // 60cd * 2 = 120cd
        final liSub = liMul - 0.01.kcd; // 120cd - 10cd = 110cd

        expect(initialIntensity.value, 50.0);
        expect(initialIntensity.unit, LuminousIntensityUnit.candela);

        expect(liAdd.value, closeTo(60.0, defaultTolerance));
        expect(liAdd.unit, LuminousIntensityUnit.candela);

        expect(liMul.value, closeTo(120.0, defaultTolerance));
        expect(liMul.unit, LuminousIntensityUnit.candela);

        final expectedLiSubVal = 120.0 - 0.01.kcd.getValue(LuminousIntensityUnit.candela);
        expect(liSub.value, closeTo(expectedLiSubVal, defaultTolerance));
        expect(liSub.unit, LuminousIntensityUnit.candela);
      });
    });
  });
}
