// ignore_for_file: prefer_int_literals // All constants are doubles for precision.

import 'package:quantify/quantify.dart'; // Assuming Current and CurrentUnit are exported
import 'package:test/test.dart';

void main() {
  group('Current', () {
    const strictTolerance = 1e-12; // For "exact" conversions or small scales
    const defaultTolerance = 1e-9; // General purpose
    const looseTolerance = 1e-6; // For conversions over many orders of magnitude

    // Helper for round trip tests
    void testRoundTrip(
      CurrentUnit initialUnit,
      CurrentUnit intermediateUnit,
      double initialValue, {
      double tol = defaultTolerance,
    }) {
      final c1 = Current(initialValue, initialUnit);
      final c2 = c1.convertTo(intermediateUnit);
      final c3 = c2.convertTo(initialUnit);
      expect(
        c3.value,
        closeTo(initialValue, tol),
        reason:
            '${initialUnit.symbol} -> ${intermediateUnit.symbol} -> ${initialUnit.symbol} failed for $initialValue. Expected $initialValue, got ${c3.value}',
      );
    }

    group('Constructors and Getters (from num extensions)', () {
      test('should create Current from num extensions and retrieve values correctly', () {
        final curA = 1.5.A; // Using symbol extension
        expect(curA.value, 1.5);
        expect(curA.unit, CurrentUnit.ampere);
        expect(curA.inMilliamperes, closeTo(1500.0, strictTolerance));
        expect(curA.asMilliamperes.value, closeTo(1500.0, strictTolerance));
        expect(curA.asMilliamperes.unit, CurrentUnit.milliampere);

        final curMA = 250.0.milliamperes; // Using alias
        expect(curMA.value, 250.0);
        expect(curMA.unit, CurrentUnit.milliampere);
        expect(curMA.inAmperes, closeTo(0.25, strictTolerance));

        final curUA = 123.0.uA;
        expect(curUA.value, 123.0);
        expect(curUA.unit, CurrentUnit.microampere);
        expect(curUA.inAmperes, closeTo(0.000123, strictTolerance));
        expect(curUA.inNanoamperes, closeTo(123000.0, defaultTolerance));
      });

      test('getValue should return correct value for same unit', () {
        const current = Current(0.01, CurrentUnit.ampere);
        expect(current.getValue(CurrentUnit.ampere), 0.01);
      });
    });

    group('Conversions between various current units', () {
      final oneAmpere = 1.0.A;
      test('1 Ampere to other units', () {
        expect(oneAmpere.inKiloamperes, closeTo(0.001, strictTolerance));
        expect(oneAmpere.inMilliamperes, closeTo(1000.0, strictTolerance));
        expect(oneAmpere.inMicroamperes, closeTo(1.0e6, strictTolerance));
        expect(oneAmpere.inNanoamperes, closeTo(1.0e9, looseTolerance)); // Larger scale
      });

      final oneKiloampere = 1.0.kA;
      test('1 Kiloampere to amperes', () {
        expect(oneKiloampere.inAmperes, closeTo(1000.0, strictTolerance));
      });

      final oneMilliampere = 1.0.mA;
      test('1 Milliampere to microamperes and amperes', () {
        expect(oneMilliampere.inMicroamperes, closeTo(1000.0, strictTolerance));
        expect(oneMilliampere.inAmperes, closeTo(0.001, strictTolerance));
      });

      final fiftyMicroamperes = 50.0.uA;
      test('50 Microamperes to nanoamperes and milliamperes', () {
        expect(fiftyMicroamperes.inNanoamperes, closeTo(50000.0, defaultTolerance));
        expect(fiftyMicroamperes.inMilliamperes, closeTo(0.05, strictTolerance));
      });
    });

    group('convertTo method', () {
      test('should return new Current object with converted value and unit', () {
        final curMA = 1250.0.mA;
        final curA = curMA.convertTo(CurrentUnit.ampere);

        expect(curA.unit, CurrentUnit.ampere);
        expect(curA.value, closeTo(1.25, strictTolerance));
        expect(curMA.unit, CurrentUnit.milliampere); // Original should be unchanged
        expect(curMA.value, 1250.0);
      });

      test('convertTo same unit should return same instance (immutable optimization)', () {
        final c1 = 0.1.A;
        final c2 = c1.convertTo(CurrentUnit.ampere);
        expect(identical(c1, c2), isTrue);
      });
    });

    group('Comparison (compareTo)', () {
      final c1A = 1.0.A;
      final c1000mA = 1000.0.mA;
      final c999mA = 999.0.mA;
      final c0_01kA = 0.01.kA; // 10 A
      final c0_0001kA = 0.0001.kA; // 0.1 A

      test('should correctly compare currents of different units', () {
        expect(c1A.compareTo(c999mA), greaterThan(0)); // 1A > 999mA
        expect(c999mA.compareTo(c1A), lessThan(0)); // 999mA < 1A
        expect(c1A.compareTo(c1000mA), 0); // 1A == 1000mA

        expect(c1A.compareTo(c0_01kA), lessThan(0)); // 1A < 10A
        expect(c1A.compareTo(c0_0001kA), greaterThan(0)); // 1A > 0.1A
      });

      test('should return 0 for equal currents in different units', () {
        final cInUA = 1000000.0.uA; // 1 A in microamperes
        expect(c1A.compareTo(cInUA), 0);
      });
    });

    group('Equality (operator ==) and HashCode', () {
      test('should be equal for same value and unit', () {
        const c1 = Current(0.05, CurrentUnit.ampere);
        const c2 = Current(0.05, CurrentUnit.ampere);
        expect(c1 == c2, isTrue);
        expect(c1.hashCode == c2.hashCode, isTrue);
      });

      test('should not be equal for different values or units', () {
        const c1 = Current(0.05, CurrentUnit.ampere);
        const c2Diffval = Current(0.051, CurrentUnit.ampere);
        const c3Diffunit = Current(0.05, CurrentUnit.milliampere);

        expect(c1 == c2Diffval, isFalse);
        expect(c1 == c3Diffunit, isFalse);

        expect(c1.hashCode == c2Diffval.hashCode, isFalse);
        expect(c1.hashCode == c3Diffunit.hashCode, isFalse);
      });

      test('equality is strict, 1.A is not equal to 1000.mA', () {
        final oneAmp = 1.A;
        final thousandMilliamp = 1000.mA;
        expect(oneAmp == thousandMilliamp, isFalse);
        expect(oneAmp.compareTo(thousandMilliamp), 0);
      });
    });

    group('toString() (basic check, formatting is in Quantity class)', () {
      test('should return formatted string with default non-breaking space', () {
        expect(2.5.A.toString(), '2.5\u00A0A');
        expect(15.mA.toString(), '15.0\u00A0mA');
        expect(123.microamperes.toString(), '123.0\u00A0µA'); // Note µ symbol
      });
    });

    group('Round Trip Conversions (thorough)', () {
      const testValue = 0.0123456789;

      for (final unit in CurrentUnit.values) {
        test('Round trip ${unit.symbol} <-> A', () {
          testRoundTrip(
            unit,
            CurrentUnit.ampere,
            testValue,
            tol: (unit == CurrentUnit.ampere ||
                    unit == CurrentUnit.milliampere ||
                    unit == CurrentUnit.kiloampere)
                ? strictTolerance
                : looseTolerance,
          );
        });
      }

      test('Round trip mA <-> µA', () {
        testRoundTrip(CurrentUnit.milliampere, CurrentUnit.microampere, 0.5, tol: strictTolerance);
      });
      test('Round trip µA <-> nA', () {
        testRoundTrip(CurrentUnit.microampere, CurrentUnit.nanoampere, 0.005, tol: strictTolerance);
      });
      test('Round trip A <-> kA', () {
        testRoundTrip(CurrentUnit.ampere, CurrentUnit.kiloampere, 2500.0, tol: strictTolerance);
      });
    });

    group('Edge Cases', () {
      test('Conversion with zero value', () {
        final cZeroA = 0.0.A;
        for (final unit in CurrentUnit.values) {
          expect(cZeroA.getValue(unit), 0.0, reason: '0 A to ${unit.symbol} should be 0');
        }
      });

      test('Conversion with very small and large values', () {
        final verySmall = 1.0e-10.A; // picoampere range if unit existed
        expect(verySmall.inNanoamperes, closeTo(0.1, strictTolerance));

        final veryLarge = 1.0e4.A; // 10 kA
        expect(veryLarge.inKiloamperes, closeTo(10.0, strictTolerance));
      });
    });

    group('Arithmetic Operators for Current', () {
      final c1A = 1.0.A;
      final c2A = 2.0.A;
      final c500mA = 500.mA; // 0.5 A
      final c100uA = 100.uA; // 0.0001 A

      // Operator +
      test('operator + combines currents, result in unit of left operand', () {
        final sum1 = c2A + c1A;
        expect(sum1.value, closeTo(3.0, defaultTolerance));
        expect(sum1.unit, CurrentUnit.ampere);

        final sum2 = c1A + c500mA; // 1A + 0.5A = 1.5A
        expect(sum2.value, closeTo(1.5, defaultTolerance));
        expect(sum2.unit, CurrentUnit.ampere);

        final sum3 = c500mA + c1A; // 500mA + 1000mA = 1500mA
        expect(sum3.value, closeTo(1500.0, defaultTolerance));
        expect(sum3.unit, CurrentUnit.milliampere);

        final sum4 = c1A + c100uA; // 1A + 0.0001A
        expect(sum4.value, closeTo(1.0 + 0.0001, strictTolerance));
        expect(sum4.unit, CurrentUnit.ampere);
      });

      // Operator -
      test('operator - subtracts currents, result in unit of left operand', () {
        final diff1 = c2A - c1A;
        expect(diff1.value, closeTo(1.0, defaultTolerance));
        expect(diff1.unit, CurrentUnit.ampere);

        final diff2 = c1A - c500mA; // 1A - 0.5A = 0.5A
        expect(diff2.value, closeTo(0.5, defaultTolerance));
        expect(diff2.unit, CurrentUnit.ampere);

        final diff3 = c1A - c100uA; // 1A - 0.0001A
        expect(diff3.value, closeTo(1.0 - 0.0001, strictTolerance));
        expect(diff3.unit, CurrentUnit.ampere);
      });

      // Operator * (scalar)
      test('operator * scales current by a scalar', () {
        final scaled1 = c2A * 1.5;
        expect(scaled1.value, closeTo(3.0, defaultTolerance));
        expect(scaled1.unit, CurrentUnit.ampere);

        final scaled2 = c500mA * 0.2;
        expect(scaled2.value, closeTo(100.0, defaultTolerance));
        expect(scaled2.unit, CurrentUnit.milliampere);
      });

      // Operator / (scalar)
      test('operator / scales current by a scalar', () {
        final scaled1 = c2A / 5.0;
        expect(scaled1.value, closeTo(0.4, defaultTolerance));
        expect(scaled1.unit, CurrentUnit.ampere);

        final scaled2 = c1A / 0.02;
        expect(scaled2.value, closeTo(50.0, defaultTolerance));
        expect(scaled2.unit, CurrentUnit.ampere);

        expect(() => c1A / 0.0, throwsArgumentError, reason: 'Division by zero should throw');
      });

      test('operator chaining preserves immutability', () {
        final initialCurrent = 0.5.A;
        final cAdd = initialCurrent + 200.mA; // 0.5A + 0.2A = 0.7A
        final cMul = cAdd * 3.0; // 0.7A * 3 = 2.1A
        final cSub = cMul - 10000.uA; // 2.1A - 0.01A = 2.09A

        expect(initialCurrent.value, 0.5); // Original unchanged
        expect(initialCurrent.unit, CurrentUnit.ampere);

        expect(cAdd.value, closeTo(0.7, defaultTolerance));
        expect(cAdd.unit, CurrentUnit.ampere);

        expect(cMul.value, closeTo(2.1, defaultTolerance));
        expect(cMul.unit, CurrentUnit.ampere);

        final expectedCSubVal = 2.1 - 10000.0.uA.getValue(CurrentUnit.ampere);
        expect(cSub.value, closeTo(expectedCSubVal, strictTolerance));
        expect(cSub.unit, CurrentUnit.ampere);
      });
    });

    group('CGS and Historical Units', () {
      const tolerance = 1e-12;

      test('abampere (biot) conversions', () {
        // Use the new explicit extension `abA`
        final oneAbampere = 1.0.abA;
        expect(oneAbampere.inAmperes, closeTo(10.0, tolerance));

        // Test creation with `Bi` alias
        final oneBiot = 1.0.bi;
        expect(oneBiot.compareTo(oneAbampere), 0);

        // Test conversion from SI
        final fiftyAmperes = 50.0.A;
        expect(fiftyAmperes.inAbamperes, closeTo(5.0, tolerance));
      });

      test('statampere conversions', () {
        // Use the new explicit extension `statA`
        final oneAmpere = 1.0.A;
        const expectedStatA = 1.0 / 3.3356409519815204e-10;
        expect(oneAmpere.inStatamperes, closeTo(expectedStatA, 1e-3));

        // Test creation and conversion back
        final oneStatampere = 1.0.statA;
        expect(oneStatampere.inAmperes, closeTo(3.3356409519815204e-10, tolerance));
      });

      test('comparison between CGS and SI units', () {
        final oneAbampere = 1.0.abA; // 10 A
        final oneAmpere = 1.0.A;
        final oneStatampere = 1.0.statA; // tiny current

        expect(oneAbampere.compareTo(oneAmpere), greaterThan(0));
        expect(oneAmpere.compareTo(oneStatampere), greaterThan(0));
      });

      test('round trip conversions for CGS units', () {
        const testValue = 123.456;

        // Test round trip via amperes
        final originalAbA = testValue.abA;
        final roundTripAbA = originalAbA.asAmperes.asAbamperes;
        expect(roundTripAbA.value, closeTo(testValue, tolerance));

        final originalStatA = testValue.statA;
        final roundTripStatA = originalStatA.asAmperes.asStatamperes;
        expect(
          roundTripStatA.value,
          closeTo(testValue, 1e-3),
        ); // Lower precision due to large factor
      });
    });
  });
}
