// test/units/power_test.dart

import 'package:quantify/angular_velocity.dart';
import 'package:quantify/current.dart';
import 'package:quantify/energy.dart';
import 'package:quantify/power.dart';
import 'package:quantify/resistance.dart';
import 'package:quantify/time.dart';
import 'package:quantify/torque.dart';
import 'package:quantify/voltage.dart';
import 'package:test/test.dart';

void main() {
  group('Power', () {
    const strictTolerance = 1e-12;
    const defaultTolerance = 1e-9;

    // Helper for round trip tests
    void testRoundTrip(
      PowerUnit initialUnit,
      PowerUnit intermediateUnit,
      double initialValue, {
      double tol = defaultTolerance,
    }) {
      final p1 = Power(initialValue, initialUnit);
      final p2 = p1.convertTo(intermediateUnit);
      final p3 = p2.convertTo(initialUnit);
      expect(
        p3.value,
        closeTo(initialValue, tol),
        reason:
            '${initialUnit.symbol} -> ${intermediateUnit.symbol} -> ${initialUnit.symbol} failed for $initialValue',
      );
    }

    group('Constructors and Getters', () {
      test('should create Power from num extensions and retrieve values', () {
        final p1 = 150.0.kW;
        expect(p1.value, 150.0);
        expect(p1.unit, PowerUnit.kilowatt);
        expect(p1.inWatts, closeTo(150000.0, strictTolerance));
        expect(p1.inMegawatts, closeTo(0.15, strictTolerance));
      });

      test('should create from all new units', () {
        final pMw = 500.MW;
        expect(pMw.inWatts, closeTo(500e6, strictTolerance));

        final pGw = 1.2.GW;
        expect(pGw.inMegawatts, closeTo(1200.0, strictTolerance));

        final pMetricHp = 100.0.metricHp;
        expect(pMetricHp.inWatts, closeTo(73549.875, defaultTolerance));

        final pBtu = 1000.0.btuPerHour;
        expect(pBtu.inWatts, closeTo(293.071, 1e-3));

        final pErg = 1e7.ergPerSecond; // Should be 1 Watt
        expect(pErg.inWatts, closeTo(1.0, defaultTolerance));
      });
    });

    group('Conversions', () {
      test('Horsepower (hp) vs Metric Horsepower (PS)', () {
        final mechHp = 1.0.hp;
        final metricHp = 1.0.metricHp;

        // Mechanical hp should be slightly more powerful than metric hp
        expect(mechHp.compareTo(metricHp), greaterThan(0));
        expect(mechHp.inWatts, closeTo(745.7, 1e-1));
        expect(metricHp.inWatts, closeTo(735.5, 1e-1));
      });

      test('Kilowatt to Horsepower and BTU/h', () {
        final oneKw = 1.0.kW;
        expect(oneKw.inHorsepower, closeTo(1.341, 1e-3));
        expect(oneKw.inMetricHorsepower, closeTo(1.360, 1e-3));
        expect(oneKw.inBtuPerHour, closeTo(3412.14, 1e-2));
      });
    });

    group('Comparison', () {
      test('should correctly compare different units', () {
        final p1 = 100.kW;
        final p2 = 0.1.MW;
        final p3 = 134.hp; // approx 99.9 kW

        expect(p1.compareTo(p2), 0);
        expect(p1.compareTo(p3), greaterThan(0));
        expect(p3.compareTo(p1), lessThan(0));
      });
    });

    group('Arithmetic', () {
      test('should perform addition and subtraction correctly', () {
        final sum = 1.kW + 500.W; // 1000 W + 500 W = 1500 W
        expect(sum.inKilowatts, closeTo(1.5, defaultTolerance));
        expect(sum.unit, PowerUnit.kilowatt);
      });

      test('should perform scalar multiplication and division', () {
        final power = 20.hp;
        expect((power * 3.0).inHorsepower, closeTo(60.0, defaultTolerance));
        expect((power / 2.0).inHorsepower, closeTo(10.0, defaultTolerance));
        expect((power / 0).value, double.infinity);
      });
    });

    group('Round Trip Conversions', () {
      for (final unit in PowerUnit.values) {
        test('Round trip ${unit.symbol} <-> W', () {
          testRoundTrip(unit, PowerUnit.watt, 123.456);
        });
      }
    });

    group('Practical Examples', () {
      test('Car Engine Power', () {
        // A car engine is rated at 250 PS.
        final enginePower = 250.0.metricHp;
        // Check its equivalent in mechanical horsepower and kilowatts.
        expect(enginePower.inHorsepower, closeTo(246.6, 1e-1));
        expect(enginePower.inKilowatts, closeTo(183.9, 1e-1));
      });

      test('HVAC System', () {
        // A home AC unit has a cooling capacity of 12,000 Btu/h.
        final acPower = 12000.0.btuPerHour;
        // Check its power consumption in kilowatts.
        expect(acPower.inKilowatts, closeTo(3.516, 1e-3));
      });
    });

    group('Comprehensive Extension Coverage', () {
      test('all creation extension aliases', () {
        expect(50.W.unit, PowerUnit.watt);
        expect(50.watts.unit, PowerUnit.watt);
        expect(100.kilowatts.unit, PowerUnit.kilowatt);
        expect(5.MW.unit, PowerUnit.megawatt);
        expect(5.megawatts.unit, PowerUnit.megawatt);
        expect(1.GW.unit, PowerUnit.gigawatt);
        expect(1.gigawatts.unit, PowerUnit.gigawatt);
        expect(500.milliwatts.unit, PowerUnit.milliwatt);
        expect(500.milliwatts.inWatts, closeTo(0.5, defaultTolerance));
      });

      test('all as* conversion getters', () {
        final p = 1000.W;

        final asW = p.asWatts;
        expect(asW.unit, PowerUnit.watt);
        expect(asW.value, closeTo(1000.0, defaultTolerance));

        final asMw = p.asMilliwatts;
        expect(asMw.unit, PowerUnit.milliwatt);
        expect(asMw.value, closeTo(1e6, defaultTolerance));

        final asKw = p.asKilowatts;
        expect(asKw.unit, PowerUnit.kilowatt);
        expect(asKw.value, closeTo(1.0, defaultTolerance));

        final asMW = p.asMegawatts;
        expect(asMW.unit, PowerUnit.megawatt);
        expect(asMW.value, closeTo(0.001, defaultTolerance));

        final asGW = p.asGigawatts;
        expect(asGW.unit, PowerUnit.gigawatt);
        expect(asGW.value, closeTo(1e-6, defaultTolerance));

        final asHp = p.asHorsepower;
        expect(asHp.unit, PowerUnit.horsepower);
        expect(asHp.value, closeTo(1.341, 1e-3));

        final asMetricHp = p.asMetricHorsepower;
        expect(asMetricHp.unit, PowerUnit.metricHorsepower);
        expect(asMetricHp.value, closeTo(1.360, 1e-3));

        final asBtu = p.asBtuPerHour;
        expect(asBtu.unit, PowerUnit.btuPerHour);
        expect(asBtu.value, closeTo(3412.14, 1e-2));

        final asErg = p.asErgPerSecond;
        expect(asErg.unit, PowerUnit.ergPerSecond);
        expect(asErg.value, closeTo(1e10, defaultTolerance));
      });
    });
  });

  group('Dimensional Analysis (Power.from)', () {
    const tolerance = 1e-9;

    test('P = E / t: 3 600 000 J over 1 h = 1 000 W', () {
      expect(Power.from(1.kWh, 1.hours).inWatts, closeTo(1000.0, tolerance));
    });

    test('result unit is kilowatt for kWh + h', () {
      expect(Power.from(1.kWh, 1.hours).unit, PowerUnit.kilowatt);
    });

    test('result unit is watt for Wh + h', () {
      expect(Power.from(500.Wh, 2.hours).unit, PowerUnit.watt);
      expect(Power.from(500.Wh, 2.hours).value, closeTo(250.0, tolerance));
    });

    test('P = E / t with seconds', () {
      // 100 J / 10 s = 10 W
      expect(
        Power.from(const Energy(100, EnergyUnit.joule), const Time(10, TimeUnit.second)).inWatts,
        closeTo(10.0, tolerance),
      );
    });

    test('nanowatt/microwatt/terawatt extensions', () {
      const tol = 1e-9;
      // Creation
      expect(1.0.nW.unit, PowerUnit.nanowatt);
      expect(1.0.nanowatts.unit, PowerUnit.nanowatt);
      expect(1.0.uW.unit, PowerUnit.microwatt);
      expect(1.0.microwatts.unit, PowerUnit.microwatt);
      expect(1.0.TW.unit, PowerUnit.terawatt);
      expect(1.0.terawatts.unit, PowerUnit.terawatt);

      // inX getters
      expect(1.0.W.inNanowatts, closeTo(1e9, 1.0));
      expect(1.0.W.inMicrowatts, closeTo(1e6, tol));
      expect(1e12.W.inTerawatts, closeTo(1.0, tol));

      // asX getters
      expect(1.0.W.asNanowatts.unit, PowerUnit.nanowatt);
      expect(1.0.W.asNanowatts.value, closeTo(1e9, 1.0));
      expect(1.0.W.asMicrowatts.unit, PowerUnit.microwatt);
      expect(1.0.W.asMicrowatts.value, closeTo(1e6, tol));
      expect(1e12.W.asTerawatts.unit, PowerUnit.terawatt);
      expect(1e12.W.asTerawatts.value, closeTo(1.0, tol));
    });

    test('inverse of Energy.from: Power.from(Energy.from(p, t), t) ≈ p', () {
      const original = Power(500, PowerUnit.watt);
      const duration = Time(60, TimeUnit.second);
      final energy = Energy.from(original, duration);
      final recovered = Power.from(energy, duration);
      expect(recovered.inWatts, closeTo(500.0, tolerance));
    });

    test('Energy / Power = Time', () {
      final power = 1000.W;
      final energy = 1.kWh; // 3,600,000 J
      final time = power.timeFor(energy);
      expect(time.inHours, closeTo(1.0, tolerance));

      expect(0.W.timeFor(100.J).inSeconds, double.infinity);
      expect(0.W.timeFor(0.J).inSeconds, isNaN);
    });

    // --- Unit-preserving behaviour ---
    test('Power.from: J + s → W', () {
      final p = Power.from(100.J, 10.s);
      expect(p.unit, PowerUnit.watt);
      expect(p.value, closeTo(10.0, tolerance));
    });

    test('Power.from: kWh + h → kW', () {
      final p = Power.from(1.kWh, 1.hours);
      expect(p.unit, PowerUnit.kilowatt);
      expect(p.value, closeTo(1.0, tolerance));
    });

    test('Power.from: BTU + h → BTU/h', () {
      final p = Power.from(const Energy(5000, EnergyUnit.btu), 1.hours);
      expect(p.unit, PowerUnit.btuPerHour);
      expect(p.value, closeTo(5000.0, tolerance));
    });

    test('Power.from: unmatched → SI fallback W', () {
      expect(Power.from(1.kJ, 1.minutes).unit, PowerUnit.watt);
    });

    test('Power.from physical correctness: 1 kWh / 1 h ≈ 1000 W', () {
      expect(Power.from(1.kWh, 1.hours).inWatts, closeTo(1000.0, tolerance));
    });

    test('fromTorqueAndAngularVelocity: 400 Nm at 3000 rpm ≈ 125.66 kW', () {
      final enginePower = Power.fromTorqueAndAngularVelocity(400.Nm, 3000.rpm);
      expect(enginePower.unit, PowerUnit.watt);
      expect(enginePower.inKilowatts, closeTo(125.663706, 1e-6));
    });

    test('fromTorqueAndAngularVelocity: zero torque gives zero power', () {
      final power = Power.fromTorqueAndAngularVelocity(0.Nm, 3000.rpm);
      expect(power.inWatts, closeTo(0.0, tolerance));
    });

    test('fromTorqueAndAngularVelocity preserves sign', () {
      final power = Power.fromTorqueAndAngularVelocity((-10).Nm, 2.radiansPerSecond);
      expect(power.inWatts, closeTo(-20.0, tolerance));
    });

    test('timeFor: BTU/h for 5000 BTU → 1 h', () {
      final t = const Power(5000, PowerUnit.btuPerHour).timeFor(const Energy(5000, EnergyUnit.btu));
      expect(t.unit, TimeUnit.hour);
      expect(t.value, closeTo(1.0, 1e-6));
    });

    test('timeFor: W → result in seconds', () {
      final t = 1000.W.timeFor(3600.kJ);
      expect(t.unit, TimeUnit.second);
      expect(t.inHours, closeTo(1.0, 1e-6));
    });
  });

  group('Electrical Power factories', () {
    const tol = 1e-9;

    // --- Power.fromVoltageAndCurrent (P = V × I) ---
    test('fromVoltageAndCurrent: V × A → W', () {
      final p = Power.fromVoltageAndCurrent(12.0.V, 2.0.A);
      expect(p.unit, PowerUnit.watt);
      expect(p.value, closeTo(24.0, tol));
    });

    test('fromVoltageAndCurrent: V × mA → mW', () {
      final p = Power.fromVoltageAndCurrent(5.0.V, 200.0.mA);
      expect(p.unit, PowerUnit.milliwatt);
      expect(p.value, closeTo(1000.0, tol));
    });

    test('fromVoltageAndCurrent: kV × A → kW', () {
      final p = Power.fromVoltageAndCurrent(1.0.kV, 10.0.A);
      expect(p.unit, PowerUnit.kilowatt);
      expect(p.value, closeTo(10.0, tol));
    });

    test('fromVoltageAndCurrent: kV × kA → MW', () {
      final p = Power.fromVoltageAndCurrent(20.0.kV, 5.0.kA);
      expect(p.unit, PowerUnit.megawatt);
      expect(p.value, closeTo(100.0, tol));
    });

    test('fromVoltageAndCurrent: unmatched → SI fallback W', () {
      expect(
        Power.fromVoltageAndCurrent(
          const Voltage(1, VoltageUnit.statvolt),
          1.0.A,
        ).unit,
        PowerUnit.watt,
      );
    });

    test('fromVoltageAndCurrent physical correctness: 230 V × 10 A = 2300 W', () {
      expect(
        Power.fromVoltageAndCurrent(230.0.V, 10.0.A).inWatts,
        closeTo(2300.0, tol),
      );
    });

    // --- Power.fromCurrentAndResistance (P = I² × R) ---
    test('fromCurrentAndResistance: A × Ω → W', () {
      final p = Power.fromCurrentAndResistance(2.0.A, 50.0.ohms);
      expect(p.unit, PowerUnit.watt);
      expect(p.value, closeTo(200.0, tol));
    });

    test('fromCurrentAndResistance: mA × kΩ → mW', () {
      final p = Power.fromCurrentAndResistance(10.0.mA, 1.0.kiloohms);
      expect(p.unit, PowerUnit.milliwatt);
      expect(p.value, closeTo(100.0, tol));
    });

    test('fromCurrentAndResistance: kA × Ω → MW', () {
      final p = Power.fromCurrentAndResistance(1.0.kA, 1.0.ohms);
      expect(p.unit, PowerUnit.megawatt);
      expect(p.value, closeTo(1.0, tol));
    });

    test('fromCurrentAndResistance physical correctness: 3 A × 10 Ω = 90 W', () {
      expect(
        Power.fromCurrentAndResistance(3.0.A, 10.0.ohms).inWatts,
        closeTo(90.0, tol),
      );
    });

    // --- Power.fromVoltageAndResistance (P = V² / R) ---
    test('fromVoltageAndResistance: V × Ω → W', () {
      final p = Power.fromVoltageAndResistance(10.0.V, 50.0.ohms);
      expect(p.unit, PowerUnit.watt);
      expect(p.value, closeTo(2.0, tol));
    });

    test('fromVoltageAndResistance: V × kΩ → mW', () {
      final p = Power.fromVoltageAndResistance(10.0.V, 1.0.kiloohms);
      expect(p.unit, PowerUnit.milliwatt);
      expect(p.value, closeTo(100.0, tol));
    });

    test('fromVoltageAndResistance: kV × Ω → MW', () {
      final p = Power.fromVoltageAndResistance(1.0.kV, 1.0.ohms);
      expect(p.unit, PowerUnit.megawatt);
      expect(p.value, closeTo(1.0, tol));
    });

    test('fromVoltageAndResistance physical correctness: 100 V / 50 Ω = 200 W', () {
      expect(
        Power.fromVoltageAndResistance(100.0.V, 50.0.ohms).inWatts,
        closeTo(200.0, tol),
      );
    });

    // --- Additional V×I switch arms ---
    test('fromVoltageAndCurrent: V × µA → µW', () {
      final p = Power.fromVoltageAndCurrent(1.0.V, 1.0.uA);
      expect(p.unit, PowerUnit.microwatt);
      expect(p.value, closeTo(1.0, tol));
    });

    test('fromVoltageAndCurrent: V × MA → MW', () {
      final p = Power.fromVoltageAndCurrent(1.0.V, 1.0.MA);
      expect(p.unit, PowerUnit.megawatt);
      expect(p.value, closeTo(1.0, tol));
    });

    test('fromVoltageAndCurrent: mV × A → mW', () {
      final p = Power.fromVoltageAndCurrent(500.0.mV, 2.0.A);
      expect(p.unit, PowerUnit.milliwatt);
      expect(p.value, closeTo(1000.0, tol));
    });

    test('fromVoltageAndCurrent: mV × kA → W', () {
      final p = Power.fromVoltageAndCurrent(1.0.mV, 1.0.kA);
      expect(p.unit, PowerUnit.watt);
      expect(p.value, closeTo(1.0, tol));
    });

    test('fromVoltageAndCurrent: µV × A → µW', () {
      final p = Power.fromVoltageAndCurrent(1.0.uV, 1.0.A);
      expect(p.unit, PowerUnit.microwatt);
      expect(p.value, closeTo(1.0, tol));
    });

    test('fromVoltageAndCurrent: kV × mA → W', () {
      final p = Power.fromVoltageAndCurrent(1.0.kV, 1.0.mA);
      expect(p.unit, PowerUnit.watt);
      expect(p.value, closeTo(1.0, tol));
    });

    test('fromVoltageAndCurrent: MV × A → MW', () {
      final p = Power.fromVoltageAndCurrent(1.0.MV, 1.0.A);
      expect(p.unit, PowerUnit.megawatt);
      expect(p.value, closeTo(1.0, tol));
    });

    test('fromVoltageAndCurrent: MV × kA → GW', () {
      final p = Power.fromVoltageAndCurrent(1.0.MV, 1.0.kA);
      expect(p.unit, PowerUnit.gigawatt);
      expect(p.value, closeTo(1.0, tol));
    });

    test('fromVoltageAndCurrent: GV × A → GW', () {
      final p = Power.fromVoltageAndCurrent(1.0.GV, 1.0.A);
      expect(p.unit, PowerUnit.gigawatt);
      expect(p.value, closeTo(1.0, tol));
    });

    // --- Additional I²R switch arms ---
    test('fromCurrentAndResistance: A × mΩ → mW', () {
      final p = Power.fromCurrentAndResistance(1.0.A, 1.0.milliohms);
      expect(p.unit, PowerUnit.milliwatt);
      expect(p.value, closeTo(1.0, tol));
    });

    test('fromCurrentAndResistance: A × MΩ → MW', () {
      final p = Power.fromCurrentAndResistance(1.0.A, 1.0.megaohms);
      expect(p.unit, PowerUnit.megawatt);
      expect(p.value, closeTo(1.0, tol));
    });

    test('fromCurrentAndResistance: mA × Ω → µW', () {
      final p = Power.fromCurrentAndResistance(1.0.mA, 1.0.ohms);
      expect(p.unit, PowerUnit.microwatt);
      expect(p.value, closeTo(1.0, tol));
    });

    test('fromCurrentAndResistance: mA × MΩ → W', () {
      final p = Power.fromCurrentAndResistance(1.0.mA, 1.0.megaohms);
      expect(p.unit, PowerUnit.watt);
      expect(p.value, closeTo(1.0, tol));
    });

    test('fromCurrentAndResistance: µA × kΩ → nW', () {
      final p = Power.fromCurrentAndResistance(1.0.uA, 1.0.kiloohms);
      expect(p.unit, PowerUnit.nanowatt);
      expect(p.value, closeTo(1.0, tol));
    });

    test('fromCurrentAndResistance: µA × MΩ → µW', () {
      final p = Power.fromCurrentAndResistance(1.0.uA, 1.0.megaohms);
      expect(p.unit, PowerUnit.microwatt);
      expect(p.value, closeTo(1.0, tol));
    });

    test('fromCurrentAndResistance: µA × GΩ → mW', () {
      final p = Power.fromCurrentAndResistance(1.0.uA, 1.0.gigaohms);
      expect(p.unit, PowerUnit.milliwatt);
      expect(p.value, closeTo(1.0, tol));
    });

    test('fromCurrentAndResistance: kA × mΩ → kW', () {
      final p = Power.fromCurrentAndResistance(1.0.kA, 1.0.milliohms);
      expect(p.unit, PowerUnit.kilowatt);
      expect(p.value, closeTo(1.0, tol));
    });

    test('fromCurrentAndResistance: unmatched → SI fallback W', () {
      // nA × Ω has no mapping → fallback to watt
      expect(
        Power.fromCurrentAndResistance(
          const Current(1, CurrentUnit.nanoampere),
          1.0.ohms,
        ).unit,
        PowerUnit.watt,
      );
    });

    // --- Additional V²/R switch arms ---
    test('fromVoltageAndResistance: V × mΩ → kW', () {
      final p = Power.fromVoltageAndResistance(1.0.V, 1.0.milliohms);
      expect(p.unit, PowerUnit.kilowatt);
      expect(p.value, closeTo(1.0, tol));
    });

    test('fromVoltageAndResistance: V × MΩ → µW', () {
      final p = Power.fromVoltageAndResistance(1.0.V, 1.0.megaohms);
      expect(p.unit, PowerUnit.microwatt);
      expect(p.value, closeTo(1.0, tol));
    });

    test('fromVoltageAndResistance: mV × Ω → µW', () {
      final p = Power.fromVoltageAndResistance(1.0.mV, 1.0.ohms);
      expect(p.unit, PowerUnit.microwatt);
      expect(p.value, closeTo(1.0, tol));
    });

    test('fromVoltageAndResistance: mV × mΩ → mW', () {
      final p = Power.fromVoltageAndResistance(1.0.mV, 1.0.milliohms);
      expect(p.unit, PowerUnit.milliwatt);
      expect(p.value, closeTo(1.0, tol));
    });

    test('fromVoltageAndResistance: mV × kΩ → nW', () {
      final p = Power.fromVoltageAndResistance(1.0.mV, 1.0.kiloohms);
      expect(p.unit, PowerUnit.nanowatt);
      expect(p.value, closeTo(1.0, tol));
    });

    test('fromVoltageAndResistance: kV × kΩ → kW', () {
      final p = Power.fromVoltageAndResistance(1.0.kV, 1.0.kiloohms);
      expect(p.unit, PowerUnit.kilowatt);
      expect(p.value, closeTo(1.0, tol));
    });

    test('fromVoltageAndResistance: kV × MΩ → W', () {
      final p = Power.fromVoltageAndResistance(1.0.kV, 1.0.megaohms);
      expect(p.unit, PowerUnit.watt);
      expect(p.value, closeTo(1.0, tol));
    });

    test('fromVoltageAndResistance: kV × GΩ → mW', () {
      final p = Power.fromVoltageAndResistance(1.0.kV, 1.0.gigaohms);
      expect(p.unit, PowerUnit.milliwatt);
      expect(p.value, closeTo(1.0, tol));
    });

    test('fromVoltageAndResistance: MV × Ω → TW', () {
      final p = Power.fromVoltageAndResistance(1.0.MV, 1.0.ohms);
      expect(p.unit, PowerUnit.terawatt);
      expect(p.value, closeTo(1.0, tol));
    });

    test('fromVoltageAndResistance: unmatched → SI fallback W', () {
      expect(
        Power.fromVoltageAndResistance(
          const Voltage(1, VoltageUnit.statvolt),
          1.0.ohms,
        ).unit,
        PowerUnit.watt,
      );
    });

    // --- Cross-formula consistency ---
    test('V×I == I²R == V²/R for same circuit (V=10V, I=2A, R=5Ω)', () {
      final v = 10.0.V;
      final i = 2.0.A;
      final r = 5.0.ohms;
      final p1 = Power.fromVoltageAndCurrent(v, i);
      final p2 = Power.fromCurrentAndResistance(i, r);
      final p3 = Power.fromVoltageAndResistance(v, r);
      expect(p1.inWatts, closeTo(20.0, tol));
      expect(p2.inWatts, closeTo(20.0, tol));
      expect(p3.inWatts, closeTo(20.0, tol));
    });
  });
}
