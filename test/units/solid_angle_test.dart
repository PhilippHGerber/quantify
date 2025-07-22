import 'dart:math' as math;

import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('SolidAngle', () {
    const tolerance = 1e-12;

    // Helper for round trip tests
    void testRoundTrip(
      SolidAngleUnit initialUnit,
      SolidAngleUnit intermediateUnit,
      double initialValue, {
      double tol = tolerance,
    }) {
      final sa1 = SolidAngle(initialValue, initialUnit);
      final sa2 = sa1.convertTo(intermediateUnit);
      final sa3 = sa2.convertTo(initialUnit);
      expect(
        sa3.value,
        closeTo(initialValue, tol),
        reason:
            '${initialUnit.symbol} -> ${intermediateUnit.symbol} -> ${initialUnit.symbol} failed for $initialValue',
      );
    }

    group('Constructors and Getters', () {
      test('should create from num extensions and retrieve values', () {
        final solidAngle = (2 * math.pi).sr;
        expect(solidAngle.value, 2 * math.pi);
        expect(solidAngle.unit, SolidAngleUnit.steradian);
        expect(solidAngle.inSpat, closeTo(0.5, tolerance));
      });
    });

    group('Conversions', () {
      test('Full sphere (spat) to other units', () {
        final fullSphere = 1.0.sp;
        expect(fullSphere.inSteradians, closeTo(4 * math.pi, tolerance));
        // Full sphere is approx 41252.96 deg²
        expect(fullSphere.inSquareDegrees, closeTo(41252.96, 1e-2));
      });

      test('Steradian to Square Degrees', () {
        final oneSteradian = 1.0.sr;
        // 1 sr = (180/π)² deg²
        expect(
          oneSteradian.inSquareDegrees,
          closeTo(math.pow(180 / math.pi, 2), tolerance),
        );
      });

      test('Square Degree to Steradians', () {
        final oneSqDeg = 1.0.deg2;
        expect(
          oneSqDeg.inSteradians,
          closeTo(math.pow(math.pi / 180, 2), tolerance),
        );
      });
    });

    group('Comparison', () {
      test('should correctly compare different units', () {
        final hemisphere = (2 * math.pi).sr; // ~6.283 sr (Half a sphere)
        final slightlyLess = 20000.deg2; // ~6.092 sr
        final slightlyMore = 21000.deg2; // ~6.397 sr

        // Test GREATER THAN
        expect(hemisphere.compareTo(slightlyLess), greaterThan(0));

        // Test LESS THAN
        expect(hemisphere.compareTo(slightlyMore), lessThan(0));

        // Test EQUAL
        expect(hemisphere.compareTo(const SolidAngle(2 * math.pi, SolidAngleUnit.steradian)), 0);
      });
    });

    group('Arithmetic', () {
      test('should perform addition and subtraction', () {
        final sum = math.pi.sr + 10000.deg2;
        final expected = math.pi + (10000 * math.pow(math.pi / 180, 2));
        expect(sum.inSteradians, closeTo(expected, tolerance));
        expect(sum.unit, SolidAngleUnit.steradian);
      });

      test('should perform scalar multiplication and division', () {
        final angle = math.pi.sr;
        expect((angle * 2.0).inSteradians, closeTo(2 * math.pi, tolerance));
        expect((angle / 4.0).inSteradians, closeTo(math.pi / 4, tolerance));
        expect(() => angle / 0, throwsArgumentError);
      });
    });

    group('Round Trip Conversions', () {
      for (final unit in SolidAngleUnit.values) {
        test('Round trip ${unit.symbol} <-> sr', () {
          testRoundTrip(unit, SolidAngleUnit.steradian, 0.5);
        });
      }
    });

    group('Practical Examples', () {
      test('Field of view calculation', () {
        // A camera lens with a 90° x 90° field of view
        // We will approximate this as a cone with a 45° half-angle for this example.
        // The solid angle of a cone is Ω = 2π * (1 - cos(θ)), where θ is the half-angle.
        final halfAngle = 45.0.degrees.inRadians;
        final solidAngleCone = 2 * math.pi * (1 - math.cos(halfAngle));

        final fov = SolidAngle(solidAngleCone, SolidAngleUnit.steradian);

        // First, verify the steradian value is as expected (~1.84 sr)
        expect(fov.inSteradians, closeTo(1.8404, 1e-4));

        // Now, test the conversion of that calculated value to square degrees.
        // The previous expected value of 6048 was incorrect. The actual value is ~6041.356.
        expect(fov.inSquareDegrees, closeTo(6041.356, 1e-3));
      });
    });
  });
}
