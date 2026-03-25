// test/units/speed_test.dart

import 'package:quantify/acceleration.dart';
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
        expect((speed / 0).value, double.infinity);
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

        expect(Speed.from(100.m, 0.s).inMps, double.infinity);
        expect(Speed.from(0.m, 0.s).inMps, isNaN);
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

      test('Length / Speed = Time', () {
        final distance = 120.km;
        final speed = 60.kmh;
        final time = speed.timeFor(distance);
        expect(time, isA<Time>());
        expect(time.inHours, closeTo(2.0, tolerance));

        final distance2 = 300.m;
        final speed2 = 10.mps;
        final time2 = speed2.timeFor(distance2);
        expect(time2.inSeconds, closeTo(30.0, tolerance));

        expect(0.mps.timeFor(100.m).inSeconds, double.infinity);
        expect(0.mps.timeFor(0.m).inSeconds, isNaN);
      });

      // --- Unit-preserving behaviour ---
      test('Speed.from: km + h → km/h', () {
        final s = Speed.from(100.km, 1.hours);
        expect(s.unit, SpeedUnit.kilometerPerHour);
        expect(s.value, closeTo(100.0, tolerance));
      });

      test('Speed.from: mi + h → mph', () {
        final s = Speed.from(60.miles, 1.hours);
        expect(s.unit, SpeedUnit.milePerHour);
        expect(s.value, closeTo(60.0, tolerance));
      });

      test('Speed.from: m + s → m/s', () {
        final s = Speed.from(100.m, 10.s);
        expect(s.unit, SpeedUnit.meterPerSecond);
        expect(s.value, closeTo(10.0, tolerance));
      });

      test('Speed.from: unmatched units → SI fallback m/s', () {
        expect(Speed.from(1.km, 1.minutes).unit, SpeedUnit.meterPerSecond);
      });

      test('Speed.from physical correctness: 100 km/h in m/s ≈ 27.778', () {
        expect(Speed.from(100.km, 1.hours).inMps, closeTo(27.7778, 1e-3));
      });

      test('distanceOver: 60 km/h for 2 h → 120 km', () {
        final d = 60.kmh.distanceOver(2.h);
        expect(d.unit, LengthUnit.kilometer);
        expect(d.value, closeTo(120.0, tolerance));
      });

      test('distanceOver: 10 m/s for 5 s → 50 m', () {
        final d = 10.mps.distanceOver(5.s);
        expect(d.unit, LengthUnit.meter);
        expect(d.value, closeTo(50.0, tolerance));
      });

      test('timeFor: 60 km/h for 120 km → 2 h', () {
        final t = 60.kmh.timeFor(120.km);
        expect(t.unit, TimeUnit.hour);
        expect(t.value, closeTo(2.0, tolerance));
      });

      test('timeFor: 10 m/s for 50 m → 5 s', () {
        final t = 10.mps.timeFor(50.m);
        expect(t.unit, TimeUnit.second);
        expect(t.value, closeTo(5.0, tolerance));
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

    group('Comprehensive Extension Coverage', () {
      test('all creation extensions', () {
        expect(10.metersPerSecond.unit, SpeedUnit.meterPerSecond);
        expect(5.kps.unit, SpeedUnit.kilometerPerSecond);
        expect(5.kilometersPerSecond.unit, SpeedUnit.kilometerPerSecond);
        expect(100.kilometersPerHour.unit, SpeedUnit.kilometerPerHour);
        expect(60.mph.unit, SpeedUnit.milePerHour);
        expect(60.milesPerHour.unit, SpeedUnit.milePerHour);
        expect(10.fps.unit, SpeedUnit.footPerSecond);
        expect(10.feetPerSecond.unit, SpeedUnit.footPerSecond);
        expect(10.feetPerSecond.inFeetPerSecond, closeTo(10.0, tolerance));
      });

      test('all in* value getter aliases', () {
        final s = 10.mps;
        expect(s.inMetersPerSecond, closeTo(10.0, tolerance));
        expect(s.inKilometersPerSecond, closeTo(0.01, tolerance));
        expect(s.inKilometersPerHour, closeTo(36.0, tolerance));
        expect(s.inMilesPerHour, closeTo(22.3694, 1e-4));
      });

      test('all as* conversion getters', () {
        final s = 10.mps;

        final asMps = s.asMetersPerSecond;
        expect(asMps.unit, SpeedUnit.meterPerSecond);
        expect(asMps.value, closeTo(10.0, tolerance));

        final asKps = s.asKilometersPerSecond;
        expect(asKps.unit, SpeedUnit.kilometerPerSecond);
        expect(asKps.value, closeTo(0.01, tolerance));

        final asKmh = s.asKilometersPerHour;
        expect(asKmh.unit, SpeedUnit.kilometerPerHour);
        expect(asKmh.value, closeTo(36.0, tolerance));

        final asMph = s.asMilesPerHour;
        expect(asMph.unit, SpeedUnit.milePerHour);
        expect(asMph.value, closeTo(22.3694, 1e-4));

        final asKnots = s.asKnots;
        expect(asKnots.unit, SpeedUnit.knot);
        expect(asKnots.value, closeTo(19.4384, 1e-4));

        final asFps = s.asFeetPerSecond;
        expect(asFps.unit, SpeedUnit.footPerSecond);
        expect(asFps.value, closeTo(32.8084, 1e-4));
      });
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

    group('Speed.fromAcceleration', () {
      const strictTolerance = 1e-12;
      const looseTolerance = 1e-9;

      test('m/s² × s → m/s', () {
        final s = Speed.fromAcceleration(10.0.mps2, 5.0.s);
        expect(s.unit, SpeedUnit.meterPerSecond);
        expect(s.value, closeTo(50.0, strictTolerance));
      });

      test('ft/s² × s → ft/s', () {
        final s = Speed.fromAcceleration(32.2.fpsSquared, 3.0.s);
        expect(s.unit, SpeedUnit.footPerSecond);
        expect(s.value, closeTo(96.6, strictTolerance));
      });

      test('km/h/s × s → km/h', () {
        final s = Speed.fromAcceleration(10.0.kmhPerS, 6.0.s);
        expect(s.unit, SpeedUnit.kilometerPerHour);
        expect(s.value, closeTo(60.0, strictTolerance));
      });

      test('mph/s × s → mph', () {
        final s = Speed.fromAcceleration(5.0.mphPerS, 4.0.s);
        expect(s.unit, SpeedUnit.milePerHour);
        expect(s.value, closeTo(20.0, strictTolerance));
      });

      test('kn/s × s → kn', () {
        final s = Speed.fromAcceleration(2.0.knotsPerS, 3.0.s);
        expect(s.unit, SpeedUnit.knot);
        expect(s.value, closeTo(6.0, strictTolerance));
      });

      test('standard gravity × 1 s → 9.80665 m/s', () {
        final s = Speed.fromAcceleration(1.0.gravity, 1.0.s);
        expect(s.unit, SpeedUnit.meterPerSecond);
        expect(s.value, closeTo(9.80665, strictTolerance));
      });

      test('cm/s² (unmatched) × s → SI fallback m/s', () {
        final s = Speed.fromAcceleration(
          const Acceleration(100, AccelerationUnit.centimeterPerSecondSquared),
          1.0.s,
        );
        expect(s.unit, SpeedUnit.meterPerSecond);
        expect(s.value, closeTo(1.0, looseTolerance));
      });

      test('time in non-seconds unit is correctly handled (m/s² × min → m/s)', () {
        // 10 m/s² × 1 min = 600 m/s
        final s = Speed.fromAcceleration(10.0.mps2, 1.0.minutes);
        expect(s.unit, SpeedUnit.meterPerSecond);
        expect(s.value, closeTo(600.0, strictTolerance));
      });

      test('physical correctness: 9.80665 m/s² × 1 s = 9.80665 m/s', () {
        expect(
          Speed.fromAcceleration(9.80665.mps2, 1.0.s).inMps,
          closeTo(9.80665, strictTolerance),
        );
      });
    });
  });
}
