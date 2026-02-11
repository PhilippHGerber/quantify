// test/units/frequency_test.dart
import 'package:quantify/frequency.dart';
import 'package:quantify/time.dart';
import 'package:test/test.dart';

void main() {
  group('Frequency', () {
    const tolerance = 1e-12;

    // Helper for round trip tests
    void testRoundTrip(
      FrequencyUnit initialUnit,
      FrequencyUnit intermediateUnit,
      double initialValue, {
      double tol = tolerance,
    }) {
      final f1 = Frequency(initialValue, initialUnit);
      final f2 = f1.convertTo(intermediateUnit);
      final f3 = f2.convertTo(initialUnit);
      expect(
        f3.value,
        closeTo(initialValue, tol),
        reason:
            '${initialUnit.symbol} -> ${intermediateUnit.symbol} -> ${initialUnit.symbol} failed for $initialValue',
      );
    }

    group('Constructors and Getters', () {
      test('should create from num extensions and retrieve values', () {
        final freq = 100.mhz;
        expect(freq.value, 100.0);
        expect(freq.unit, FrequencyUnit.megahertz);
        expect(freq.inHertz, closeTo(1e8, tolerance));
        expect(freq.inGigahertz, closeTo(0.1, tolerance));
      });

      test('RPM and BPM should be constructible', () {
        final engineSpeed = 3000.rpm;
        expect(engineSpeed.inHertz, closeTo(50.0, tolerance)); // 3000/60

        final heartRate = 120.bpm;
        expect(heartRate.inHertz, closeTo(2.0, tolerance)); // 120/60
      });
    });

    group('Conversions', () {
      test('Hertz to other units', () {
        final oneHertz = 1.0.hz;
        expect(oneHertz.inKilohertz, closeTo(0.001, tolerance));
        expect(oneHertz.inMegahertz, closeTo(1e-6, tolerance));
        expect(oneHertz.inGigahertz, closeTo(1e-9, tolerance));
        expect(oneHertz.inRevolutionsPerMinute, closeTo(60.0, tolerance));
        expect(oneHertz.inBeatsPerMinute, closeTo(60.0, tolerance));
      });

      test('Terahertz to other SI units', () {
        final opticalFreq = 1.5.thz;
        expect(opticalFreq.inGigahertz, closeTo(1500.0, tolerance));
        expect(opticalFreq.inHertz, closeTo(1.5e12, tolerance));
      });

      test('Kilohertz to Hertz', () {
        final radioFreq = 88.5.khz;
        expect(radioFreq.inHertz, closeTo(88500.0, tolerance));
      });

      test('RPM to Hertz', () {
        final idle = 600.rpm;
        expect(idle.inHertz, closeTo(10.0, tolerance));
      });
    });

    group('Comparison', () {
      test('should correctly compare different units', () {
        final f1 = 100.mhz;
        final f2 = 0.1.ghz;
        final f3 = 99.mhz;

        expect(f1.compareTo(f2), 0);
        expect(f1.compareTo(f3), greaterThan(0));
        expect(f3.compareTo(f1), lessThan(0));
      });
    });

    group('Arithmetic', () {
      test('should perform addition and subtraction', () {
        final sum = 1.ghz + 200.mhz; // 1000 MHz + 200 MHz = 1200 MHz
        expect(sum.inGigahertz, closeTo(1.2, tolerance));
        expect(sum.unit, FrequencyUnit.gigahertz); // Left operand's unit

        final diff = 100.hz - 3000.rpm; // 100 Hz - 50 Hz = 50 Hz
        expect(diff.inHertz, closeTo(50.0, tolerance));
      });

      test('should perform scalar multiplication and division', () {
        final freq = 50.hz;
        expect((freq * 2.5).inHertz, closeTo(125.0, tolerance));
        expect((freq / 2.0).inHertz, closeTo(25.0, tolerance));
        expect(() => freq / 0, throwsArgumentError);
      });
    });

    group('Dimensional Analysis (Time Interop)', () {
      test('Frequency.from(Time) creates correct frequency', () {
        // Period of 20 ms -> 50 Hz
        final period = 20.ms;
        final freq = Frequency.from(period);
        expect(freq.inHertz, closeTo(50.0, tolerance));

        // Period of 1 second -> 1 Hz
        final freq2 = Frequency.from(1.s);
        expect(freq2.inHertz, closeTo(1.0, tolerance));

        expect(() => Frequency.from(0.s), throwsArgumentError);
      });

      test('frequency.period calculates correct time duration', () {
        // 50 Hz -> 20 ms period
        final freq = 50.hz;
        final period = freq.period;
        expect(period.inMilliseconds, closeTo(20.0, tolerance));

        // 4.2 GHz CPU -> ~0.238 ns period
        final cpuFreq = 4.2.ghz;
        final cycleTime = cpuFreq.period;
        expect(cycleTime.inNanoseconds, closeTo(1 / 4.2, tolerance));
        expect(cycleTime.unit, TimeUnit.second); // Always returns in base unit

        expect(() => 0.hz.period, throwsUnsupportedError);
      });
    });

    group('Round Trip Conversions', () {
      for (final unit in FrequencyUnit.values) {
        test('Round trip ${unit.symbol} <-> Hz', () {
          testRoundTrip(unit, FrequencyUnit.hertz, 123.456);
        });
      }
    });

    group('Comprehensive Extension Coverage', () {
      test('all creation extensions', () {
        expect(360.degPerSec.unit, FrequencyUnit.degreePerSecond);
        expect(360.degPerSec.inHertz, closeTo(1.0, tolerance));
        // 2π rad/s = 1 Hz
        const twoPi = 2 * 3.141592653589793;
        expect(twoPi.radPerSec.inHertz, closeTo(1.0, tolerance));
      });

      test('all in* value getters', () {
        final f = 1.0.hz;
        expect(f.inRadiansPerSecond, closeTo(2 * 3.141592653589793, tolerance));
        expect(f.inDegreesPerSecond, closeTo(360.0, tolerance));
      });

      test('all as* conversion getters', () {
        const twoPi = 2 * 3.141592653589793;
        final f = 1.0.ghz;

        final asHz = f.asHertz;
        expect(asHz.unit, FrequencyUnit.hertz);
        expect(asHz.value, closeTo(1e9, tolerance));

        final asThz = 1e12.hz.asTerahertz;
        expect(asThz.unit, FrequencyUnit.terahertz);
        expect(asThz.value, closeTo(1.0, tolerance));

        final asGhz = 1e9.hz.asGigahertz;
        expect(asGhz.unit, FrequencyUnit.gigahertz);
        expect(asGhz.value, closeTo(1.0, tolerance));

        final asMhz = 1e6.hz.asMegahertz;
        expect(asMhz.unit, FrequencyUnit.megahertz);
        expect(asMhz.value, closeTo(1.0, tolerance));

        final asKhz = 1000.hz.asKilohertz;
        expect(asKhz.unit, FrequencyUnit.kilohertz);
        expect(asKhz.value, closeTo(1.0, tolerance));

        final asRpm = 1.0.hz.asRevolutionsPerMinute;
        expect(asRpm.unit, FrequencyUnit.revolutionsPerMinute);
        expect(asRpm.value, closeTo(60.0, tolerance));

        final asBpm = 1.0.hz.asBeatsPerMinute;
        expect(asBpm.unit, FrequencyUnit.beatsPerMinute);
        expect(asBpm.value, closeTo(60.0, tolerance));

        final asRadPerSec = 1.0.hz.asRadiansPerSecond;
        expect(asRadPerSec.unit, FrequencyUnit.radianPerSecond);
        expect(asRadPerSec.value, closeTo(twoPi, tolerance));

        final asDegPerSec = 1.0.hz.asDegreesPerSecond;
        expect(asDegPerSec.unit, FrequencyUnit.degreePerSecond);
        expect(asDegPerSec.value, closeTo(360.0, tolerance));
      });
    });

    group('Practical Examples', () {
      test('AC Power Frequency', () {
        final usPower = 60.hz;
        final euPower = 50.hz;
        expect(usPower.compareTo(euPower), greaterThan(0));
        expect(usPower.period.inMilliseconds, closeTo(16.666, 1e-3));
        expect(euPower.period.inMilliseconds, closeTo(20.0, tolerance));
      });

      test('Music Tempo', () {
        // A common tempo is 120 bpm
        final tempo = 120.bpm;
        // Each beat takes 0.5 seconds
        expect(tempo.period.inSeconds, closeTo(0.5, tolerance));
        expect(tempo.inHertz, closeTo(2.0, tolerance));
      });
    });
  });
}
