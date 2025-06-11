// ignore_for_file: prefer_int_literals : all constants are doubles.

import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  const tolerance = 1e-9; // Tolerance for double comparisons

  group('Length', () {
    // Helper for round trip tests
    void testRoundTrip(
      LengthUnit initialUnit,
      LengthUnit intermediateUnit,
      double initialValue, {
      double tolerance = 1e-9,
    }) {
      final l1 = Length(initialValue, initialUnit);
      final l2 = l1.convertTo(intermediateUnit);
      final l3 = l2.convertTo(initialUnit);
      expect(
        l3.value,
        closeTo(initialValue, tolerance),
        reason:
            '${initialUnit.symbol} -> ${intermediateUnit.symbol} -> ${initialUnit.symbol} failed for $initialValue',
      );
    }

    group('Constructors and Getters', () {
      test('should create Length from num extensions and retrieve values', () {
        final l1 = 100.0.m;
        expect(l1.value, 100.0);
        expect(l1.unit, LengthUnit.meter);
        expect(l1.inKm, closeTo(0.1, tolerance));

        final l2 = 5.0.ft;
        expect(l2.value, 5.0);
        expect(l2.unit, LengthUnit.foot);
        expect(l2.inInch, closeTo(60.0, tolerance));

        final l3 = 12.inch;
        expect(l3.inFt, closeTo(1.0, tolerance));
      });

      test('getValue should return correct value for same unit', () {
        const l = Length(25.0, LengthUnit.centimeter);
        expect(l.getValue(LengthUnit.centimeter), 25.0);
      });

      test('getValue for all units from Meter base', () {
        final l = 1000.0.m; // 1 km
        expect(l.inM, 1000.0);
        expect(l.inKm, closeTo(1.0, tolerance));
        expect(l.inCm, closeTo(100000.0, tolerance));
        expect(l.inMm, closeTo(1000000.0, tolerance));
        expect(l.inInch, closeTo(1000.0 / 0.0254, 1e-7));
        expect(l.inFt, closeTo(1000.0 / 0.3048, 1e-7));
        expect(l.inYd, closeTo(1000.0 / 0.9144, 1e-7));
        expect(l.inMi, closeTo(1000.0 / 1609.344, 1e-7));
        expect(l.inNmi, closeTo(1000.0 / 1852.0, 1e-7));
      });
    });

    group('Conversions', () {
      final oneMeter = 1.0.m;

      test('1 meter to various units', () {
        expect(oneMeter.inKm, closeTo(0.001, tolerance));
        expect(oneMeter.inCm, closeTo(100.0, tolerance));
        expect(oneMeter.inMm, closeTo(1000.0, tolerance));
        expect(oneMeter.inInch, closeTo(1 / 0.0254, 1e-7)); // 39.3700787...
        expect(oneMeter.inFt, closeTo(1 / 0.3048, 1e-7)); // 3.2808398...
        expect(oneMeter.inYd, closeTo(1 / 0.9144, 1e-7)); // 1.0936132...
      });

      final oneFoot = 1.0.ft;
      test('1 foot to various units', () {
        expect(oneFoot.inM, closeTo(0.3048, tolerance));
        expect(oneFoot.inInch, closeTo(12.0, tolerance));
        expect(oneFoot.inYd, closeTo(1.0 / 3.0, tolerance));
      });

      final oneMile = 1.0.mi;
      test('1 mile to various units', () {
        expect(oneMile.inM, closeTo(1609.344, tolerance));
        expect(oneMile.inFt, closeTo(5280.0, tolerance));
        expect(oneMile.inYd, closeTo(1760.0, tolerance));
        expect(oneMile.inKm, closeTo(1.609344, tolerance));
      });
    });

    group('convertTo method', () {
      test('should return new Length object with converted value and unit', () {
        final lMeters = 10.0.m;
        final lFeet = lMeters.convertTo(LengthUnit.foot);
        expect(lFeet.unit, LengthUnit.foot);
        expect(lFeet.value, closeTo(lMeters.inFt, tolerance));
        expect(lMeters.unit, LengthUnit.meter); // Original should be unchanged
      });

      test('convertTo same unit should return same instance (or equal if optimized)', () {
        final l1 = 10.0.m;
        final l2 = l1.convertTo(LengthUnit.meter);
        expect(identical(l1, l2), isTrue);
      });
    });

    group('Comparison (compareTo)', () {
      final lMeter = 1.0.m;
      final lSlightlyLessCm = 99.0.cm;
      final lSlightlyMoreCm = 101.0.cm;
      final lFoot = 3.0.ft; // 0.9144 meters

      test('should correctly compare lengths of different units', () {
        expect(lMeter.compareTo(lSlightlyLessCm), greaterThan(0));
        expect(lSlightlyLessCm.compareTo(lMeter), lessThan(0));
        expect(lMeter.compareTo(lSlightlyMoreCm), lessThan(0));
        expect(lMeter.compareTo(lFoot), greaterThan(0)); // 1m > 3ft
      });

      test('should return 0 for equal lengths in different units', () {
        final lCm = 100.0.cm;
        final lInches = (1.0 / 0.0254).inch; // 1 meter in inches
        expect(lMeter.compareTo(lCm), 0);
        expect(lCm.compareTo(lMeter), 0);
        expect(lMeter.compareTo(lInches), 0);
      });
    });

    group('Equality and HashCode', () {
      test('should be equal for same value and unit', () {
        const l1 = Length(10.0, LengthUnit.meter);
        const l2 = Length(10.0, LengthUnit.meter);
        expect(l1 == l2, isTrue);
        expect(l1.hashCode == l2.hashCode, isTrue);
      });

      test('should not be equal for different values or units', () {
        const l1 = Length(10.0, LengthUnit.meter);
        const l2 = Length(10.1, LengthUnit.meter);
        const l3 = Length(10.0, LengthUnit.foot);
        expect(l1 == l2, isFalse);
        expect(l1 == l3, isFalse);
        expect(l1.hashCode == l2.hashCode, isFalse);
        expect(l1.hashCode == l3.hashCode, isFalse);
      });
    });

    group('toString()', () {
      test('should return formatted string', () {
        expect(10.5.m.toString(), '10.5 m');
        expect(12.0.inch.toString(), '12.0 in');
        expect(1.6.km.toString(), '1.6 km');
      });
    });

    group('Round Trip Conversions', () {
      const testValue = 789.123;
      const highTolerance = 1e-7; // For chains of conversions

      for (final unit in LengthUnit.values) {
        test('Round trip ${unit.symbol} <-> m', () {
          testRoundTrip(
            unit,
            LengthUnit.meter,
            testValue,
            tolerance: (unit == LengthUnit.meter) ? tolerance : highTolerance,
          );
        });
      }

      test('Round trip ft <-> in', () {
        testRoundTrip(LengthUnit.foot, LengthUnit.inch, testValue);
      });
      test('Round trip yd <-> mi', () {
        testRoundTrip(LengthUnit.yard, LengthUnit.mile, 5000.0, tolerance: highTolerance);
      });
      test('Round trip cm <-> km', () {
        testRoundTrip(
          LengthUnit.centimeter,
          LengthUnit.kilometer,
          250000.0,
          tolerance: highTolerance,
        );
      });
    });

    group('Edge Cases', () {
      test('Conversion with zero value', () {
        final lZero = 0.0.m;
        for (final unit in LengthUnit.values) {
          expect(lZero.getValue(unit), 0.0, reason: '0 m to ${unit.symbol} should be 0');
        }
      });
    });

    group('Arithmetic Operators for Length', () {
      final l1Meter = 1.0.m;
      final l2Meters = 2.0.m;
      final l50Cm = 50.cm; // 0.5 meters

      // Operator +
      test('operator + combines lengths', () {
        final sum1 = l2Meters + l1Meter;
        expect(sum1.value, closeTo(3.0, tolerance));
        expect(sum1.unit, LengthUnit.meter);

        final sum2 = l1Meter + l50Cm; // 1m + 0.5m = 1.5m
        expect(sum2.value, closeTo(1.5, tolerance));
        expect(sum2.unit, LengthUnit.meter);

        final sum3 = l50Cm + l1Meter; // 50cm + 100cm = 150cm
        expect(sum3.value, closeTo(150.0, tolerance));
        expect(sum3.unit, LengthUnit.centimeter);
      });

      // Operator -
      test('operator - subtracts lengths', () {
        final diff1 = l2Meters - l1Meter;
        expect(diff1.value, closeTo(1.0, tolerance));
        expect(diff1.unit, LengthUnit.meter);

        final diff2 = l1Meter - l50Cm; // 1m - 0.5m = 0.5m
        expect(diff2.value, closeTo(0.5, tolerance));
        expect(diff2.unit, LengthUnit.meter);

        final diff3 = l2Meters - l50Cm.convertTo(LengthUnit.meter); // 2m - 0.5m = 1.5m
        expect(diff3.value, closeTo(1.5, tolerance));
        expect(diff3.unit, LengthUnit.meter);
      });

      // Operator * (scalar)
      test('operator * scales length by a scalar', () {
        final scaled = l2Meters * 3.0;
        expect(scaled.value, closeTo(6.0, tolerance));
        expect(scaled.unit, LengthUnit.meter);

        final scaledCm = l50Cm * 2.5;
        expect(scaledCm.value, closeTo(125.0, tolerance));
        expect(scaledCm.unit, LengthUnit.centimeter);
      });

      // Operator / (scalar)
      test('operator / scales length by a scalar', () {
        final scaled = l2Meters / 2.0;
        expect(scaled.value, closeTo(1.0, tolerance));
        expect(scaled.unit, LengthUnit.meter);

        expect(() => l1Meter / 0.0, throwsArgumentError);
      });

      test('operator chaining preserves immutability', () {
        final initialLength = 10.m;
        final l1 = initialLength + 5.m; // 15m
        final l2 = l1 * 2.0; // 30m
        final l3 = l2 - 100.cm; // 30m - 1m = 29m

        expect(initialLength.value, 10.0); // Original unchanged
        expect(l1.value, closeTo(15.0, tolerance));
        expect(l2.value, closeTo(30.0, tolerance));
        expect(l3.value, closeTo(29.0, tolerance));
        expect(l3.unit, LengthUnit.meter);
      });
    });
  });
}
