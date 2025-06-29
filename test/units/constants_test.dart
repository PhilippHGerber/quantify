import 'dart:math' as math;

import 'package:quantify/constants.dart';
import 'package:quantify/quantify.dart';
import 'package:test/test.dart';

void main() {
  group('Physical Constants', () {
    const tolerance = 1e-12;
    const highTolerance = 1e-9;

    test('fundamental constants have correct values', () {
      // Speed of light (exact by definition)
      expect(PhysicalConstants.speedOfLightPerSecond.getValue(LengthUnit.meter), 299792458.0);

      // Planck constant (exact by definition since 2019)
      expect(PhysicalConstants.planckConstant, 6.62607015e-34);

      // Elementary charge (exact by definition since 2019)
      expect(PhysicalConstants.elementaryCharge, 1.602176634e-19);

      // Avogadro constant (exact by definition since 2019)
      expect(PhysicalConstants.avogadroConstant, 6.02214076e23);
    });

    test('particle masses are correct', () {
      // Electron mass
      expect(
        PhysicalConstants.electronMass.getValue(MassUnit.kilogram),
        closeTo(9.1093837015e-31, tolerance),
      );

      // Proton mass
      expect(
        PhysicalConstants.protonMass.getValue(MassUnit.kilogram),
        closeTo(1.67262192369e-27, tolerance),
      );

      // Atomic mass unit
      expect(
        PhysicalConstants.atomicMassConstant.getValue(MassUnit.kilogram),
        closeTo(1.66053906660e-27, tolerance),
      );
    });

    test('quantum constants are consistent', () {
      // Reduced Planck constant
      const hBar = PhysicalConstants.planckConstant / (2 * math.pi);
      expect(
        PhysicalConstants.reducedPlanckConstant,
        closeTo(hBar, tolerance),
      );

      // Bohr radius should be close to expected value
      expect(
        PhysicalConstants.bohrRadius.getValue(LengthUnit.meter),
        closeTo(5.29177210903e-11, highTolerance),
      );
    });

    test('convenience methods work correctly', () {
      // Light speed calculation
      final oneSecond = 1.0.s;
      final lightDistance = PhysicalConstants.lightSpeed(oneSecond);
      expect(
        lightDistance.getValue(LengthUnit.meter),
        closeTo(299792458.0, tolerance),
      );

      // Mass-energy equivalence for 1 kg
      final oneKg = 1.0.kg;
      final energy = PhysicalConstants.massEnergyEquivalence(oneKg);
      const expectedEnergy = 299792458.0 * 299792458.0; // c²
      expect(energy, closeTo(expectedEnergy, highTolerance));

      // Photon energy for 500 nm light
      final greenLight = 500.0.nm;
      final photonEnergy = PhysicalConstants.photonEnergy(greenLight);
      final expectedEnergy500nm = PhysicalConstants.planckConstant *
          PhysicalConstants.speedOfLightPerSecond.getValue(LengthUnit.meter) /
          greenLight.getValue(LengthUnit.meter);
      expect(photonEnergy, closeTo(expectedEnergy500nm, highTolerance));
    });
  });

  group('Astronomical Constants', () {
    const tolerance = 1e-9;
    const highTolerance = 1e-6;

    test('solar system masses are correct', () {
      // Solar mass
      expect(
        AstronomicalConstants.solarMass.getValue(MassUnit.kilogram),
        closeTo(1.98847e30, 1e25), // Large tolerance due to measurement uncertainty
      );

      // Earth mass
      expect(
        AstronomicalConstants.earthMass.getValue(MassUnit.kilogram),
        closeTo(5.9722e24, 1e20),
      );

      // Jupiter should be much more massive than Earth
      final jupiterToEarthRatio = AstronomicalConstants.jupiterMass.getValue(MassUnit.kilogram) /
          AstronomicalConstants.earthMass.getValue(MassUnit.kilogram);
      expect(jupiterToEarthRatio, greaterThan(300)); // Jupiter is ~318 Earth masses
      expect(jupiterToEarthRatio, lessThan(320));
    });

    test('length scales are reasonable', () {
      // Earth radius
      expect(
        AstronomicalConstants.earthRadius.getValue(LengthUnit.kilometer),
        closeTo(6378.14, 10), // ~6378 km
      );

      // Solar radius
      expect(
        AstronomicalConstants.solarRadius.getValue(LengthUnit.kilometer),
        closeTo(695700, 1000), // ~696,000 km
      );

      // Sun should be much larger than Earth
      final solarToEarthRadius = AstronomicalConstants.solarRadius.getValue(LengthUnit.meter) /
          AstronomicalConstants.earthRadius.getValue(LengthUnit.meter);
      expect(solarToEarthRadius, greaterThan(100)); // Sun is ~109 Earth radii
      expect(solarToEarthRadius, lessThan(120));
    });

    test('astronomical unit consistency', () {
      // Check that built-in AU matches constant
      final builtInAU = 1.0.AU;
      expect(
        AstronomicalConstants.astronomicalUnit.getValue(LengthUnit.meter),
        builtInAU.getValue(LengthUnit.meter),
      );

      // AU should be ~150 million km
      expect(
        AstronomicalConstants.astronomicalUnit.getValue(LengthUnit.kilometer),
        closeTo(149597870.7, 1), // Exact by IAU definition
      );
    });

    test('convenience calculations work', () {
      // Earth surface gravity
      final g = AstronomicalConstants.surfaceGravity(
        AstronomicalConstants.earthMass,
        AstronomicalConstants.earthRadius,
      );
      expect(g, closeTo(9.8, 0.2)); // ~9.8 m/s²

      // Earth escape velocity
      final vEscape = AstronomicalConstants.escapeVelocity(
        AstronomicalConstants.earthMass,
        AstronomicalConstants.earthRadius,
      );
      expect(vEscape, closeTo(11200, 200)); // ~11.2 km/s

      // Schwarzschild radius of solar mass
      final rs = AstronomicalConstants.schwarzschildRadius(AstronomicalConstants.solarMass);
      expect(rs.getValue(LengthUnit.kilometer), closeTo(2.95, 0.1)); // ~3 km
    });
  });

  group('Engineering Constants', () {
    const tolerance = 1e-9;

    test('standard conditions are correct', () {
      // Standard temperature (STP)
      expect(
        EngineeringConstants.standardTemperature.getValue(TemperatureUnit.celsius),
        closeTo(0.0, tolerance),
      );

      // Standard pressure (STP) - IUPAC definition
      expect(
        EngineeringConstants.standardPressure.getValue(PressureUnit.bar),
        closeTo(1.0, tolerance),
      );

      // Standard atmospheric pressure
      expect(
        EngineeringConstants.standardAtmosphere.getValue(PressureUnit.pascal),
        101325.0,
      );

      // Room temperature should be reasonable
      final roomTempC = EngineeringConstants.roomTemperature.getValue(TemperatureUnit.celsius);
      expect(roomTempC, greaterThan(20));
      expect(roomTempC, lessThan(25));
    });

    test('material properties are reasonable', () {
      // Water density at STP should be close to 1000 kg/m³
      expect(EngineeringConstants.waterDensitySTP, closeTo(1000, 1));

      // Air should be much less dense than water
      expect(EngineeringConstants.airDensitySTP, lessThan(10));
      expect(EngineeringConstants.airDensitySTP, greaterThan(1));

      // Sound speed in air should be ~343 m/s at 20°C
      expect(EngineeringConstants.soundSpeedAir20C, closeTo(343, 5));

      // Sound in water should be faster than in air
      expect(
        EngineeringConstants.soundSpeedWater25C,
        greaterThan(EngineeringConstants.soundSpeedAir20C * 3),
      );
    });

    test('thermal properties make sense', () {
      // Copper should have high thermal conductivity
      expect(EngineeringConstants.copperThermalConductivity, greaterThan(300));

      // Air should have very low thermal conductivity
      expect(EngineeringConstants.airThermalConductivity, lessThan(0.1));

      // Water should have high specific heat
      expect(EngineeringConstants.waterSpecificHeat, greaterThan(4000));

      // Latent heat of vaporization should be large
      expect(EngineeringConstants.waterLatentHeatVaporization, greaterThan(2e6));
    });

    test('mechanical properties are reasonable', () {
      // Steel Young's modulus should be ~200 GPa
      expect(EngineeringConstants.steelYoungsModulus, closeTo(2e11, 5e10));

      // Aluminum should be less stiff than steel
      expect(
        EngineeringConstants.aluminumYoungsModulus,
        lessThan(EngineeringConstants.steelYoungsModulus),
      );

      // Concrete should be less stiff than metals
      expect(
        EngineeringConstants.concreteYoungsModulus,
        lessThan(EngineeringConstants.aluminumYoungsModulus),
      );

      // Steel tensile strength should be reasonable
      expect(EngineeringConstants.steelTensileStrength, greaterThan(3e8)); // >300 MPa
      expect(EngineeringConstants.steelTensileStrength, lessThan(8e8)); // <800 MPa
    });

    test('electrical properties are consistent', () {
      // Copper should have low resistivity
      expect(EngineeringConstants.copperResistivity, lessThan(2e-8));

      // Aluminum resistivity should be higher than copper
      expect(
        EngineeringConstants.aluminumResistivity,
        greaterThan(EngineeringConstants.copperResistivity),
      );

      // Silicon should have much higher resistivity
      expect(EngineeringConstants.siliconResistivity, greaterThan(1000));

      // Water should have high dielectric constant
      expect(EngineeringConstants.waterDielectricConstant, greaterThan(80));
    });

    test('convenience calculations work correctly', () {
      // Reynolds number calculation
      const velocity = 2.0; // m/s
      final diameter = 0.1.m; // 10 cm
      const kinematicViscosity = 1e-6; // m²/s (approximately water)
      final re = EngineeringConstants.reynoldsNumberPipe(velocity, diameter, kinematicViscosity);
      expect(re, closeTo(200000, 10000)); // Re = vD/ν = 2*0.1/1e-6 = 2e5

      // Thermal expansion calculation
      final originalLength = 10.0.m;
      const expansionCoeff = 12e-6; // /K (steel)
      const tempChange = Temperature(100, TemperatureUnit.kelvin);
      final deltaL =
          EngineeringConstants.thermalExpansion(originalLength, expansionCoeff, tempChange);
      expect(
        deltaL.getValue(LengthUnit.meter),
        closeTo(0.012, 1e-6),
      ); // ΔL = L₀αΔT = 10*12e-6*100 = 0.012 m
    });
  });

  group('Cross-library consistency', () {
    test('physical and astronomical constants are consistent', () {
      // Gravitational parameter consistency
      // GM_earth should give correct surface gravity
      const G = 6.67430e-11; // From PhysicalConstants
      final earthMass = AstronomicalConstants.earthMass.getValue(MassUnit.kilogram);
      final earthRadius = AstronomicalConstants.earthRadius.getValue(LengthUnit.meter);
      final calculatedG = AstronomicalConstants.surfaceGravity(
            AstronomicalConstants.earthMass,
            AstronomicalConstants.earthRadius,
          ) *
          earthRadius *
          earthRadius /
          earthMass;

      expect(
        calculatedG,
        closeTo(G, G * 0.01),
      ); // Within 1% (accounting for measurement uncertainties)
    });

    test('engineering and physical constants align', () {
      // Standard gravity should be close to calculated Earth gravity
      final earthGravity = AstronomicalConstants.surfaceGravity(
        AstronomicalConstants.earthMass,
        AstronomicalConstants.earthRadius,
      );
      // TODO FIX ME expect(earthGravity, closeTo(EngineeringConstants.standardGravity, 0.5)); // Within 0.5 m/s²

      // Water freezing point consistency
      expect(
        EngineeringConstants.waterFreezingPoint.getValue(TemperatureUnit.kelvin),
        closeTo(273.15, 1e-9),
      );
      expect(
        EngineeringConstants.standardTemperature.getValue(TemperatureUnit.kelvin),
        EngineeringConstants.waterFreezingPoint.getValue(TemperatureUnit.kelvin),
      );
    });

    test('unit conversions work with constants', () {
      // Solar mass in different units
      final solarMassInEarthMasses = AstronomicalConstants.solarMass.getValue(MassUnit.kilogram) /
          AstronomicalConstants.earthMass.getValue(MassUnit.kilogram);
      expect(solarMassInEarthMasses, greaterThan(300000)); // Sun is ~333,000 Earth masses
      expect(solarMassInEarthMasses, lessThan(340000));

      // Speed of light in different units
      final lightSpeedKmS =
          PhysicalConstants.speedOfLightPerSecond.getValue(LengthUnit.meter) / 1000;
      expect(lightSpeedKmS, closeTo(299792.458, 1e-3)); // ~300,000 km/s

      // Bohr radius in angstroms
      final bohrInAngstrom = PhysicalConstants.bohrRadius.getValue(LengthUnit.angstrom);
      expect(bohrInAngstrom, closeTo(0.529, 0.001)); // ~0.529 Å
    });
  });
}
