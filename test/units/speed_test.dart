// test/units/speed_test.dart

import 'package:quantify/length.dart';
import 'package:quantify/speed.dart';
import 'package:quantify/time.dart';
import 'package:test/test.dart';

void main() {
  group('Speed', () {
    const tolerance = 1e-12;

    group('Constructors and Getters', () {
      test('should create from num extensions and retrieve values', () {
        final speed = 100.0.kmh;
        expect(speed.value, 100.0);
        expect(speed.unit, SpeedUnit.kilometerPerHour);
        // 100 km/h = 100 * 1000 / 3600 m/s
        expect(speed.inMps, closeTo(100 * 1000 / 3600, tolerance));
      });
    });

    group('Conversions', () {
      test('Meter per second to others', () {
        final speed = 10.0.mps; // 10 m/s
        expect(speed.inKmh, closeTo(36.0, tolerance));
        expect(speed.inMph, closeTo(22.3694, 1e-4));
        expect(speed.inKnots, closeTo(19.4384, 1e-4));
        expect(speed.inFeetPerSecond, closeTo(32.8084, 1e-4));
      });

      test('Kilometer per hour to others', () {
        final speed = 36.0.kmh;
        expect(speed.inMps, closeTo(10.0, tolerance));
      });

      test('Knot to m/s', () {
        final speed = 1.0.knots;
        expect(speed.inMps, closeTo(1852.0 / 3600.0, tolerance));
      });
    });

    group('Comparison', () {
      test('should correctly compare different units', () {
        final s1 = 10.0.mps; // 36 km/h
        final s2 = 36.0.kmh;
        final s3 = 35.0.kmh;

        expect(s1.compareTo(s2), 0);
        expect(s1.compareTo(s3), greaterThan(0));
        expect(s3.compareTo(s1), lessThan(0));
      });
    });

    group('Arithmetic', () {
      test('should perform addition and subtraction', () {
        final sum = 10.mps + 18.kmh; // 10 m/s + 5 m/s = 15 m/s
        expect(sum.inMps, closeTo(15.0, tolerance));
        expect(sum.unit, SpeedUnit.meterPerSecond);
      });

      test('should perform scalar multiplication and division', () {
        final speed = 50.0.kmh;
        expect((speed * 2.0).inKmh, closeTo(100.0, tolerance));
        expect((speed / 5.0).inKmh, closeTo(10.0, tolerance));
        expect(() => speed / 0, throwsArgumentError);
      });
    });

    group('Dimensional Analysis', () {
      test('Length / Time = Speed', () {
        final distance = 100.m;
        final time = 10.s;
        final speed = Speed.from(distance, time);
        expect(speed, isA<Speed>());
        expect(speed.inMps, closeTo(10.0, tolerance));

        final distanceKm = 1.km;
        final timeHours = 1.h;
        final speed2 = Speed.from(distanceKm, timeHours);
        expect(speed2.inKmh, closeTo(1.0, tolerance));

        expect(() => Speed.from(100.m, 0.s), throwsArgumentError);
      });

      test('Speed * Time = Length', () {
        final speed = 60.kmh;
        final time = 2.h;
        final distance = speed.distanceOver(time);
        expect(distance, isA<Length>());
        expect(distance.inKm, closeTo(120.0, tolerance));

        final speed2 = 10.mps;
        final time2 = 30.s;
        final distance2 = speed2.distanceOver(time2);
        expect(distance2.inM, closeTo(300.0, tolerance));
      });
    });

    group('Round Trip Conversions', () {
      for (final unit in SpeedUnit.values) {
        test('Round trip ${unit.symbol} <-> m/s', () {
          const initialValue = 123.456;
          final speed = Speed(initialValue, unit);
          final roundTripSpeed = speed.asMetersPerSecond.convertTo(unit);
          expect(roundTripSpeed.value, closeTo(initialValue, tolerance));
        });
      }
    });

    group('Practical Examples', () {
      test('Vehicle speed', () {
        final highwaySpeed = 120.kmh;
        final citySpeed = 30.mph;

        // Compare speeds
        expect(highwaySpeed.compareTo(citySpeed), greaterThan(0));

        // Calculate travel distance
        final travelTime = 30.minutes;
        final distance = highwaySpeed.distanceOver(travelTime);
        expect(distance.inKm, closeTo(60.0, tolerance));
      });
    });
  });
}
