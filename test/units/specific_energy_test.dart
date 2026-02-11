import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('SpecificEnergy', () {
    const tolerance = 1e-9;

    group('Constructors and Getters', () {
      test('should create from num extensions and retrieve values', () {
        final se = 100.jPerKg;
        expect(se.value, 100.0);
        expect(se.unit, SpecificEnergyUnit.joulePerKilogram);
        expect(se.inJoulesPerKilogram, closeTo(100.0, tolerance));

        final battery = 250.whPerKg;
        expect(battery.inJoulesPerKilogram, closeTo(250 * 3600.0, tolerance));
        expect(battery.inWattHoursPerKilogram, closeTo(250.0, tolerance));
      });
    });

    group('Conversions', () {
      test('J/kg to Wh/kg', () {
        // 3600 J/kg = 1 Wh/kg
        final se = 3600.jPerKg;
        expect(se.inWattHoursPerKilogram, closeTo(1.0, tolerance));
      });

      test('Wh/kg to J/kg', () {
        final se = 1.whPerKg;
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
        final se1 = 3600.jPerKg;
        final se2 = 1.whPerKg;
        expect(se1.compareTo(se2), 0);
        expect(se1.compareTo(2.whPerKg), lessThan(0));
      });
    });

    group('Arithmetic', () {
      test('should perform basic arithmetic', () {
        final sum = 1.whPerKg + 3600.jPerKg; // 1 + 1 (in Wh/kg)
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
        final se = 100.whPerKg;
        final mass = 2.kg;
        final energy = se.energyIn(mass);
        // 100 Wh/kg * 2 kg = 200 Wh = 720,000 J = 0.2 kWh
        expect(energy.inJoules, closeTo(720000.0, tolerance));
        expect(energy.inKilowattHours, closeTo(0.2, tolerance));
      });
    });

    group('Equality and HashCode', () {
      test('same value and unit are equal', () {
        final se1 = 1.whPerKg;
        final se2 = 1.whPerKg;
        expect(se1, equals(se2));
        expect(se1.hashCode, equals(se2.hashCode));
      });

      test('different units are not equal even if equivalent', () {
        final se1 = 3600.jPerKg;
        final se2 = 1.whPerKg;
        expect(se1, isNot(equals(se2)));
        expect(se1.compareTo(se2), 0);
      });
    });

    group('toString', () {
      test('displays value with symbol', () {
        expect(100.jPerKg.toString(), '100.0\u00A0J/kg');
        expect(1.whPerKg.toString(), '1.0\u00A0Wh/kg');
        expect(1.kJPerKg.toString(), '1.0\u00A0kJ/kg');
        expect(1.kWhPerKg.toString(), '1.0\u00A0kWh/kg');
      });
    });

    group('Round Trip Conversions', () {
      for (final unit in SpecificEnergyUnit.values) {
        test('Round trip ${unit.symbol} <-> J/kg', () {
          const initialValue = 123.456;
          final se = SpecificEnergy(initialValue, unit);
          final roundTrip = se.asJoulesPerKilogram.convertTo(unit);
          expect(roundTrip.value, closeTo(initialValue, tolerance));
        });
      }
    });

    group('Comprehensive Extension Coverage', () {
      test('all in* value getters', () {
        final se = 3600000.jPerKg; // 1 kWh/kg
        expect(se.inKilowattHoursPerKilogram, closeTo(1.0, tolerance));
        expect(se.inKilojoulesPerKilogram, closeTo(3600.0, tolerance));
        expect(se.inWattHoursPerKilogram, closeTo(1000.0, tolerance));
      });

      test('all as* conversion getters', () {
        final se = 3600.jPerKg; // 1 Wh/kg

        final asJ = se.asJoulesPerKilogram;
        expect(asJ.unit, SpecificEnergyUnit.joulePerKilogram);
        expect(asJ.value, closeTo(3600.0, tolerance));

        final asKj = se.asKilojoulesPerKilogram;
        expect(asKj.unit, SpecificEnergyUnit.kilojoulePerKilogram);
        expect(asKj.value, closeTo(3.6, tolerance));

        final asWh = se.asWattHoursPerKilogram;
        expect(asWh.unit, SpecificEnergyUnit.wattHourPerKilogram);
        expect(asWh.value, closeTo(1.0, tolerance));

        final asKwh = se.asKilowattHoursPerKilogram;
        expect(asKwh.unit, SpecificEnergyUnit.kilowattHourPerKilogram);
        expect(asKwh.value, closeTo(0.001, tolerance));
      });
    });
  });
}
