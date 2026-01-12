import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('SpecificEnergy', () {
    const tolerance = 1e-9;

    group('Constructors and Getters', () {
      test('should create from num extensions and retrieve values', () {
        final se = 100.JPerKg;
        expect(se.value, 100.0);
        expect(se.unit, SpecificEnergyUnit.joulePerKilogram);
        expect(se.inJoulesPerKilogram, closeTo(100.0, tolerance));

        final battery = 250.WhPerKg;
        expect(battery.inJoulesPerKilogram, closeTo(250 * 3600.0, tolerance));
        expect(battery.inWattHoursPerKilogram, closeTo(250.0, tolerance));
      });
    });

    group('Conversions', () {
      test('J/kg to Wh/kg', () {
        // 3600 J/kg = 1 Wh/kg
        final se = 3600.JPerKg;
        expect(se.inWattHoursPerKilogram, closeTo(1.0, tolerance));
      });

      test('Wh/kg to J/kg', () {
        final se = 1.WhPerKg;
        expect(se.inJoulesPerKilogram, closeTo(3600.0, tolerance));
      });

      test('kWh/kg to kJ/kg', () {
        // 1 kWh/kg = 3600 kJ/kg
        final se = 1.kWhPerKg;
        expect(se.inKilojoulesPerKilogram, closeTo(3600.0, tolerance));
      });
    });

    group('Comparison', () {
      test('should correctly compare different units', () {
        final se1 = 3600.JPerKg;
        final se2 = 1.WhPerKg;
        expect(se1.compareTo(se2), 0);
        expect(se1.compareTo(2.WhPerKg), lessThan(0));
      });
    });

    group('Arithmetic', () {
      test('should perform basic arithmetic', () {
        final sum = 1.WhPerKg + 3600.JPerKg; // 1 + 1 (in Wh/kg)
        expect(sum.inWattHoursPerKilogram, closeTo(2.0, tolerance));
      });
    });

    group('Dimensional Analysis', () {
      test('SpecificEnergy = Energy / Mass', () {
        final energy = 3600.joules;
        final mass = 1.kg;
        final se = SpecificEnergy.from(energy, mass);
        expect(se.inJoulesPerKilogram, closeTo(3600.0, tolerance));
        expect(se.inWattHoursPerKilogram, closeTo(1.0, tolerance));

        expect(() => SpecificEnergy.from(10.joules, 0.kg), throwsArgumentError);
      });

      test('Energy = SpecificEnergy * Mass', () {
        final se = 100.WhPerKg;
        final mass = 2.kg;
        final energy = se.energyIn(mass);
        // 100 Wh/kg * 2 kg = 200 Wh = 720,000 J = 0.2 kWh
        expect(energy.inJoules, closeTo(720000.0, tolerance));
        expect(energy.inKilowattHours, closeTo(0.2, tolerance));
      });
    });
  });
}
