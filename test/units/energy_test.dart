import 'package:quantify/energy.dart';
import 'package:quantify/force.dart';
import 'package:quantify/length.dart';
import 'package:quantify/power.dart';
import 'package:quantify/time.dart';
import 'package:test/test.dart';

void main() {
  group('Energy', () {
    const strictTolerance = 1e-12; // For "exact" conversions or small scales
    const highTolerance = 1e-6; // For conversions involving many decimal places

    // Helper for round trip tests
    void testRoundTrip(
      EnergyUnit initialUnit,
      EnergyUnit intermediateUnit,
      double initialValue, {
      double tol = 1e-9,
    }) {
      final e1 = Energy(initialValue, initialUnit);
      final e2 = e1.convertTo(intermediateUnit);
      final e3 = e2.convertTo(initialUnit);
      expect(
        e3.value,
        closeTo(initialValue, tol),
        reason:
            '${initialUnit.symbol} -> ${intermediateUnit.symbol} -> ${initialUnit.symbol} failed for $initialValue. Expected $initialValue, got ${e3.value}',
      );
    }

    group('Constructors and Getters', () {
      test('should create Energy from num extensions and retrieve values correctly', () {
        final eKcal = 250.0.kcal;
        expect(eKcal.value, 250.0);
        expect(eKcal.unit, EnergyUnit.kilocalorie);
        expect(eKcal.inJoules, closeTo(250.0 * 4184.0, 1e-9));
        expect(eKcal.asJoules.value, closeTo(250.0 * 4184.0, 1e-9));
        expect(eKcal.asJoules.unit, EnergyUnit.joule);

        final eKwh = 1.2.kWh;
        expect(eKwh.value, 1.2);
        expect(eKwh.unit, EnergyUnit.kilowattHour);
        expect(eKwh.inJoules, closeTo(1.2 * 3600000.0, 1e-9));
      });

      test('getValue should return correct value for same unit', () {
        const energy = Energy(100, EnergyUnit.joule);
        expect(energy.getValue(EnergyUnit.joule), 100.0);
      });
    });

    group('Conversions between various energy units', () {
      final oneKwh = 1.0.kWh; // 3,600,000 Joules

      test('1 Kilowatt-hour to other units', () {
        expect(oneKwh.inJoules, closeTo(3600000.0, strictTolerance));
        expect(oneKwh.inKilojoules, closeTo(3600.0, strictTolerance));
        expect(oneKwh.inKilocalories, closeTo(3600000.0 / 4184.0, highTolerance)); // ~860.4 kcal
        expect(oneKwh.inBtu, closeTo(3600000.0 / 1055.05585262, highTolerance)); // ~3412 Btu
      });

      final oneKcal = 1.0.kilocalories; // 4184 Joules
      test('1 Kilocalorie to other units', () {
        expect(oneKcal.inJoules, closeTo(4184.0, strictTolerance));
        expect(oneKcal.inCalories, closeTo(1000.0, strictTolerance));
        expect(oneKcal.inBtu, closeTo(4184.0 / 1055.05585262, highTolerance)); // ~3.96 Btu
      });

      final oneElectronvolt = 1.0.eV;
      test('1 Electronvolt to Joules', () {
        expect(oneElectronvolt.inJoules, closeTo(1.602176634e-19, 1e-28));
      });
    });

    group('Comparison (compareTo)', () {
      final e1 = 1.0.kWh; // 3.6 MJ
      final e2 = 3600.0.kJ; // 3.6 MJ
      final e3 = 860.0.kcal; // ~3.597 MJ
      final e4 = 861.0.kcal; // ~3.601 MJ

      test('should correctly compare energies of different units', () {
        expect(e1.compareTo(e2), 0);
        expect(e1.compareTo(e3), greaterThan(0));
        expect(e1.compareTo(e4), lessThan(0));
      });
    });

    group('Equality (operator ==) and HashCode', () {
      test('equality is strict, 1.kWh is not equal to 3600.kJ', () {
        final oneKwh = 1.kWh;
        final threeThousandSixHundredKj = 3600.kJ;
        expect(oneKwh == threeThousandSixHundredKj, isFalse);
        expect(oneKwh.compareTo(threeThousandSixHundredKj), 0);
      });
    });

    group('Arithmetic Operators for Energy', () {
      final e1 = 1.0.kWh;
      final e2 = 200.0.kcal;
      final e3 = 500.0.kJ;

      test('operator + combines energies', () {
        final sum = e1 + e3; // 3600 kJ + 500 kJ = 4100 kJ
        expect(sum.inKilojoules, closeTo(4100.0, 1e-9));
        expect(sum.unit, EnergyUnit.kilowattHour); // Left-hand operand's unit
      });

      test('operator - subtracts energies', () {
        final diff = e1 - e2; // 3600 kJ - (200 * 4.184) kJ
        const expected = 3600.0 - (200.0 * 4.184);
        expect(diff.inKilojoules, closeTo(expected, highTolerance));
      });

      test('operator * and / scale energy by a scalar', () {
        final scaledUp = e3 * 4.0;
        expect(scaledUp.inKilojoules, closeTo(2000.0, 1e-9));

        final scaledDown = e1 / 2.0;
        expect(scaledDown.inKilowattHours, closeTo(0.5, 1e-9));

        expect((e1 / 0.0).value, double.infinity);
      });
    });

    group('Round Trip Conversions (thorough)', () {
      const testValue = 123.456;

      for (final unit in EnergyUnit.values) {
        test('Round trip ${unit.symbol} <-> J', () {
          testRoundTrip(
            unit,
            EnergyUnit.joule,
            testValue,
            tol: (unit == EnergyUnit.electronvolt) ? 1e-5 : highTolerance,
          );
        });
      }
    });

    group('Practical Examples', () {
      test('Nutritional energy calculation', () {
        // A snack bar has 150 kcal.
        final snackBar = 150.0.kcal;
        // How much is this in kJ? (Common on food labels outside the US)
        expect(snackBar.inKilojoules, closeTo(627.6, 1e-9)); // 150 * 4.184
      });

      test('Household electricity consumption', () {
        // A 100W light bulb running for 24 hours.
        // Energy = Power * Time = 0.1 kW * 24 h = 2.4 kWh
        final bulbEnergy = 2.4.kWh;
        expect(bulbEnergy.inJoules, closeTo(2.4 * 3.6e6, 1e-9));
        expect(bulbEnergy.inMegajoules, closeTo(8.64, 1e-9));
      });
    });

    group('Comprehensive Extension Coverage', () {
      test('all creation extension aliases', () {
        expect(100.joules.unit, EnergyUnit.joule);
        expect(1.MJ.unit, EnergyUnit.megajoule);
        expect(1.megajoules.unit, EnergyUnit.megajoule);
        expect(5.kilojoules.unit, EnergyUnit.kilojoule);
        expect(250.calories.unit, EnergyUnit.calorie);
        expect(1.kilocalories.unit, EnergyUnit.kilocalorie);
        expect(1.kilowattHours.unit, EnergyUnit.kilowattHour);
        expect(1.electronvolts.unit, EnergyUnit.electronvolt);
        expect(1000.btu.unit, EnergyUnit.btu);
        expect(100.joules.inJoules, closeTo(100.0, 1e-9));
      });

      test('all as* conversion getters', () {
        final e = 3600000.0.J; // 1 kWh

        final asMj = e.asMegajoules;
        expect(asMj.unit, EnergyUnit.megajoule);
        expect(asMj.value, closeTo(3.6, 1e-9));

        final asKj = e.asKilojoules;
        expect(asKj.unit, EnergyUnit.kilojoule);
        expect(asKj.value, closeTo(3600.0, 1e-9));

        final asCal = e.asCalories;
        expect(asCal.unit, EnergyUnit.calorie);
        expect(asCal.value, closeTo(3600000.0 / 4.184, 1e-9)); // 1 cal = 4.184 J

        final asKcal = e.asKilocalories;
        expect(asKcal.unit, EnergyUnit.kilocalorie);
        expect(asKcal.value, closeTo(3600000.0 / 4184.0, 1e-9)); // 1 kcal = 4184 J

        final asKcalIt = e.asKilocaloriesIT;
        expect(asKcalIt.unit, EnergyUnit.kilocalorieIT);
        expect(
          asKcalIt.value,
          closeTo(3600000.0 / 4186.8, 1e-9),
        ); // 1 kcal_IT = 4186.8 J

        final asKwh = e.asKilowattHours;
        expect(asKwh.unit, EnergyUnit.kilowattHour);
        expect(asKwh.value, closeTo(1.0, 1e-9));

        final asEv = e.asElectronvolts;
        expect(asEv.unit, EnergyUnit.electronvolt);
        expect(asEv.value, closeTo(3600000.0 / 1.602176634e-19, 1e12));

        final asBtu = e.asBtu;
        expect(asBtu.unit, EnergyUnit.btu);
        expect(asBtu.value, closeTo(3412.14, 1e-2));
      });
    });

    group('IT Calorie Conversions', () {
      test('calorieIT to joule conversion', () {
        const energy = Energy(1, EnergyUnit.calorieIT);
        expect(energy.inJoules, closeTo(4.1868, strictTolerance));
      });

      test('kilocalorieIT to joule conversion', () {
        const energy = Energy(1, EnergyUnit.kilocalorieIT);
        expect(energy.inJoules, closeTo(4186.8, strictTolerance));
      });

      test('thermochemical vs IT calorie difference', () {
        const thermoCal = Energy(1000, EnergyUnit.calorie);
        const itCal = Energy(1000, EnergyUnit.calorieIT);

        // Difference should be ~2.8 J per 1000 cal
        final diff = (itCal.inJoules - thermoCal.inJoules).abs();
        expect(diff, closeTo(2.8, 0.01));
      });

      test('extension creation for IT variants', () {
        expect(100.calIT.inJoules, closeTo(418.68, 1e-9));
        expect(1.kcalIT.inJoules, closeTo(4186.8, 1e-9));
      });

      test('extension value getters for IT variants', () {
        const energy = Energy(4186.8, EnergyUnit.joule);
        expect(energy.inCaloriesIT, closeTo(1000, highTolerance));
        expect(energy.inKilocaloriesIT, closeTo(1, 1e-9));
      });

      test('round-trip conversions for IT variants', () {
        const original = Energy(123.456, EnergyUnit.calorieIT);
        final roundTrip = original.asJoules.asCaloriesIT;
        expect(
          roundTrip.getValue(EnergyUnit.calorieIT),
          closeTo(123.456, 1e-9),
        );
      });

      test('conversion between thermochemical and IT calories', () {
        final thermoCal = 100.cal; // 100 thermochemical calories = 418.4 J
        final itEquivalent = thermoCal.inCaloriesIT;
        // 418.4 J / 4.1868 J/cal_IT = 99.93312314894432 cal_IT
        expect(itEquivalent, closeTo(99.93312314894432, highTolerance));
      });

      test('conversion between thermochemical and IT kilocalories', () {
        final thermoKcal = 10.kcal; // 10 kcal = 41840 J
        final itEquivalent = thermoKcal.inKilocaloriesIT;
        // 41840 J / 4186.8 J/kcal_IT = 9.993312314894428 kcal_IT
        expect(itEquivalent, closeTo(9.993312314894428, highTolerance));
      });
    });
  });

  group('Dimensional Analysis (Energy.from)', () {
    test('E = P × t: 1 kW × 1 h = 3 600 000 J', () {
      expect(Energy.from(1.kW, 1.hours).inJoules, closeTo(3600000.0, 1e-3));
    });

    test('result unit is kilowattHour for kW + h', () {
      expect(Energy.from(1.kW, 1.hours).unit, EnergyUnit.kilowattHour);
    });

    test('E = P × t with watts and seconds', () {
      // 10 W × 10 s = 100 J
      expect(
        Energy.from(const Power(10, PowerUnit.watt), const Time(10, TimeUnit.second)).inJoules,
        closeTo(100.0, 1e-9),
      );
    });

    test('millijoule/microjoule/gigajoule/terajoule extensions', () {
      const tol = 1e-9;
      // Creation
      expect(500.0.mJ.unit, EnergyUnit.millijoule);
      expect(500.0.millijoules.unit, EnergyUnit.millijoule);
      expect(2.0.uJ.unit, EnergyUnit.microjoule);
      expect(2.0.microjoules.unit, EnergyUnit.microjoule);
      expect(1.0.GJ.unit, EnergyUnit.gigajoule);
      expect(1.0.gigajoules.unit, EnergyUnit.gigajoule);
      expect(1.0.TJ.unit, EnergyUnit.terajoule);
      expect(1.0.terajoules.unit, EnergyUnit.terajoule);

      // inX getters
      expect(1.0.J.inMillijoules, closeTo(1000.0, tol));
      expect(1.0.J.inMicrojoules, closeTo(1e6, tol));
      expect(1e9.J.inGigajoules, closeTo(1.0, tol));
      expect(1e12.J.inTerajoules, closeTo(1.0, tol));

      // asX getters
      final asMillijoules = 1.0.J.asMillijoules;
      expect(asMillijoules.unit, EnergyUnit.millijoule);
      expect(asMillijoules.value, closeTo(1000.0, tol));

      final asMicrojoules = 1.0.J.asMicrojoules;
      expect(asMicrojoules.unit, EnergyUnit.microjoule);
      expect(asMicrojoules.value, closeTo(1e6, tol));

      final asGigajoules = 1e9.J.asGigajoules;
      expect(asGigajoules.unit, EnergyUnit.gigajoule);
      expect(asGigajoules.value, closeTo(1.0, tol));

      final asTerajoules = 1e12.J.asTerajoules;
      expect(asTerajoules.unit, EnergyUnit.terajoule);
      expect(asTerajoules.value, closeTo(1.0, tol));
    });

    test('calIT / caloriesIT extensions', () {
      const tol = 1e-9;
      expect(1.0.calIT.unit, EnergyUnit.calorieIT);
      expect(1.0.caloriesIT.unit, EnergyUnit.calorieIT);
      expect(1.0.calIT.inJoules, closeTo(4.1868, tol));
      final asCalIT = 4.1868.J.asCaloriesIT;
      expect(asCalIT.unit, EnergyUnit.calorieIT);
      expect(asCalIT.value, closeTo(1.0, 1e-6));
    });

    test('inverse of Power.from: Energy.from(Power.from(e, t), t) ≈ e', () {
      const original = Energy(7200, EnergyUnit.joule);
      const duration = Time(60, TimeUnit.second);
      final power = Power.from(original, duration);
      final recovered = Energy.from(power, duration);
      expect(recovered.inJoules, closeTo(7200.0, 1e-9));
    });

    // --- Unit-preserving behaviour ---
    test('Energy.from: W + s → J', () {
      final e = Energy.from(10.W, 10.s);
      expect(e.unit, EnergyUnit.joule);
      expect(e.value, closeTo(100.0, 1e-9));
    });

    test('Energy.from: kW + h → kWh', () {
      final e = Energy.from(1.kW, 1.hours);
      expect(e.unit, EnergyUnit.kilowattHour);
      expect(e.value, closeTo(1.0, 1e-9));
    });

    test('Energy.from: BTU/h + h → BTU', () {
      final e = Energy.from(const Power(5000, PowerUnit.btuPerHour), 2.hours);
      expect(e.unit, EnergyUnit.btu);
      expect(e.value, closeTo(10000.0, 1e-9));
    });

    test('Energy.from: unmatched → SI fallback J', () {
      expect(Energy.from(1.kW, 1.minutes).unit, EnergyUnit.joule);
    });

    test('Energy.from physical correctness: 1 kW × 1 h = 3 600 000 J', () {
      expect(Energy.from(1.kW, 1.hours).inJoules, closeTo(3600000.0, 1e-3));
    });
  });

  group('Dimensional Analysis (Energy.fromWork)', () {
    const strictTolerance = 1e-12;

    test('Energy.fromWork: N × m → J', () {
      final e = Energy.fromWork(10.0.N, 5.0.m);
      expect(e.unit, EnergyUnit.joule);
      expect(e.value, closeTo(50.0, strictTolerance));
    });

    test('Energy.fromWork: N × mm → mJ', () {
      final e = Energy.fromWork(1.0.N, 500.0.mm);
      expect(e.unit, EnergyUnit.millijoule);
      expect(e.value, closeTo(500.0, strictTolerance));
    });

    test('Energy.fromWork: N × km → kJ', () {
      final e = Energy.fromWork(1.0.N, 2.0.km);
      expect(e.unit, EnergyUnit.kilojoule);
      expect(e.value, closeTo(2.0, strictTolerance));
    });

    test('Energy.fromWork: kN × m → kJ', () {
      final e = Energy.fromWork(5.0.kN, 3.0.m);
      expect(e.unit, EnergyUnit.kilojoule);
      expect(e.value, closeTo(15.0, strictTolerance));
    });

    test('Energy.fromWork: kN × km → MJ', () {
      final e = Energy.fromWork(2.0.kN, 3.0.km);
      expect(e.unit, EnergyUnit.megajoule);
      expect(e.value, closeTo(6.0, strictTolerance));
    });

    test('Energy.fromWork: MN × m → MJ', () {
      final e = Energy.fromWork(1.0.MN, 4.0.m);
      expect(e.unit, EnergyUnit.megajoule);
      expect(e.value, closeTo(4.0, strictTolerance));
    });

    test('Energy.fromWork: MN × km → GJ', () {
      final e = Energy.fromWork(2.0.MN, 5.0.km);
      expect(e.unit, EnergyUnit.gigajoule);
      expect(e.value, closeTo(10.0, strictTolerance));
    });

    test('Energy.fromWork: GN × m → GJ', () {
      final e = Energy.fromWork(3.0.GN, 2.0.m);
      expect(e.unit, EnergyUnit.gigajoule);
      expect(e.value, closeTo(6.0, strictTolerance));
    });

    test('Energy.fromWork: unmatched (lbf × ft) → SI fallback J', () {
      final e = Energy.fromWork(const Force(1, ForceUnit.poundForce), 1.0.ft);
      expect(e.unit, EnergyUnit.joule);
      expect(e.inJoules, closeTo(1.35582, 1e-4));
    });

    test('Energy.fromWork physical correctness: 10 N × 5 m = 50 J', () {
      expect(Energy.fromWork(10.0.N, 5.0.m).inJoules, closeTo(50.0, strictTolerance));
    });
  });
}
