import 'package:quantify/constants.dart';
import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('Physical Constants', () {
    const tolerance = 1e-12;
    const highTolerance = 1e-9;

    test('fundamental constants have correct values', () {
      // Speed of light is now a Speed object
      expect(PhysicalConstants.speedOfLight.inMetersPerSecond, 299792458.0);

      // Elementary charge is now an ElectricCharge object
      expect(PhysicalConstants.elementaryCharge.inCoulombs, closeTo(1.602176634e-19, 1e-28));

      // Planck and Avogadro constants remain doubles
      expect(PhysicalConstants.planckConstant, 6.62607015e-34);
      expect(PhysicalConstants.avogadroConstant, 6.02214076e23);
    });

    test('particle masses are correct', () {
      expect(PhysicalConstants.electronMass.inKilograms, closeTo(9.1093837015e-31, tolerance));
      expect(PhysicalConstants.protonMass.inKilograms, closeTo(1.67262192369e-27, tolerance));
      expect(
        PhysicalConstants.atomicMassConstant.inKilograms,
        closeTo(1.66053906660e-27, tolerance),
      );
    });

    test('energy constants are correct', () {
      expect(PhysicalConstants.electronVolt.inJoules, closeTo(1.602176634e-19, 1e-28));
      expect(PhysicalConstants.rydbergEnergy.inJoules, closeTo(2.1798723611035e-18, tolerance));
      expect(PhysicalConstants.electronRestEnergy.inJoules, closeTo(8.1871057769e-14, tolerance));
    });

    test('convenience methods return correct Quantity types and values', () {
      // lightSpeedDistance
      final lightDistance = PhysicalConstants.lightSpeedDistance(1.0.s);
      expect(lightDistance, isA<Length>());
      expect(lightDistance.inM, closeTo(299792458.0, tolerance));

      // massEnergyEquivalence
      final energy = PhysicalConstants.massEnergyEquivalence(1.0.kg);
      const expectedEnergy = 299792458.0 * 299792458.0; // c²
      expect(energy, isA<Energy>());
      expect(energy.inJoules, closeTo(expectedEnergy, highTolerance));

      // photonEnergy
      final photonEnergy = PhysicalConstants.photonEnergy(500.0.nm);
      final expectedPhotonEnergy = PhysicalConstants.planckConstant *
          PhysicalConstants.speedOfLight.inMetersPerSecond /
          500e-9;
      expect(photonEnergy, isA<Energy>());
      expect(photonEnergy.inJoules, closeTo(expectedPhotonEnergy, highTolerance));

      // gravitationalForce
      final force = PhysicalConstants.gravitationalForce(1.kg, 1.kg, 1.m);
      expect(force, isA<Force>());
      expect(force.inNewtons, closeTo(PhysicalConstants.gravitationalConstant, tolerance));
    });
  });

  group('Astronomical Constants', () {
    const highTolerance = 1e20; // For measured values like planetary masses

    test('solar system constants are correct Quantity types', () {
      expect(AstronomicalConstants.solarMass, isA<Mass>());
      expect(AstronomicalConstants.solarLuminosity, isA<Power>());
      expect(AstronomicalConstants.earthMass, isA<Mass>());
      expect(AstronomicalConstants.earthRadius, isA<Length>());
      expect(AstronomicalConstants.standardGravity, isA<Acceleration>());
      expect(AstronomicalConstants.earthEscapeVelocity, isA<Speed>());
    });

    test('solar system masses and sizes are correct', () {
      expect(AstronomicalConstants.solarMass.inKilograms, closeTo(1.98847e30, 1e25));
      expect(AstronomicalConstants.earthMass.inKilograms, closeTo(5.9722e24, highTolerance));
      expect(AstronomicalConstants.earthRadius.inKilometers, closeTo(6378.14, 10));
      final jupiterToEarthRatio = AstronomicalConstants.jupiterMass.inKilograms /
          AstronomicalConstants.earthMass.inKilograms;
      expect(jupiterToEarthRatio, greaterThan(317));
      expect(jupiterToEarthRatio, lessThan(319));
    });

    test('other astronomical constants are correct', () {
      expect(AstronomicalConstants.solarLuminosity.inWatts, closeTo(3.828e26, 1e22));
      expect(AstronomicalConstants.standardGravity.inMetersPerSecondSquared, 9.80665);
      expect(AstronomicalConstants.earthEscapeVelocity.inMetersPerSecond, closeTo(11190, 10));
      expect(AstronomicalConstants.hubbleConstant.inHertz, closeTo(2.18e-18, 1e-20));
    });

    test('convenience calculations return correct Quantity types and values', () {
      // surfaceGravity
      final g = AstronomicalConstants.surfaceGravity(
        AstronomicalConstants.earthMass,
        AstronomicalConstants.earthRadius,
      );
      expect(g, isA<Acceleration>());
      expect(g.inMetersPerSecondSquared, closeTo(9.8, 0.2)); // ~9.8 m/s²

      // escapeVelocity
      final vEscape = AstronomicalConstants.escapeVelocity(
        AstronomicalConstants.earthMass,
        AstronomicalConstants.earthRadius,
      );
      expect(vEscape, isA<Speed>());
      expect(vEscape.inKilometersPerSecond, closeTo(11.2, 0.2)); // ~11.2 km/s

      // schwarzschildRadius
      final rs = AstronomicalConstants.schwarzschildRadius(AstronomicalConstants.solarMass);
      expect(rs, isA<Length>());
      expect(rs.inKilometers, closeTo(2.95, 0.1)); // ~3 km
    });
  });

  group('Engineering Constants', () {
    const tolerance = 1e-9;

    test('standard conditions are correct Quantity types', () {
      expect(EngineeringConstants.standardTemperature, isA<Temperature>());
      expect(EngineeringConstants.standardPressure, isA<Pressure>());
      expect(EngineeringConstants.standardAtmosphere, isA<Pressure>());
    });

    test('material properties are correct Quantity types', () {
      expect(EngineeringConstants.soundSpeedAir20C, isA<Speed>());
      expect(EngineeringConstants.soundSpeedWater25C, isA<Speed>());
      expect(EngineeringConstants.steelYoungsModulus, isA<Pressure>());
      expect(EngineeringConstants.aluminumYoungsModulus, isA<Pressure>());
      expect(EngineeringConstants.steelTensileStrength, isA<Pressure>());
      expect(EngineeringConstants.nuclearBindingEnergyPerNucleon, isA<Energy>());
    });

    test('values of constants are correct', () {
      expect(EngineeringConstants.standardTemperature.inCelsius, closeTo(0.0, tolerance));
      expect(EngineeringConstants.standardPressure.inBar, closeTo(1.0, tolerance));
      expect(EngineeringConstants.standardAtmosphere.inPa, 101325.0);
      expect(EngineeringConstants.soundSpeedAir20C.inMetersPerSecond, closeTo(343.2, 1));
      expect(EngineeringConstants.steelYoungsModulus.inMegaPascals, closeTo(200000, 10000));
    });

    test('convenience calculations return correct Quantity types and values', () {
      // mechanicalStress
      final stress = EngineeringConstants.mechanicalStress(1000.N, 0.01.m2);
      expect(stress, isA<Pressure>());
      expect(stress.inKiloPascals, closeTo(100.0, tolerance));

      // mechanicalStrain
      final strain = EngineeringConstants.mechanicalStrain(
        200.megaPascals,
        EngineeringConstants.steelYoungsModulus,
      );
      expect(strain, isA<double>());
      expect(strain, closeTo(0.001, tolerance)); // 200e6 Pa / 200e9 Pa = 0.001

      // conductiveHeatTransfer
      final heatRate = EngineeringConstants.conductiveHeatTransfer(
        0.5,
        1.m2,
        0.1.m,
        const Temperature(10, TemperatureUnit.kelvin),
      );
      expect(heatRate, isA<Power>());
      expect(heatRate.inWatts, closeTo(50.0, tolerance)); // 0.5 * 1 * 10 / 0.1 = 50.0
    });
  });

  group('Cross-library consistency', () {
    test('standard gravity constants are consistent', () {
      // Compare the Acceleration object from AstronomicalConstants with the one from the num extension
      final gFromAcc = 1.gravity;
      expect(AstronomicalConstants.standardGravity.compareTo(gFromAcc), 0);
    });

    test('unit conversions work with constants', () {
      // Bohr radius in angstroms
      final bohrInAngstrom = PhysicalConstants.bohrRadius.inAngstrom;
      expect(bohrInAngstrom, closeTo(0.529, 0.001));

      // Solar luminosity in megawatts
      final solarLuminosityMW = AstronomicalConstants.solarLuminosity.inMegawatts;
      expect(solarLuminosityMW, closeTo(3.828e20, 1e16));
    });
  });
}
