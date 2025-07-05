import 'package:quantify/acceleration.dart';
import 'package:quantify/speed.dart';
import 'package:quantify/time.dart';
import 'package:test/test.dart';

void main() {
  group('Acceleration', () {
    const tolerance = 1e-12;

    group('Constructors and Getters', () {
      test('should create from num extensions and retrieve values', () {
        final gravity = 1.gravity;
        expect(gravity.value, 1.0);
        expect(gravity.unit, AccelerationUnit.standardGravity);
        expect(gravity.inMetersPerSecondSquared, closeTo(9.80665, tolerance));
      });
    });

    group('Conversions', () {
      test('Standard Gravity to m/s²', () {
        final gravity = 2.gravity;
        expect(gravity.inMetersPerSecondSquared, closeTo(2 * 9.80665, tolerance));
      });

      test('m/s² to other units', () {
        final acc = 9.80665.mpsSquared;
        expect(acc.inStandardGravity, closeTo(1.0, tolerance));
        expect(acc.inFeetPerSecondSquared, closeTo(32.1740, 1e-4));
      });

      test('Automotive performance units', () {
        // A car accelerating at 10 (km/h)/s
        final carAcc = 10.kmhPerS;
        const expectedMpss = 10 * 1000 / 3600; // ~2.77 m/s²
        expect(carAcc.inMetersPerSecondSquared, closeTo(expectedMpss, tolerance));
        // Check how many 'g's this is
        expect(carAcc.inStandardGravity, closeTo(expectedMpss / 9.80665, tolerance));
      });
    });

    group('Comparison', () {
      test('should correctly compare different units', () {
        final a1 = 9.80665.mpsSquared;
        final a2 = 1.gravity;
        final a3 = 10.0.mpsSquared;

        expect(a1.compareTo(a2), 0);
        expect(a3.compareTo(a1), greaterThan(0));
        expect(a1.compareTo(a3), lessThan(0));
      });
    });

    group('Arithmetic', () {
      test('should perform addition and subtraction', () {
        final sum = 1.gravity + 0.19335.mpsSquared; // 9.80665 + 0.19335 = 10.0
        expect(sum.inMetersPerSecondSquared, closeTo(10.0, tolerance));
        expect(sum.unit, AccelerationUnit.standardGravity);
      });

      test('should perform scalar multiplication and division', () {
        final acc = 0.5.gravity;
        expect((acc * 2.0).inStandardGravity, closeTo(1.0, tolerance));
        expect((acc / 2.0).inStandardGravity, closeTo(0.25, tolerance));
        expect(() => acc / 0, throwsArgumentError);
      });
    });

    group('Dimensional Analysis', () {
      test('Speed / Time = Acceleration', () {
        final speedChange = 100.kmh;
        final time = 10.s;
        final acc = Acceleration.from(speedChange, time);

        expect(acc, isA<Acceleration>());
        // 100 km/h is ~27.77 m/s. Over 10s, this is ~2.77 m/s²
        expect(acc.inMetersPerSecondSquared, closeTo(2.777, 1e-3));

        expect(() => Acceleration.from(100.kmh, 0.s), throwsArgumentError);
      });

      test('Acceleration * Time = Speed', () {
        final acc = 2.gravity; // ~19.6 m/s²
        final time = 2.s;
        final speed = acc.speedGainedOver(time);

        expect(speed, isA<Speed>());
        expect(speed.inMps, closeTo(2 * 9.80665 * 2, tolerance));
      });
    });

    group('Round Trip Conversions', () {
      for (final unit in AccelerationUnit.values) {
        test('Round trip ${unit.symbol} <-> m/s²', () {
          const initialValue = 12.345;
          final acc = Acceleration(initialValue, unit);
          final roundTripAcc = acc.asMetersPerSecondSquared.convertTo(unit);
          expect(roundTripAcc.value, closeTo(initialValue, 1e-9));
        });
      }
    });

    group('Practical Examples', () {
      test('Free fall calculation', () {
        final gravity = 1.gravity;
        final fallTime = 5.s;
        // v = a * t
        final finalSpeed = gravity.speedGainedOver(fallTime);

        expect(finalSpeed.inMps, closeTo(9.80665 * 5, tolerance));
        expect(finalSpeed.inKmh, closeTo(9.80665 * 5 * 3.6, tolerance));
      });

      test('Car performance (0 to 100 km/h)', () {
        // A sports car goes from 0 to 100 km/h in 3.5 seconds
        final speedChange = 100.kmh;
        final timeTaken = 3.5.s;
        final averageAcceleration = Acceleration.from(speedChange, timeTaken);

        // Express acceleration in 'g's
        expect(averageAcceleration.inStandardGravity, closeTo(0.8, 0.01));
      });
    });
  });
}
