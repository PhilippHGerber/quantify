// test/units/angle_test.dart
import 'dart:math' as math;

import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('Angle', () {
    const tolerance = 1e-12; // High precision for angular conversions

    // Helper for round trip tests
    void testRoundTrip(
      AngleUnit initialUnit,
      AngleUnit intermediateUnit,
      double initialValue,
    ) {
      final a1 = Angle(initialValue, initialUnit);
      final a2 = a1.convertTo(intermediateUnit);
      final a3 = a2.convertTo(initialUnit);
      expect(
        a3.value,
        closeTo(initialValue, tolerance),
        reason:
            '${initialUnit.symbol} -> ${intermediateUnit.symbol} -> ${initialUnit.symbol} failed for $initialValue',
      );
    }

    group('Constructors and Getters', () {
      test('should create Angle from num extensions and retrieve values', () {
        final angleDeg = 90.0.degrees;
        expect(angleDeg.value, 90.0);
        expect(angleDeg.unit, AngleUnit.degree);
        expect(angleDeg.inRadians, closeTo(math.pi / 2, tolerance));

        final angleRad = math.pi.radians;
        expect(angleRad.value, math.pi);
        expect(angleRad.unit, AngleUnit.radian);
        expect(angleRad.inDegrees, closeTo(180.0, tolerance));
      });
    });

    group('Conversions', () {
      test('Degree to Radian and Gradian', () {
        final angle = 180.0.degrees;
        expect(angle.inRadians, closeTo(math.pi, tolerance));
        expect(angle.inGradians, closeTo(200.0, tolerance));
        expect(angle.inRevolutions, closeTo(0.5, tolerance));
      });

      test('Radian to Degree and Revolution', () {
        final angle = (2 * math.pi).radians;
        expect(angle.inDegrees, closeTo(360.0, tolerance));
        expect(angle.inRevolutions, closeTo(1.0, tolerance));
      });

      test('Gradian to Degree', () {
        final angle = 100.0.gradians;
        expect(angle.inDegrees, closeTo(90.0, tolerance));
      });

      test('Revolution to other units', () {
        final angle = 0.25.rev; // 90 degrees
        expect(angle.inDegrees, closeTo(90.0, tolerance));
        expect(angle.inRadians, closeTo(math.pi / 2, tolerance));
      });

      test('Arcminute and Arcsecond conversions', () {
        final oneDegree = 1.0.degrees;
        expect(oneDegree.inArcminutes, closeTo(60.0, tolerance));
        expect(oneDegree.inArcseconds, closeTo(3600.0, tolerance));

        final oneArcminute = 1.0.arcminutes;
        expect(oneArcminute.inDegrees, closeTo(1 / 60, tolerance));
      });

      test('Milliradian conversions', () {
        final oneRadian = 1.0.radians;
        expect(oneRadian.inMilliradians, closeTo(1000.0, tolerance));
        final tenMrad = 10.mrad;
        expect(tenMrad.inRadians, closeTo(0.01, tolerance));
      });
    });

    group('convertTo', () {
      test('convertTo same unit returns identical instance', () {
        final a = 90.0.degrees;
        expect(identical(a, a.convertTo(AngleUnit.degree)), isTrue);
      });

      test('convertTo different unit returns correct value and unit', () {
        final a = 1.0.revolutions;
        final converted = a.convertTo(AngleUnit.degree);
        expect(converted.unit, AngleUnit.degree);
        expect(converted.value, closeTo(360.0, tolerance));
      });
    });

    group('Comparison (compareTo)', () {
      test('should correctly compare angles of different units', () {
        final a1 = 90.0.degrees;
        final a2 = (math.pi / 2).radians;
        final a3 = 100.0.gradians;
        final a4 = 89.0.degrees;

        // Diese Vergleiche werden nun alle korrekt sein.
        expect(
          a1.compareTo(a3),
          0,
          reason: '90 degrees should be exactly equal to 100 gradians',
        );

        // Dieser Vergleich kann immer noch eine winzige Abweichung haben,
        // da math.pi/2 selbst eine Annäherung ist.
        // Es ist besser, ihn so zu lassen oder einen closeTo Vergleich zu machen.
        // compareTo(a2) sollte aber auch 0 sein, da die internen Faktoren nun konsistenter sind.
        expect(a1.compareTo(a2), 0);

        expect(a1.compareTo(a4), greaterThan(0));
        expect(a4.compareTo(a1), lessThan(0));
      });
    });

    group('Equality and HashCode', () {
      test('should be equal for same value and unit', () {
        const a1 = Angle(45, AngleUnit.degree);
        const a2 = Angle(45, AngleUnit.degree);
        expect(a1 == a2, isTrue);
        expect(a1.hashCode == a2.hashCode, isTrue);
      });

      test('should not be equal for different value or unit', () {
        final a1 = 45.0.degrees;
        final a2 = (math.pi / 4).radians;
        expect(a1 == a2, isFalse); // Different units
        expect(a1.compareTo(a2), 0); // Same magnitude
      });
    });

    group('Arithmetic Operators', () {
      test('should perform addition and subtraction correctly', () {
        final result = 90.degrees + (math.pi / 4).radians; // 90 + 45 = 135
        expect(result.inDegrees, closeTo(135.0, tolerance));
        expect(result.unit, AngleUnit.degree); // Left operand's unit

        final result2 = result - 45.degrees;
        expect(result2.inDegrees, closeTo(90.0, tolerance));
      });

      test('should perform multiplication and division correctly', () {
        final angle = 30.0.degrees;
        expect((angle * 3.0).inDegrees, closeTo(90.0, tolerance));
        expect((angle / 2.0).inDegrees, closeTo(15.0, tolerance));
        expect(() => angle / 0.0, throwsArgumentError);
      });
    });

    group('Round Trip Conversions', () {
      for (final unit in AngleUnit.values) {
        test('Round trip ${unit.symbol} <-> rad', () {
          testRoundTrip(unit, AngleUnit.radian, 123.456);
        });
      }
      test('Round trip deg <-> grad', () {
        testRoundTrip(AngleUnit.degree, AngleUnit.gradian, 90);
      });
    });

    group('Practical Examples', () {
      test('Trigonometry using dart:math', () {
        final angle = 30.0.degrees;
        // dart:math functions require radians
        final sinValue = math.sin(angle.inRadians);
        expect(sinValue, closeTo(0.5, tolerance));

        final angle45 = (math.pi / 4).radians;
        final cosValue = math.cos(angle45.inRadians);
        final sinValue45 = math.sin(angle45.inRadians);
        expect(cosValue, closeTo(sinValue45, tolerance));
      });

      test('Geometry: sum of angles in a triangle', () {
        final a1 = 60.degrees;
        final a2 = 60.degrees;
        final a3 = 60.degrees;
        final sum = a1 + a2 + a3;
        expect(sum.inDegrees, closeTo(180.0, tolerance));
        expect(sum.inRadians, closeTo(math.pi, tolerance));
      });

      test('Rotational mechanics', () {
        // A wheel turns 3.5 revolutions
        final rotation = 3.5.revolutions;
        expect(rotation.inDegrees, closeTo(3.5 * 360, tolerance));
        // Find angle in a standard coordinate system (modulo 360)
        final finalAngle = rotation.inDegrees % 360;
        expect(finalAngle, closeTo(180.0, tolerance));
      });
    });

    group('Comprehensive Angle Extension Coverage', () {
      test('All angle unit creation and value getters', () {
        // degrees
        final deg = 180.degrees;
        expect(deg.inDegrees, closeTo(180.0, tolerance));
        expect(deg.asDegrees.unit, AngleUnit.degree);

        // arcminutes
        final arcmin = 60.arcminutes;
        expect(arcmin.inArcminutes, closeTo(60.0, tolerance));
        expect(arcmin.asArcminutes.unit, AngleUnit.arcminute);

        // arcseconds
        final arcsec = 3600.arcseconds;
        expect(arcsec.inArcseconds, closeTo(3600.0, tolerance));
        expect(arcsec.asArcseconds.unit, AngleUnit.arcsecond);

        // gradians
        final grad = 200.gradians;
        expect(grad.inGradians, closeTo(200.0, tolerance));
        expect(grad.asGradians.unit, AngleUnit.gradian);
      });

      test('asRadians returns correct object', () {
        final a = 180.0.degrees;
        final asRad = a.asRadians;
        expect(asRad.unit, AngleUnit.radian);
        expect(asRad.value, closeTo(math.pi, tolerance));
      });

      test('asRevolutions returns correct object', () {
        final a = 360.0.degrees;
        final asRev = a.asRevolutions;
        expect(asRev.unit, AngleUnit.revolution);
        expect(asRev.value, closeTo(1.0, tolerance));
      });

      test('asMilliradians returns correct object', () {
        final a = 1.0.radians;
        final asMrad = a.asMilliradians;
        expect(asMrad.unit, AngleUnit.milliradian);
        expect(asMrad.value, closeTo(1000.0, tolerance));
      });

      test('grad creation alias matches gradians', () {
        final fromGrad = 200.0.grad;
        final fromGradians = 200.0.gradians;
        expect(fromGrad.unit, AngleUnit.gradian);
        expect(fromGrad.value, fromGradians.value);
      });

      test('milliradians creation getter matches mrad alias', () {
        final fromMilliradians = 500.0.milliradians;
        final fromMrad = 500.0.mrad;
        expect(fromMilliradians.unit, AngleUnit.milliradian);
        expect(fromMilliradians.value, fromMrad.value);
      });
    });
  });
}
