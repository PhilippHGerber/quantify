// ignore_for_file: prefer_int_literals // All constants are doubles for precision.

import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('Time', () {
    const tolerance = 1e-9;

    // Helper for round trip tests
    void testRoundTrip(
      TimeUnit initialUnit,
      TimeUnit intermediateUnit,
      double initialValue, {
      double tolerance = 1e-9,
    }) {
      final t1 = Time(initialValue, initialUnit);
      final t2 = t1.convertTo(intermediateUnit);
      final t3 = t2.convertTo(initialUnit);
      expect(
        t3.value,
        closeTo(initialValue, tolerance),
        reason:
            '${initialUnit.symbol} -> ${intermediateUnit.symbol} -> ${initialUnit.symbol} failed for $initialValue',
      );
    }

    group('Constructors and Getters', () {
      test('should create Time from num extensions and retrieve values', () {
        final t1 = 60.0.seconds;
        expect(t1.value, 60.0);
        expect(t1.unit, TimeUnit.second);
        expect(t1.inMinutes, closeTo(1.0, tolerance));

        final t2 = 1.5.hours;
        expect(t2.value, 1.5);
        expect(t2.unit, TimeUnit.hour);
        expect(t2.inMinutes, closeTo(90.0, tolerance));
        expect(t2.inSeconds, closeTo(1.5 * 3600.0, tolerance));

        final t3 = 500.milliseconds;
        expect(t3.inSeconds, closeTo(0.5, tolerance));

        final t4 = 1.days;
        expect(t4.inHours, closeTo(24.0, tolerance));
      });

      test('getValue should return correct value for same unit', () {
        const t = Time(25.0, TimeUnit.minute);
        expect(t.getValue(TimeUnit.minute), 25.0);
      });

      test('getValue for all units from Second base', () {
        final t = 3600.0.seconds; // 1 hour
        expect(t.inSeconds, 3600.0);
        expect(t.inMilliseconds, closeTo(3600.0 * 1000.0, tolerance));
        expect(t.inMinutes, closeTo(60.0, tolerance));
        expect(t.inHours, closeTo(1.0, tolerance));
        expect(t.inDays, closeTo(1.0 / 24.0, tolerance));
      });
    });

    group('Conversions', () {
      final oneHour = 1.0.hours;

      test('1 hour to various units', () {
        expect(oneHour.inMinutes, closeTo(60.0, tolerance));
        expect(oneHour.inSeconds, closeTo(3600.0, tolerance));
        expect(oneHour.inMilliseconds, closeTo(3600.0 * 1000.0, tolerance));
      });

      final oneDay = 1.0.days;
      test('1 day to various units', () {
        expect(oneDay.inHours, closeTo(24.0, tolerance));
        expect(oneDay.inMinutes, closeTo(24.0 * 60.0, tolerance));
        expect(oneDay.inSeconds, closeTo(24.0 * 3600.0, tolerance));
      });

      final thirtyMinutes = 30.0.minutes;
      test('30 minutes to hours and seconds', () {
        expect(thirtyMinutes.inHours, closeTo(0.5, tolerance));
        expect(thirtyMinutes.inSeconds, closeTo(30.0 * 60.0, tolerance));
      });
    });

    group('convertTo method', () {
      test('should return new Time object with converted value and unit', () {
        final tMinutes = 90.0.minutes;
        final tHours = tMinutes.convertTo(TimeUnit.hour);
        expect(tHours.unit, TimeUnit.hour);
        expect(tHours.value, closeTo(1.5, tolerance));
        expect(tMinutes.unit, TimeUnit.minute); // Original should be unchanged
      });

      test('convertTo same unit should return same instance', () {
        final t1 = 10.0.seconds;
        final t2 = t1.convertTo(TimeUnit.second);
        expect(identical(t1, t2), isTrue);
      });
    });

    group('Comparison (compareTo)', () {
      final t1Hour = 1.0.hours;
      final t59Minutes = 59.0.minutes;
      final t61Minutes = 61.0.minutes;
      final t3600Seconds = 3600.0.seconds;

      test('should correctly compare times of different units', () {
        expect(t1Hour.compareTo(t59Minutes), greaterThan(0));
        expect(t59Minutes.compareTo(t1Hour), lessThan(0));
        expect(t1Hour.compareTo(t61Minutes), lessThan(0));
      });

      test('should return 0 for equal times in different units', () {
        expect(t1Hour.compareTo(t3600Seconds), 0);
        expect(t3600Seconds.compareTo(t1Hour), 0);
        final tPoint5Hours = 0.5.hours;
        final t30Minutes = 30.0.minutes;
        expect(tPoint5Hours.compareTo(t30Minutes), 0);
      });
    });

    group('Equality and HashCode', () {
      test('should be equal for same value and unit', () {
        const t1 = Time(10.0, TimeUnit.second);
        const t2 = Time(10.0, TimeUnit.second);
        expect(t1 == t2, isTrue);
        expect(t1.hashCode == t2.hashCode, isTrue);
      });

      test('should not be equal for different values or units', () {
        const t1 = Time(10.0, TimeUnit.second);
        const t2 = Time(10.1, TimeUnit.second);
        const t3 = Time(10.0, TimeUnit.minute);
        expect(t1 == t2, isFalse);
        expect(t1 == t3, isFalse);
      });
    });

    group('toString()', () {
      test('should return formatted string', () {
        expect(10.5.seconds.toString(), '10.5 s');
        expect(120.0.minutes.toString(), '120.0 min');
        expect(2.5.hours.toString(), '2.5 h');
        expect(1.days.toString(), '1.0 d');
      });
    });

    group('Round Trip Conversions', () {
      const testValue = 789.123;
      const highTolerance = 1e-7;

      for (final unit in TimeUnit.values) {
        test('Round trip ${unit.symbol} <-> s', () {
          testRoundTrip(
            unit,
            TimeUnit.second,
            testValue,
            tolerance: (unit == TimeUnit.second) ? 1e-9 : highTolerance,
          );
        });
      }

      test('Round trip min <-> h', () {
        testRoundTrip(TimeUnit.minute, TimeUnit.hour, 120.0, tolerance: highTolerance);
      });
      test('Round trip ms <-> s', () {
        testRoundTrip(TimeUnit.millisecond, TimeUnit.second, 2500.0, tolerance: highTolerance);
      });
    });

    group('Edge Cases', () {
      test('Conversion with zero value', () {
        final tZero = 0.0.seconds;
        for (final unit in TimeUnit.values) {
          expect(tZero.getValue(unit), 0.0, reason: '0 s to ${unit.symbol} should be 0');
        }
      });
    });

    group('Arithmetic Operators for Time', () {
      final t1Hour = 1.0.hours;
      final t2Hours = 2.0.hours;
      final t30Minutes = 30.minutes; // 0.5 hours

      // Operator +
      test('operator + combines time durations', () {
        final sum1 = t2Hours + t1Hour;
        expect(sum1.value, closeTo(3.0, tolerance));
        expect(sum1.unit, TimeUnit.hour);

        final sum2 = t1Hour + t30Minutes; // 1h + 0.5h = 1.5h
        expect(sum2.value, closeTo(1.5, tolerance));
        expect(sum2.unit, TimeUnit.hour);

        final sum3 = t30Minutes + t1Hour; // 30min + 60min = 90min
        expect(sum3.value, closeTo(90.0, tolerance));
        expect(sum3.unit, TimeUnit.minute);
      });

      // Operator -
      test('operator - subtracts time durations', () {
        final diff1 = t2Hours - t1Hour;
        expect(diff1.value, closeTo(1.0, tolerance));
        expect(diff1.unit, TimeUnit.hour);

        final diff2 = t1Hour - t30Minutes; // 1h - 0.5h = 0.5h
        expect(diff2.value, closeTo(0.5, tolerance));
        expect(diff2.unit, TimeUnit.hour);
      });

      // Operator * (scalar)
      test('operator * scales time duration by a scalar', () {
        final scaled = t2Hours * 0.5;
        expect(scaled.value, closeTo(1.0, tolerance));
        expect(scaled.unit, TimeUnit.hour);
      });

      // Operator / (scalar)
      test('operator / scales time duration by a scalar', () {
        final scaled = t2Hours / 2.0;
        expect(scaled.value, closeTo(1.0, tolerance));
        expect(scaled.unit, TimeUnit.hour);
        expect(() => t1Hour / 0.0, throwsArgumentError);
      });
    });
  });
}
