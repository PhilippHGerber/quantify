import 'package:quantify/energy.dart';
import 'package:test/test.dart';

void main() {
  group('Energy', () {
    const strictTolerance = 1e-12; // For "exact" conversions or small scales
    const defaultTolerance = 1e-9; // General purpose
    const highTolerance = 1e-6; // For conversions involving many decimal places

    // Helper for round trip tests
    void testRoundTrip(
      EnergyUnit initialUnit,
      EnergyUnit intermediateUnit,
      double initialValue, {
      double tol = defaultTolerance,
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
        expect(eKcal.inJoules, closeTo(250.0 * 4184.0, defaultTolerance));
        expect(eKcal.asJoules.value, closeTo(250.0 * 4184.0, defaultTolerance));
        expect(eKcal.asJoules.unit, EnergyUnit.joule);

        final eKwh = 1.2.kWh;
        expect(eKwh.value, 1.2);
        expect(eKwh.unit, EnergyUnit.kilowattHour);
        expect(eKwh.inJoules, closeTo(1.2 * 3600000.0, defaultTolerance));
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
        expect(oneKwh.inBtu, closeTo(3600000.0 / 1055.056, highTolerance)); // ~3412 Btu
      });

      final oneKcal = 1.0.kilocalories; // 4184 Joules
      test('1 Kilocalorie to other units', () {
        expect(oneKcal.inJoules, closeTo(4184.0, strictTolerance));
        expect(oneKcal.inCalories, closeTo(1000.0, strictTolerance));
        expect(oneKcal.inBtu, closeTo(4184.0 / 1055.056, highTolerance)); // ~3.96 Btu
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
        expect(sum.inKilojoules, closeTo(4100.0, defaultTolerance));
        expect(sum.unit, EnergyUnit.kilowattHour); // Left-hand operand's unit
      });

      test('operator - subtracts energies', () {
        final diff = e1 - e2; // 3600 kJ - (200 * 4.184) kJ
        const expected = 3600.0 - (200.0 * 4.184);
        expect(diff.inKilojoules, closeTo(expected, highTolerance));
      });

      test('operator * and / scale energy by a scalar', () {
        final scaledUp = e3 * 4.0;
        expect(scaledUp.inKilojoules, closeTo(2000.0, defaultTolerance));

        final scaledDown = e1 / 2.0;
        expect(scaledDown.inKilowattHours, closeTo(0.5, defaultTolerance));

        expect(() => e1 / 0.0, throwsArgumentError);
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
        expect(snackBar.inKilojoules, closeTo(627.6, defaultTolerance)); // 150 * 4.184
      });

      test('Household electricity consumption', () {
        // A 100W light bulb running for 24 hours.
        // Energy = Power * Time = 0.1 kW * 24 h = 2.4 kWh
        final bulbEnergy = 2.4.kWh;
        expect(bulbEnergy.inJoules, closeTo(2.4 * 3.6e6, defaultTolerance));
        expect(bulbEnergy.inMegajoules, closeTo(8.64, defaultTolerance));
      });
    });
  });
}
