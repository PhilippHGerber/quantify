import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  const tolerance = 1e-9;

  group('SoundPressureLevel', () {
    group('Constructors and Getters', () {
      test('creates from constructor and num extensions', () {
        const fromConstructor = SoundPressureLevel(94, SoundPressureLevelUnit.decibelSpl);
        expect(fromConstructor.value, 94.0);
        expect(fromConstructor.unit, SoundPressureLevelUnit.decibelSpl);

        final fromExtension = 120.dBSPL;
        expect(fromExtension.value, 120.0);
        expect(fromExtension.unit, SoundPressureLevelUnit.decibelSpl);
      });
    });

    group('Domain bridging', () {
      test('20 µPa equals 0 dB SPL', () {
        final level = SoundPressureLevel.fromPressure(const Pressure(20e-6, PressureUnit.pascal));
        expect(level.inDbSpl, closeTo(0.0, tolerance));
      });

      test('120 dB SPL converts to 20 Pa', () {
        expect(120.dBSPL.toPressure().inPa, closeTo(20.0, tolerance));
      });

      test('Pressure bridge extension converts to SPL', () {
        expect(20e-6.Pa.toSoundPressureLevel().inDbSpl, closeTo(0.0, tolerance));
      });

      test('SoundPressureLevel pressure helpers convert back to pressure', () {
        expect(120.dBSPL.asPressure.inPa, closeTo(20.0, tolerance));
        expect(120.dBSPL.asPressureIn(PressureUnit.kilopascal).value, closeTo(0.02, tolerance));
      });
    });

    group('Operator safety', () {
      test('SoundPressureLevel + LevelRatio calculates accurately', () {
        expect((94.dBSPL + 6.dB).inDbSpl, closeTo(100.0, tolerance));
      });

      test('SoundPressureLevel.subtract(LevelRatio) calculates accurately', () {
        expect(94.dBSPL.subtract(3.dB).inDbSpl, closeTo(91.0, tolerance));
      });

      test('SoundPressureLevel - SoundPressureLevel returns LevelRatio', () {
        final delta = 94.dBSPL - 90.dBSPL;
        expect(delta.unit, LevelRatioUnit.decibel);
        expect(delta.inDecibel, closeTo(4.0, tolerance));
      });

      test('SoundPressureLevel + SoundPressureLevel is not available generically', () {
        final dynamic lhs = 94.dBSPL;
        final dynamic rhs = 90.dBSPL;
        // This intentionally uses dynamic to assert unsupported operations fail.
        // ignore: avoid_dynamic_calls
        expect(() => lhs + rhs, throwsA(anyOf(isA<NoSuchMethodError>(), isA<TypeError>())));
      });
    });

    group('IEEE 754 edge cases', () {
      test('0 Pa becomes negative infinity dB SPL', () {
        expect(0.Pa.toSoundPressureLevel().inDbSpl, double.negativeInfinity);
      });

      test('negative pressure becomes NaN dB SPL', () {
        expect((-5).Pa.toSoundPressureLevel().inDbSpl.isNaN, isTrue);
      });
    });

    group('toString and equality consistency', () {
      test('formats with unit symbol', () {
        expect(94.dBSPL.toString(), '94.0 dB SPL');
      });

      test('compareTo compares physical magnitude', () {
        expect(
          94.dBSPL.compareTo(
                const SoundPressureLevel(94, SoundPressureLevelUnit.decibelSpl),
              ),
          0,
        );
      });
    });
  });
}
