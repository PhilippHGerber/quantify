// test/units/frequency_interop_test.dart

import 'dart:math' as math;

import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('Frequency and AngularVelocity Interoperability', () {
    const tolerance = 1e-12;

    group('AngularVelocity to Frequency (.asFrequency)', () {
      test('should convert rpm correctly', () {
        final angularSpeed = 3000.rpm;
        final frequency = angularSpeed.asFrequency;
        expect(frequency, isA<Frequency>());
        expect(frequency.value, 3000.0);
        expect(frequency.unit, FrequencyUnit.revolutionsPerMinute);
        expect(frequency.inHertz, closeTo(50.0, tolerance));
      });

      test('should convert rad/s correctly', () {
        final angularSpeed = (20 * math.pi).radiansPerSecond;
        final frequency = angularSpeed.asFrequency;
        expect(frequency, isA<Frequency>());
        expect(frequency.value, angularSpeed.value);
        expect(frequency.unit, FrequencyUnit.radianPerSecond);
        expect(frequency.inHertz, closeTo(10.0, tolerance));
      });

      test('should convert rps correctly to Hz', () {
        // rps in AngularVelocity is 1-to-1 with Hertz in Frequency
        final angularSpeed = 10.rps;
        final frequency = angularSpeed.asFrequency;
        expect(frequency, isA<Frequency>());
        expect(frequency.value, 10.0);
        expect(frequency.unit, FrequencyUnit.hertz);
      });
    });

    group('Frequency to AngularVelocity (.asAngularVelocity)', () {
      test('should convert compatible rotational units correctly', () {
        const freqRpm = Frequency(60, FrequencyUnit.revolutionsPerMinute);
        final avRpm = freqRpm.asAngularVelocity;
        expect(avRpm, isA<AngularVelocity>());
        expect(avRpm.value, 60.0);
        expect(avRpm.unit, AngularVelocityUnit.revolutionPerMinute);
        expect(avRpm.inRps, closeTo(1.0, tolerance));

        final freqHz = 50.hz; // Represents 50 cycles/revolutions per second
        final avRps = freqHz.asAngularVelocity;
        expect(avRps, isA<AngularVelocity>());
        expect(avRps.value, 50.0);
        expect(avRps.unit, AngularVelocityUnit.revolutionPerSecond);
        expect(avRps.inRpm, closeTo(3000.0, tolerance));
      });

      test('should throw UnsupportedError for non-rotational units', () {
        final heartRate = 120.bpm;
        final radioWave = 88.5.mhz;
        final cpuClock = 4.2.ghz;

        expect(
          () => heartRate.asAngularVelocity,
          throwsA(isA<UnsupportedError>()),
          reason: 'BPM should not be convertible to AngularVelocity.',
        );
        expect(
          () => radioWave.asAngularVelocity,
          throwsA(isA<UnsupportedError>()),
          reason: 'MHz should not be convertible to AngularVelocity.',
        );
        expect(
          () => cpuClock.asAngularVelocity,
          throwsA(isA<UnsupportedError>()),
          reason: 'GHz should not be convertible to AngularVelocity.',
        );
      });

      test('error message should be informative', () {
        try {
          120.bpm.asAngularVelocity;
          fail('Should have thrown an error.');
          // ignore: avoid_catches_without_on_clauses // Catching all exceptions to check the type
        } catch (e) {
          expect(e, isA<UnsupportedError>());
          expect(
            (e as UnsupportedError).message,
            contains('unit "bpm" to an AngularVelocity'),
          );
        }
      });
    });
  });
}
