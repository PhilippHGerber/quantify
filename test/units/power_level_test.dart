import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  const tolerance = 1e-9;

  group('PowerLevel', () {
    group('Constructors and Getters', () {
      test('creates from constructor and num extensions', () {
        const fromConstructor = PowerLevel(20, PowerLevelUnit.dBm);
        expect(fromConstructor.value, 20.0);
        expect(fromConstructor.unit, PowerLevelUnit.dBm);

        final fromExtension = (-10).dBW;
        expect(fromExtension.value, -10.0);
        expect(fromExtension.unit, PowerLevelUnit.dBW);
      });
    });

    group('Conversions', () {
      test('20 dBm equals -10 dBW', () {
        expect(20.dBm.inDbW, closeTo(-10.0, tolerance));
      });

      test('0 dBW equals 30 dBm', () {
        expect(0.dBW.inDbm, closeTo(30.0, tolerance));
      });

      test('round trips between dBm and dBW', () {
        final original = 12.5.dBm;
        final roundTrip = original.asDbW.asDbm;
        expect(roundTrip.value, closeTo(original.value, tolerance));
      });

      test('bridges between linear power and explicit logarithmic references', () {
        expect(PowerLevel.fromPower(1.mW, unit: PowerLevelUnit.dBm).inDbm, closeTo(0.0, tolerance));
        expect(1.W.toPowerLevel(PowerLevelUnit.dBm).inDbm, closeTo(30.0, tolerance));
        expect(PowerLevel.fromPower(1.W, unit: PowerLevelUnit.dBW).inDbW, closeTo(0.0, tolerance));
      });

      test('bridges back to linear power in the requested unit', () {
        expect(20.dBm.toPower().inWatts, closeTo(0.1, tolerance));
        expect(20.dBm.asPowerIn(PowerUnit.milliwatt).value, closeTo(100.0, tolerance));
        expect(0.dBW.asPower(targetUnit: PowerUnit.milliwatt).value, closeTo(1000.0, tolerance));
      });
    });

    group('Operator safety', () {
      test('PowerLevel + LevelRatio calculates accurately', () {
        final result = 20.dBm + 3.dB;
        expect(result.unit, PowerLevelUnit.dBm);
        expect(result.inDbm, closeTo(23.0, tolerance));
      });

      test('PowerLevel + LevelRatio preserves dBW directly', () {
        final result = (-10).dBW + 3.dB;
        expect(result.unit, PowerLevelUnit.dBW);
        expect(result.inDbW, closeTo(-7.0, tolerance));
      });

      test('PowerLevel.subtract(LevelRatio) calculates accurately', () {
        final result = 20.dBm.subtract(6.dB);
        expect(result.unit, PowerLevelUnit.dBm);
        expect(result.inDbm, closeTo(14.0, tolerance));
      });

      test('PowerLevel.subtract(LevelRatio) preserves dBW directly', () {
        final result = (-10).dBW.subtract(6.dB);
        expect(result.unit, PowerLevelUnit.dBW);
        expect(result.inDbW, closeTo(-16.0, tolerance));
      });

      test('PowerLevel - PowerLevel returns LevelRatio', () {
        final pathLoss = 20.dBm - (-80).dBm;
        expect(pathLoss.unit, LevelRatioUnit.decibel);
        expect(pathLoss.inDecibel, closeTo(100.0, tolerance));
      });

      test('PowerLevel + PowerLevel is not available generically', () {
        final dynamic lhs = 20.dBm;
        final dynamic rhs = 3.dBW;
        // This intentionally uses dynamic to assert unsupported operations fail.
        // ignore: avoid_dynamic_calls
        expect(() => lhs + rhs, throwsA(anyOf(isA<NoSuchMethodError>(), isA<TypeError>())));
      });
    });

    group('toString and equality consistency', () {
      test('formats with unit symbol', () {
        expect(20.dBm.toString(), '20.0 dBm');
        expect((-10).dBW.toString(), '-10.0 dBW');
      });

      test('equality is strict on stored unit and value', () {
        expect(const PowerLevel(20, PowerLevelUnit.dBm), const PowerLevel(20, PowerLevelUnit.dBm));
        expect(20.dBm == const PowerLevel(-10, PowerLevelUnit.dBW), isFalse);
      });

      test('compareTo compares physical magnitude across units', () {
        expect(20.dBm.compareTo(const PowerLevel(-10, PowerLevelUnit.dBW)), 0);
      });
    });
  });
}
