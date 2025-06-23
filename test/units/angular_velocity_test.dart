// test/units/angular_velocity_test.dart
import 'dart:math' as math;

import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('AngularVelocity', () {
    const tolerance = 1e-12;

    group('Constructors and Getters', () {
      test('should create from num extensions and retrieve values', () {
        final speed = 3000.0.rpm;
        expect(speed.value, 3000.0);
        expect(speed.unit, AngularVelocityUnit.revolutionPerMinute);
        const expectedRadPerSec = 3000.0 * (2 * math.pi) / 60.0;
        expect(speed.inRadiansPerSecond, closeTo(expectedRadPerSec, tolerance));
      });
    });

    group('Conversions', () {
      test('RPM to RPS and Rad/s', () {
        final speed = 60.0.rpm;
        expect(speed.inRps, closeTo(1.0, tolerance));
        expect(speed.inRadiansPerSecond, closeTo(2 * math.pi, tolerance));
      });

      test('Rad/s to others', () {
        final speed = math.pi.radiansPerSecond; // 180°/s or 0.5 rps
        expect(speed.inDegreesPerSecond, closeTo(180.0, tolerance));
        expect(speed.inRps, closeTo(0.5, tolerance));
        expect(speed.inRpm, closeTo(30.0, tolerance));
      });
    });

    group('Comparison', () {
      test('should correctly compare different units', () {
        final s1 = 60.0.rpm;
        final s2 = 1.0.rps;
        final s3 = 59.0.rpm;

        expect(s1.compareTo(s2), 0);
        expect(s1.compareTo(s3), greaterThan(0));
        expect(s3.compareTo(s1), lessThan(0));
      });
    });

    group('Arithmetic', () {
      test('should perform addition and subtraction', () {
        final sum = 10.rps + 60.rpm; // 10 rps + 1 rps = 11 rps
        expect(sum.inRps, closeTo(11.0, tolerance));
        expect(sum.unit, AngularVelocityUnit.revolutionPerSecond);
      });

      test('should perform scalar multiplication and division', () {
        final speed = 100.0.rpm;
        expect((speed * 2.0).inRpm, closeTo(200.0, tolerance));
        expect((speed / 4.0).inRpm, closeTo(25.0, tolerance));
      });
    });

    group('Dimensional Analysis (Interaction with other Quantities)', () {
      test('AngularVelocity * Time = Angle', () {
        final speed = 3000.0.rpm;
        final duration = 2.0.seconds;
        final totalAngle = speed.totalAngleOver(duration);

        expect(totalAngle, isA<Angle>());
        // 3000 rev/min = 50 rev/sec. Over 2 seconds -> 100 revolutions.
        expect(totalAngle.inRevolutions, closeTo(100.0, tolerance));
        expect(totalAngle.inDegrees, closeTo(100.0 * 360, tolerance));
      });

      test('A full rotation check', () {
        final speed = 360.0.degreesPerSecond;
        final duration = 1.0.seconds;
        final angle = speed.totalAngleOver(duration);

        expect(angle.inRevolutions, closeTo(1.0, tolerance));
      });
    });

    group('Practical Examples', () {
      test('Car Engine', () {
        // An engine idles at 800 rpm and has a redline at 7000 rpm.
        final idleSpeed = 800.rpm;
        final redline = 7000.rpm;

        expect(idleSpeed.compareTo(redline), lessThan(0));
        expect(redline.inRps, closeTo(7000.0 / 60.0, tolerance));

        // How many full rotations in 100 milliseconds at redline?
        final angleTurned = redline.totalAngleOver(100.milliseconds);
        expect(angleTurned.inRevolutions, closeTo(7000.0 / 60.0 * 0.1, tolerance));
      });
    });
  });
}
