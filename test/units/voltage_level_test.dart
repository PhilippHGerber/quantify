import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  const tolerance = 1e-9;
  const dBuOffsetFromDbV = 2.218487496163563;

  group('VoltageLevel', () {
    group('Constructors and Getters', () {
      test('creates from constructor and num extensions', () {
        const fromConstructor = VoltageLevel(0, VoltageLevelUnit.dBV);
        expect(fromConstructor.value, 0.0);
        expect(fromConstructor.unit, VoltageLevelUnit.dBV);

        final fromExtension = 4.dBu;
        expect(fromExtension.value, 4.0);
        expect(fromExtension.unit, VoltageLevelUnit.dBu);
      });
    });

    group('Conversions', () {
      test('0 dBu equals about -2.21845 dBV', () {
        expect(0.dBu.inDbV, closeTo(-dBuOffsetFromDbV, tolerance));
      });

      test('0 dBV equals about 2.21845 dBu', () {
        expect(0.dBV.inDbu, closeTo(dBuOffsetFromDbV, tolerance));
      });

      test('round trips between dBV and dBu', () {
        final original = 4.dBu;
        final roundTrip = original.asDbV.asDbu;
        expect(roundTrip.value, closeTo(original.value, tolerance));
      });

      test('bridges between linear voltage and explicit logarithmic references', () {
        expect(
          VoltageLevel.fromVoltage(1.V, unit: VoltageLevelUnit.dBV).inDbV,
          closeTo(0.0, tolerance),
        );
        expect(
          1.V.toVoltageLevel(VoltageLevelUnit.dBu).inDbu,
          closeTo(dBuOffsetFromDbV, tolerance),
        );
        expect(
          VoltageLevel.fromVoltage(0.7745966692414834.V, unit: VoltageLevelUnit.dBu).inDbu,
          closeTo(0.0, tolerance),
        );
      });

      test('bridges back to linear voltage in the requested unit', () {
        expect(0.dBV.toVoltage().inVolts, closeTo(1.0, tolerance));
        expect(0.dBu.asVoltageIn(VoltageUnit.millivolt).value, closeTo(774.5966692414834, 1e-6));
        expect(
          6.dBV.asVoltage(targetUnit: VoltageUnit.millivolt).value,
          closeTo(1995.2623149688795, 1e-6),
        );
      });
    });

    group('Operator safety', () {
      test('VoltageLevel + LevelRatio calculates accurately', () {
        final result = 0.dBV + 6.dB;
        expect(result.unit, VoltageLevelUnit.dBV);
        expect(result.inDbV, closeTo(6.0, tolerance));
      });

      test('VoltageLevel + LevelRatio preserves dBu directly', () {
        final result = 4.dBu + 6.dB;
        expect(result.unit, VoltageLevelUnit.dBu);
        expect(result.inDbu, closeTo(10.0, tolerance));
      });

      test('VoltageLevel.subtract(LevelRatio) calculates accurately', () {
        final result = 4.dBu.subtract(3.dB);
        expect(result.unit, VoltageLevelUnit.dBu);
        expect(result.inDbu, closeTo(1.0, tolerance));
      });

      test('VoltageLevel - VoltageLevel returns LevelRatio', () {
        final gain = 4.dBu - (-2).dBu;
        expect(gain.unit, LevelRatioUnit.decibel);
        expect(gain.inDecibel, closeTo(6.0, tolerance));
      });

      test('VoltageLevel + VoltageLevel is not available generically', () {
        final dynamic lhs = 0.dBV;
        final dynamic rhs = 4.dBu;
        // This intentionally uses dynamic to assert unsupported operations fail.
        // ignore: avoid_dynamic_calls
        expect(() => lhs + rhs, throwsA(anyOf(isA<NoSuchMethodError>(), isA<TypeError>())));
      });
    });

    group('toString and equality consistency', () {
      test('formats with unit symbol', () {
        expect(0.dBV.toString(), '0.0 dBV');
        expect(4.dBu.toString(), '4.0 dBu');
      });

      test('equality is strict on stored unit and value', () {
        expect(
          const VoltageLevel(0, VoltageLevelUnit.dBV),
          const VoltageLevel(0, VoltageLevelUnit.dBV),
        );
        expect(0.dBV == const VoltageLevel(dBuOffsetFromDbV, VoltageLevelUnit.dBu), isFalse);
      });

      test('compareTo compares physical magnitude across units', () {
        expect(
          0.dBV.compareTo(const VoltageLevel(dBuOffsetFromDbV, VoltageLevelUnit.dBu)),
          0,
        );
      });
    });
  });
}
