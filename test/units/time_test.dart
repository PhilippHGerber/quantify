// ignore_for_file: prefer_int_literals // All constants are doubles for precision.

import 'package:quantify/quantify.dart';
import 'package:quantify/src/units/time/time_factors.dart';
import 'package:test/test.dart';

void main() {
  const highprecisionTolerance = 1e-12; // High precision for time
  const tolerance = 1e-9; // General purpose
  const lowprecisionTolerance = 1e-6; // For calendar units (months, years)

  group('Time', () {
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
        expect(t1.inMinutes, closeTo(1.0, highprecisionTolerance));

        final t2 = 1.5.hours;
        expect(t2.value, 1.5);
        expect(t2.unit, TimeUnit.hour);
        expect(t2.inMinutes, closeTo(90.0, highprecisionTolerance));
        expect(t2.inSeconds, closeTo(1.5 * 3600.0, highprecisionTolerance));

        final t3 = 500.milliseconds;
        expect(t3.inSeconds, closeTo(0.5, highprecisionTolerance));

        final t4 = 1.days;
        expect(t4.inHours, closeTo(24.0, highprecisionTolerance));
      });

      test('getValue should return correct value for same unit', () {
        const t = Time(25.0, TimeUnit.minute);
        expect(t.getValue(TimeUnit.minute), 25.0);
      });

      test('getValue for all units from Second base', () {
        final t = 3600.0.seconds; // 1 hour
        expect(t.inSeconds, 3600.0);
        expect(t.inMilliseconds, closeTo(3600.0 * 1000.0, highprecisionTolerance));
        expect(t.inMinutes, closeTo(60.0, highprecisionTolerance));
        expect(t.inHours, closeTo(1.0, highprecisionTolerance));
        expect(t.inDays, closeTo(1.0 / 24.0, highprecisionTolerance));
      });
    });

    group('Conversions', () {
      final oneHour = 1.0.hours;

      test('1 hour to various units', () {
        expect(oneHour.inMinutes, closeTo(60.0, highprecisionTolerance));
        expect(oneHour.inSeconds, closeTo(3600.0, highprecisionTolerance));
        expect(oneHour.inMilliseconds, closeTo(3600.0 * 1000.0, highprecisionTolerance));
      });

      final oneDay = 1.0.days;
      test('1 day to various units', () {
        expect(oneDay.inHours, closeTo(24.0, highprecisionTolerance));
        expect(oneDay.inMinutes, closeTo(24.0 * 60.0, highprecisionTolerance));
        expect(oneDay.inSeconds, closeTo(24.0 * 3600.0, highprecisionTolerance));
      });

      final thirtyMinutes = 30.0.minutes;
      test('30 minutes to hours and seconds', () {
        expect(thirtyMinutes.inHours, closeTo(0.5, highprecisionTolerance));
        expect(thirtyMinutes.inSeconds, closeTo(30.0 * 60.0, highprecisionTolerance));
      });
    });

    group('convertTo method', () {
      test('should return new Time object with converted value and unit', () {
        final tMinutes = 90.0.minutes;
        final tHours = tMinutes.convertTo(TimeUnit.hour);
        expect(tHours.unit, TimeUnit.hour);
        expect(tHours.value, closeTo(1.5, highprecisionTolerance));
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
        expect(10.5.seconds.toString(), '10.5 s');
        expect(120.0.minutes.toString(), '120.0 min');
        expect(2.5.hours.toString(), '2.5 h');
        expect(1.days.toString(), '1.0 d');
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
        expect(sum1.value, closeTo(3.0, highprecisionTolerance));
        expect(sum1.unit, TimeUnit.hour);

        final sum2 = t1Hour + t30Minutes; // 1h + 0.5h = 1.5h
        expect(sum2.value, closeTo(1.5, highprecisionTolerance));
        expect(sum2.unit, TimeUnit.hour);

        final sum3 = t30Minutes + t1Hour; // 30min + 60min = 90min
        expect(sum3.value, closeTo(90.0, highprecisionTolerance));
        expect(sum3.unit, TimeUnit.minute);
      });

      // Operator -
      test('operator - subtracts time durations', () {
        final diff1 = t2Hours - t1Hour;
        expect(diff1.value, closeTo(1.0, highprecisionTolerance));
        expect(diff1.unit, TimeUnit.hour);

        final diff2 = t1Hour - t30Minutes; // 1h - 0.5h = 0.5h
        expect(diff2.value, closeTo(0.5, highprecisionTolerance));
        expect(diff2.unit, TimeUnit.hour);
      });

      // Operator * (scalar)
      test('operator * scales time duration by a scalar', () {
        final scaled = t2Hours * 0.5;
        expect(scaled.value, closeTo(1.0, highprecisionTolerance));
        expect(scaled.unit, TimeUnit.hour);
      });

      // Operator / (scalar)
      test('operator / scales time duration by a scalar', () {
        final scaled = t2Hours / 2.0;
        expect(scaled.value, closeTo(1.0, highprecisionTolerance));
        expect(scaled.unit, TimeUnit.hour);
        expect(() => t1Hour / 0.0, throwsArgumentError);
      });
    });
  });

  group('Extended Time Units', () {
    group('SI Prefix Units (sub-second)', () {
      test('microsecond conversions', () {
        final oneMicrosecond = 1.0.us;
        expect(oneMicrosecond.inSeconds, closeTo(1e-6, highprecisionTolerance));
        expect(oneMicrosecond.inMilliseconds, closeTo(0.001, highprecisionTolerance));
        expect(oneMicrosecond.inNanoseconds, closeTo(1000.0, highprecisionTolerance));
      });

      test('nanosecond conversions', () {
        final oneNanosecond = 1.0.ns;
        expect(oneNanosecond.inSeconds, closeTo(1e-9, highprecisionTolerance));
        expect(oneNanosecond.inMicroseconds, closeTo(0.001, highprecisionTolerance));
        expect(oneNanosecond.inPicoseconds, closeTo(1000.0, highprecisionTolerance));
      });

      test('picosecond conversions', () {
        final onePicosecond = 1.0.ps;
        expect(onePicosecond.inSeconds, closeTo(1e-12, highprecisionTolerance));
        expect(onePicosecond.inNanoseconds, closeTo(0.001, highprecisionTolerance));
        expect(onePicosecond.inMicroseconds, closeTo(1e-6, highprecisionTolerance));
      });

      test('sub-second scale relationships', () {
        // Test the progression: s -> ms -> μs -> ns -> ps
        final oneSecond = 1.0.s;
        expect(oneSecond.inMilliseconds, closeTo(1000.0, highprecisionTolerance));
        expect(oneSecond.inMicroseconds, closeTo(1e6, highprecisionTolerance));
        expect(oneSecond.inNanoseconds, closeTo(1e9, lowprecisionTolerance));
        expect(oneSecond.inPicoseconds, closeTo(1e12, highprecisionTolerance));
      });
    });

    group('Calendar Units', () {
      test('week conversions', () {
        final oneWeek = 1.0.wk;
        expect(oneWeek.inDays, closeTo(7.0, highprecisionTolerance));
        expect(oneWeek.inHours, closeTo(168.0, highprecisionTolerance)); // 7 * 24
        expect(oneWeek.inMinutes, closeTo(10080.0, highprecisionTolerance)); // 7 * 24 * 60
        expect(oneWeek.inSeconds, closeTo(604800.0, highprecisionTolerance)); // 7 * 24 * 60 * 60
      });

      test('month conversions', () {
        final oneMonth = 1.0.mo;
        // Based on average month: 365.25 days / 12 = 30.4375 days
        expect(oneMonth.inDays, closeTo(30.4375, tolerance));
        expect(oneMonth.inWeeks, closeTo(4.348214286, tolerance));
        expect(oneMonth.inHours, closeTo(730.5, tolerance));
        expect(oneMonth.inSeconds, closeTo(2629800.0, tolerance));
      });

      test('year conversions', () {
        final oneYear = 1.0.yr;
        // Based on Julian year: 365.25 days
        expect(oneYear.inDays, closeTo(365.25, highprecisionTolerance));
        expect(oneYear.inWeeks, closeTo(52.178571429, lowprecisionTolerance));
        expect(oneYear.inMonths, closeTo(12.0, lowprecisionTolerance));
        expect(oneYear.inHours, closeTo(8766.0, highprecisionTolerance)); // 365.25 * 24
        expect(
          oneYear.inSeconds,
          closeTo(31557600.0, highprecisionTolerance),
        ); // 365.25 * 24 * 60 * 60
      });

      test('calendar relationships', () {
        // Test approximate relationships
        final oneYear = 1.0.yr;
        final twelveMonths = 12.0.mo;
        final fiftyTwoWeeks = 52.0.wk;

        // Based on the definitions, a Julian year is now exactly 12 average months.
        expect(oneYear.compareTo(twelveMonths), 0);

        // Year should be slightly more than 52 weeks
        expect(oneYear.compareTo(fiftyTwoWeeks), greaterThan(0));

        // Differences should be small
        expect(oneYear.inMonths, closeTo(12.0, 0.1));
        expect(oneYear.inWeeks, closeTo(52.18, 0.2));
      });
    });

    group('Practical time measurements', () {
      test('computer processing times', () {
        // CPU clock cycles at 3 GHz
        final cpuCycle = (1.0 / 3e9).s; // 1/3 nanosecond
        expect(cpuCycle.inNanoseconds, closeTo(1.0 / 3.0, tolerance));

        // Memory access time ≈ 100 ns
        final memoryAccess = 100.0.ns;
        expect(memoryAccess.inMicroseconds, closeTo(0.1, highprecisionTolerance));

        // SSD access time ≈ 0.1 ms
        final ssdAccess = 0.1.ms;
        expect(ssdAccess.inMicroseconds, closeTo(100.0, highprecisionTolerance));
      });

      test('scientific measurements', () {
        // Light travel times
        final lightToMoon = 1.28.s; // Light travel time to moon
        final lightAroundEarth = 0.134.s; // Light travel around Earth's equator

        expect(lightToMoon.inMilliseconds, closeTo(1280.0, highprecisionTolerance));
        expect(lightAroundEarth.inMilliseconds, closeTo(134.0, highprecisionTolerance));

        // Atomic vibrations ≈ femtoseconds (10^-15 s)
        final atomicVibration = 1e-3.ps; // 1 femtosecond in picoseconds
        expect(atomicVibration.inSeconds, closeTo(1e-15, highprecisionTolerance));
      });

      test('biological time scales', () {
        // Human heartbeat ≈ 1 Hz (1 beat per second)
        final heartbeat = 1.0.s;
        expect(heartbeat.inMilliseconds, closeTo(1000.0, highprecisionTolerance));

        // Nerve impulse ≈ 1 ms
        final nerveImpulse = 1.0.ms;
        expect(nerveImpulse.inMicroseconds, closeTo(1000.0, highprecisionTolerance));

        // Muscle contraction ≈ 100 ms
        final muscleContraction = 100.0.ms;
        expect(muscleContraction.inSeconds, closeTo(0.1, highprecisionTolerance));
      });

      test('human time scales', () {
        // Work schedules
        final workDay = 8.0.h;
        final workWeek = workDay * 5;
        expect(workWeek.inHours, closeTo(40.0, highprecisionTolerance));

        // Life spans
        final humanLifespan = 75.0.yr;
        final dogLifespan = 12.0.yr;
        expect(humanLifespan.inMonths, closeTo(900.0, lowprecisionTolerance));
        expect(dogLifespan.inDays, closeTo(4383.0, lowprecisionTolerance));
      });
    });

    group('Time arithmetic with mixed scales', () {
      test('adding very different time scales', () {
        final longTime = 1.0.yr;
        final shortTime = 1.0.ns;
        final combined = longTime + shortTime;

        // Nanosecond should be negligible compared to year
        expect(combined.inYears, closeTo(1.0, lowprecisionTolerance));
        expect(combined.unit, TimeUnit.year);
      });

      test('precise timing calculations', () {
        // GPS satellite clock corrections
        final gpsClockDrift = 38.0.us; // microseconds per day
        final oneDay = 1.0.d;

        expect(gpsClockDrift.inNanoseconds, closeTo(38000.0, tolerance));
        expect(oneDay.inMicroseconds, closeTo(86400e6, highprecisionTolerance));

        // Clock error rate
        final errorRate = gpsClockDrift.inSeconds / oneDay.inSeconds;
        expect(errorRate, closeTo(4.4e-10, 1e-12)); // Very small error rate
      });

      test('project timeline calculations', () {
        // Software development timeline

        final projectDuration = 6.0.mo;
        final sprintDuration = 2.0.wk;

        // Calculate expected value instead of hardcoding it
        const expectedWeeks = (6 * TimeFactors.secondsPerMonth) / TimeFactors.secondsPerWeek;
        expect(projectDuration.inWeeks, closeTo(expectedWeeks, lowprecisionTolerance));

        final numberOfSprints = projectDuration.inWeeks / sprintDuration.inWeeks;
        // The expectation for numberOfSprints should also be calculated
        const expectedSprints = expectedWeeks / 2.0;
        expect(numberOfSprints, closeTo(expectedSprints, 0.1));
      });
    });

    group('Round trip conversions for new units', () {
      const testValue = 789.123;

      test('sub-second round trips', () {
        final units = [
          TimeUnit.microsecond,
          TimeUnit.nanosecond,
          TimeUnit.picosecond,
        ];

        for (final unit in units) {
          final original = Time(testValue, unit);
          final converted = original.convertTo(TimeUnit.second).convertTo(unit);
          expect(
            converted.value,
            closeTo(testValue, tolerance),
            reason: 'Round trip failed for ${unit.symbol}',
          );
        }
      });

      test('calendar unit round trips', () {
        final units = [
          TimeUnit.week,
          TimeUnit.month,
          TimeUnit.year,
        ];

        for (final unit in units) {
          final original = Time(testValue, unit);
          final converted = original.convertTo(TimeUnit.second).convertTo(unit);
          expect(
            converted.value,
            closeTo(testValue, lowprecisionTolerance),
            reason: 'Round trip failed for ${unit.symbol}',
          );
        }
      });
    });

    group('Sorting different time scales', () {
      test('mixed scale sorting', () {
        final times = [
          1.0.yr, // 1 year
          100.0.d, // 100 days
          1000.0.h, // 1000 hours ≈ 41.7 days
          1.0.mo, // 1 month ≈ 30.4 days
          10.0.wk, // 10 weeks = 70 days
        ];

        times.sort();

        // Should be sorted: 1 mo < 1000 h < 10 wk < 100 d < 1 yr
        expect(times[0].unit, TimeUnit.month);
        expect(times[1].unit, TimeUnit.hour);
        expect(times[2].unit, TimeUnit.week);
        expect(times[3].unit, TimeUnit.day);
        expect(times[4].unit, TimeUnit.year);
      });
    });

    group('toString formatting for new units', () {
      test('should display correct symbols', () {
        expect(1.0.us.toString(), '1.0\u00A0μs');
        expect(1.0.ns.toString(), '1.0\u00A0ns');
        expect(1.0.ps.toString(), '1.0\u00A0ps');
        expect(1.0.wk.toString(), '1.0\u00A0wk');
        expect(1.0.mo.toString(), '1.0\u00A0mo');
        expect(1.0.yr.toString(), '1.0\u00A0yr');
      });

      test('alternative short form accessors', () {
        expect(1.0.min.toString(), '1.0\u00A0min');
        expect(1.0.h.toString(), '1.0\u00A0h');
        expect(1.0.d.toString(), '1.0\u00A0d');
        expect(1.0.s.toString(), '1.0\u00A0s');
        expect(1.0.ms.toString(), '1.0\u00A0ms');
      });
    });

    group('SI Prefix Units (deci, centi, deca, hecto, kilo, mega, giga)', () {
      const tolerance = 1e-12;

      test('deci- and centiseconds', () {
        final oneSecond = 1.0.s;
        expect(oneSecond.inDeciseconds, closeTo(10.0, tolerance));
        expect(oneSecond.inCentiseconds, closeTo(100.0, tolerance));

        final oneDecisecond = 1.0.ds;
        expect(oneDecisecond.inMilliseconds, closeTo(100.0, tolerance));

        final oneCentisecond = 1.0.cs;
        expect(oneCentisecond.inMilliseconds, closeTo(10.0, tolerance));
      });

      test('deca-, hecto-, and kiloseconds', () {
        final oneKilosecond = 1.0.kiloS;
        expect(oneKilosecond.inSeconds, closeTo(1000.0, tolerance));
        expect(oneKilosecond.inHectoseconds, closeTo(10.0, tolerance));
        expect(oneKilosecond.inDecaseconds, closeTo(100.0, tolerance));
      });

      test('mega- and gigaseconds', () {
        final oneMegasecond = 1.0.megaS; // 1 million seconds
        expect(oneMegasecond.inDays, closeTo(1e6 / 86400, 1e-9)); // ~11.57 days

        final oneGigasecond = 1.0.gigaS; // 1 billion seconds
        expect(oneGigasecond.inYears, closeTo(1e9 / 31557600.0, 1e-9)); // ~31.7 years
      });
    });

    group('Calendar Units (Fortnight, Decade, Century)', () {
      const tolerance = 1e-9;

      test('fortnight conversions', () {
        final oneFortnight = 1.0.fortnights;
        expect(oneFortnight.inDays, closeTo(14.0, tolerance));
        expect(oneFortnight.inWeeks, closeTo(2.0, tolerance));
      });

      test('decade conversions', () {
        final oneDecade = 1.0.decades;
        expect(oneDecade.inYears, closeTo(10.0, tolerance));
        // A decade has 120 average months
        expect(oneDecade.inMonths, closeTo(120.0, 1e-6));
      });

      test('century conversions', () {
        final oneCentury = 1.0.centuries;
        expect(oneCentury.inYears, closeTo(100.0, tolerance));
        expect(oneCentury.inDecades, closeTo(10.0, tolerance));
      });

      test('sorting calendar units', () {
        final times = [1.0.centuries, 1.0.years, 1.0.decades, 1.0.fortnights]..sort();

        expect(times[0].unit, TimeUnit.fortnight);
        expect(times[1].unit, TimeUnit.year);
        expect(times[2].unit, TimeUnit.decade);
        expect(times[3].unit, TimeUnit.century);
      });
    });
  });
}
