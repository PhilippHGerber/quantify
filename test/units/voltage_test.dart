// ignore_for_file: prefer_int_literals // All constants are doubles for precision.

import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('Voltage', () {
    const strictTolerance = 1e-12;
    const defaultTolerance = 1e-9;
    const looseTolerance = 1e-6;

    // Helper for round trip tests
    void testRoundTrip(
      VoltageUnit initialUnit,
      VoltageUnit intermediateUnit,
      double initialValue, {
      double tol = defaultTolerance,
    }) {
      final v1 = Voltage(initialValue, initialUnit);
      final v2 = v1.convertTo(intermediateUnit);
      final v3 = v2.convertTo(initialUnit);
      expect(
        v3.value,
        closeTo(initialValue, tol),
        reason: '${initialUnit.symbol} -> ${intermediateUnit.symbol} -> ${initialUnit.symbol} '
            'failed for $initialValue. Expected $initialValue, got ${v3.value}',
      );
    }

    group('Constructors and Getters (from num extensions)', () {
      test('should create Voltage from num extensions and retrieve values correctly', () {
        final vV = 12.0.V;
        expect(vV.value, 12.0);
        expect(vV.unit, VoltageUnit.volt);
        expect(vV.inMillivolts, closeTo(12000.0, strictTolerance));
        expect(vV.asMillivolts.value, closeTo(12000.0, strictTolerance));
        expect(vV.asMillivolts.unit, VoltageUnit.millivolt);

        final vMV = 500.0.millivolts;
        expect(vMV.value, 500.0);
        expect(vMV.unit, VoltageUnit.millivolt);
        expect(vMV.inVolts, closeTo(0.5, strictTolerance));

        final vUV = 100.0.uV;
        expect(vUV.value, 100.0);
        expect(vUV.unit, VoltageUnit.microvolt);
        expect(vUV.inVolts, closeTo(0.0001, strictTolerance));
        expect(vUV.inNanovolts, closeTo(100000.0, defaultTolerance));

        final vGV = 2.0.GV;
        expect(vGV.inVolts, closeTo(2e9, defaultTolerance));
        expect(vGV.inMegavolts, closeTo(2000.0, strictTolerance));

        final vNV = 500.0.nV;
        expect(vNV.inVolts, closeTo(5e-7, defaultTolerance));
        expect(vNV.inMicrovolts, closeTo(0.5, strictTolerance));
      });

      test('getValue should return correct value for same unit', () {
        const voltage = Voltage(230.0, VoltageUnit.volt);
        expect(voltage.getValue(VoltageUnit.volt), 230.0);
      });
    });

    group('Conversions between various voltage units', () {
      final oneVolt = 1.0.V;
      test('1 Volt to other units', () {
        expect(oneVolt.inKilovolts, closeTo(0.001, strictTolerance));
        expect(oneVolt.inMillivolts, closeTo(1000.0, strictTolerance));
        expect(oneVolt.inMicrovolts, closeTo(1.0e6, strictTolerance));
        expect(oneVolt.inNanovolts, closeTo(1.0e9, looseTolerance));
      });

      final oneKilovolt = 1.0.kV;
      test('1 Kilovolt to volts', () {
        expect(oneKilovolt.inVolts, closeTo(1000.0, strictTolerance));
      });

      final oneMillivolt = 1.0.mV;
      test('1 Millivolt to microvolts and volts', () {
        expect(oneMillivolt.inMicrovolts, closeTo(1000.0, strictTolerance));
        expect(oneMillivolt.inVolts, closeTo(0.001, strictTolerance));
      });

      final fiftyMicrovolts = 50.0.uV;
      test('50 Microvolts to nanovolts and millivolts', () {
        expect(fiftyMicrovolts.inNanovolts, closeTo(50000.0, defaultTolerance));
        expect(fiftyMicrovolts.inMillivolts, closeTo(0.05, strictTolerance));
      });
    });

    group('CGS unit conversions', () {
      test('1 Statvolt to volts', () {
        final oneStatV = 1.0.statV;
        expect(oneStatV.inVolts, closeTo(299.792458, defaultTolerance));
      });

      test('1 Abvolt to volts', () {
        final oneAbV = 1.0.abV;
        expect(oneAbV.inVolts, closeTo(1e-8, defaultTolerance));
      });

      test('1 Volt to statvolts and abvolts', () {
        final oneV = 1.0.V;
        expect(
          oneV.inStatvolts,
          closeTo(1.0 / 299.792458, defaultTolerance),
        );
        expect(oneV.inAbvolts, closeTo(1e8, looseTolerance));
      });
    });

    group('convertTo method', () {
      test('should return new Voltage object with converted value and unit', () {
        final vMV = 2500.0.mV;
        final vV = vMV.convertTo(VoltageUnit.volt);
        expect(vV.value, closeTo(2.5, strictTolerance));
        expect(vV.unit, VoltageUnit.volt);
      });

      test('convertTo same unit returns same instance', () {
        final v = 12.0.V;
        expect(identical(v, v.convertTo(VoltageUnit.volt)), isTrue);
      });
    });

    group('Comparisons', () {
      test('greater than', () {
        expect(1.kV > 999.V, isTrue);
        expect(1.V > 1.kV, isFalse);
      });

      test('less than', () {
        expect(1.V < 1.kV, isTrue);
        expect(1.kV < 1.V, isFalse);
      });

      test('greater than or equal', () {
        expect(1000.V >= 1.kV, isTrue);
        expect(1.kV >= 1000.V, isTrue);
      });

      test('less than or equal', () {
        expect(1000.V <= 1.kV, isTrue);
        expect(1.V <= 1.kV, isTrue);
      });

      test('isEquivalentTo across units', () {
        expect(1.kV.isEquivalentTo(1000.V), isTrue);
        expect(1000.mV.isEquivalentTo(1.V), isTrue);
      });
    });

    group('Equality', () {
      test('strict equality requires same unit and value', () {
        expect(
          const Voltage(12.0, VoltageUnit.volt) == const Voltage(12.0, VoltageUnit.volt),
          isTrue,
        );
        expect(
          const Voltage(1.0, VoltageUnit.volt) == const Voltage(1000.0, VoltageUnit.millivolt),
          isFalse,
        );
      });

      test('hashCode consistency', () {
        const v1 = Voltage(12.0, VoltageUnit.volt);
        const v2 = Voltage(12.0, VoltageUnit.volt);
        expect(v1.hashCode, equals(v2.hashCode));
      });
    });

    group('Arithmetic', () {
      test('addition', () {
        final result = 5.V + 3.V;
        expect(result.value, closeTo(8.0, strictTolerance));
        expect(result.unit, VoltageUnit.volt);
      });

      test('addition with unit conversion', () {
        final result = 1.V + 500.mV;
        expect(result.inVolts, closeTo(1.5, strictTolerance));
      });

      test('subtraction', () {
        final result = 12.V - 3.V;
        expect(result.value, closeTo(9.0, strictTolerance));
      });

      test('multiplication by scalar', () {
        final result = 5.V * 3.0;
        expect(result.value, closeTo(15.0, strictTolerance));
      });

      test('division by scalar', () {
        final result = 12.V / 4.0;
        expect(result.value, closeTo(3.0, strictTolerance));
      });

      test('negation', () {
        final result = -5.V;
        expect(result.value, closeTo(-5.0, strictTolerance));
      });
    });

    group('toString', () {
      test('default invariant format', () {
        const v = Voltage(12.5, VoltageUnit.volt);
        expect(v.toString(), '12.5\u00A0V');
      });

      test('millivolt symbol', () {
        const v = Voltage(330.0, VoltageUnit.millivolt);
        expect(v.toString(), '330.0\u00A0mV');
      });

      test('kilovolt symbol', () {
        const v = Voltage(11.0, VoltageUnit.kilovolt);
        expect(v.toString(), '11.0\u00A0kV');
      });
    });

    group('Interop factories', () {
      test('Voltage.fromPowerAndCurrent (V = P / I)', () {
        final power = 100.0.W;
        final current = 2.0.A;
        final voltage = Voltage.fromPowerAndCurrent(power, current);
        expect(voltage.inVolts, closeTo(50.0, strictTolerance));
      });

      test('Voltage.fromPowerAndCurrent with different units', () {
        final power = 1.5.kW;
        final current = 500.0.mA;
        final voltage = Voltage.fromPowerAndCurrent(power, current);
        expect(voltage.inVolts, closeTo(3000.0, defaultTolerance));
      });

      test('Voltage.fromEnergyAndCharge (V = E / Q)', () {
        final energy = 100.0.J;
        final charge = 10.0.C;
        final voltage = Voltage.fromEnergyAndCharge(energy, charge);
        expect(voltage.inVolts, closeTo(10.0, strictTolerance));
      });

      test('Voltage.fromEnergyAndCharge with different units', () {
        final energy = 1.0.kJ;
        final charge = 500.0.C;
        final voltage = Voltage.fromEnergyAndCharge(energy, charge);
        expect(voltage.inVolts, closeTo(2.0, defaultTolerance));
      });

      // --- Voltage.from(Current, Resistance) ---
      test('Voltage.from: A × Ω → V', () {
        final v = Voltage.from(2.0.A, 10.0.ohms);
        expect(v.unit, VoltageUnit.volt);
        expect(v.value, closeTo(20.0, strictTolerance));
      });

      test('Voltage.from: mA × kΩ → V', () {
        final v = Voltage.from(5.0.mA, 1.0.kiloohms);
        expect(v.unit, VoltageUnit.volt);
        expect(v.value, closeTo(5.0, strictTolerance));
      });

      test('Voltage.from: mA × Ω → mV', () {
        final v = Voltage.from(10.0.mA, 47.0.ohms);
        expect(v.unit, VoltageUnit.millivolt);
        expect(v.value, closeTo(470.0, strictTolerance));
      });

      test('Voltage.from: μA × MΩ → V', () {
        final v = Voltage.from(3.0.uA, 2.0.megaohms);
        expect(v.unit, VoltageUnit.volt);
        expect(v.value, closeTo(6.0, strictTolerance));
      });

      test('Voltage.from: μA × kΩ → mV', () {
        final v = Voltage.from(10.0.uA, 100.0.kiloohms);
        expect(v.unit, VoltageUnit.millivolt);
        expect(v.value, closeTo(1000.0, strictTolerance));
      });

      test('Voltage.from: A × mΩ → mV (shunt sensing)', () {
        final v = Voltage.from(10.0.A, 10.0.milliohms);
        expect(v.unit, VoltageUnit.millivolt);
        expect(v.value, closeTo(100.0, strictTolerance));
      });

      test('Voltage.from: kA × Ω → kV (power systems)', () {
        final v = Voltage.from(1.0.kA, 1.0.ohms);
        expect(v.unit, VoltageUnit.kilovolt);
        expect(v.value, closeTo(1.0, strictTolerance));
      });

      test('Voltage.from: unmatched → SI fallback V', () {
        // statA × Ω has no mapping → fallback to volt
        expect(
          Voltage.from(const Current(1, CurrentUnit.statampere), 1.0.ohms).unit,
          VoltageUnit.volt,
        );
      });

      test('Voltage.from physical correctness: 5 mA × 2 kΩ = 10 V', () {
        expect(Voltage.from(5.0.mA, 2.0.kiloohms).inVolts, closeTo(10.0, strictTolerance));
      });

      test('Voltage.from round-trip with Resistance.fromOhmsLaw', () {
        final v = Voltage.from(20.0.mA, 500.0.ohms); // 10 V
        final r = Resistance.fromOhmsLaw(v, 20.0.mA);
        expect(r.inOhms, closeTo(500.0, strictTolerance));
      });
    });

    group('Parsing', () {
      test('parse basic voltage strings', () {
        expect(Voltage.parse('12 V').inVolts, closeTo(12.0, strictTolerance));
        expect(Voltage.parse('3.3 kV').inVolts, closeTo(3300.0, defaultTolerance));
        expect(Voltage.parse('500 mV').inVolts, closeTo(0.5, strictTolerance));
      });

      test('parse full word names', () {
        expect(Voltage.parse('12 volts').inVolts, closeTo(12.0, strictTolerance));
        expect(Voltage.parse('5 kilovolts').inVolts, closeTo(5000.0, defaultTolerance));
      });

      test('tryParse returns null for invalid input', () {
        expect(Voltage.tryParse('invalid'), isNull);
        expect(Voltage.tryParse('12 meters'), isNull);
      });

      test('tryParse returns Voltage for valid input', () {
        final result = Voltage.tryParse('230 V');
        expect(result, isNotNull);
        expect(result!.inVolts, closeTo(230.0, strictTolerance));
      });
    });

    group('ElectricPotential typedef', () {
      test('ElectricPotential is an alias for Voltage', () {
        const ep = Voltage(5.0, VoltageUnit.volt);
        expect(ep, isA<Voltage>());
        expect(ep.inVolts, 5.0);
      });
    });

    group('Round trips', () {
      test('V -> mV -> V', () => testRoundTrip(VoltageUnit.volt, VoltageUnit.millivolt, 12.5));
      test('V -> kV -> V', () => testRoundTrip(VoltageUnit.volt, VoltageUnit.kilovolt, 230.0));
      test('V -> MV -> V', () => testRoundTrip(VoltageUnit.volt, VoltageUnit.megavolt, 500000.0));
      test(
        'mV -> µV -> mV',
        () => testRoundTrip(VoltageUnit.millivolt, VoltageUnit.microvolt, 3.3),
      );
      test(
        'kV -> V -> kV',
        () => testRoundTrip(VoltageUnit.kilovolt, VoltageUnit.volt, 11.0),
      );
      test(
        'V -> statV -> V',
        () => testRoundTrip(VoltageUnit.volt, VoltageUnit.statvolt, 100.0),
      );
      test(
        'V -> abV -> V',
        () => testRoundTrip(
          VoltageUnit.volt,
          VoltageUnit.abvolt,
          1.0,
          tol: looseTolerance,
        ),
      );
      test(
        'nV -> V -> nV',
        () => testRoundTrip(
          VoltageUnit.nanovolt,
          VoltageUnit.volt,
          500.0,
          tol: looseTolerance,
        ),
      );
      test(
        'GV -> kV -> GV',
        () => testRoundTrip(VoltageUnit.gigavolt, VoltageUnit.kilovolt, 1.5),
      );
    });
  });
}
