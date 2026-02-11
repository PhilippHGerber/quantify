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

    test('fundamental double constants have correct values', () {
      expect(PhysicalConstants.reducedPlanckConstant, closeTo(1.054571817e-34, 1e-43));
      expect(PhysicalConstants.boltzmannConstant, closeTo(1.380649e-23, 1e-32));
      expect(PhysicalConstants.gasConstant, closeTo(8.314462618, 1e-9));
      expect(PhysicalConstants.faradayConstant, closeTo(96485.33212, 1e-5));
    });

    test('gravitational constant is accessible', () {
      expect(PhysicalConstants.gravitationalConstant, closeTo(6.67430e-11, 1e-15));
    });

    test('electromagnetic constants have correct values', () {
      expect(PhysicalConstants.fineStructureConstant, closeTo(7.2973525693e-3, 1e-13));
      expect(PhysicalConstants.vacuumPermeability, closeTo(4.0e-7 * 3.14159265358979, 1e-20));
      expect(PhysicalConstants.vacuumPermittivity, closeTo(8.8541878128e-12, 1e-22));
      expect(PhysicalConstants.bohrMagneton, closeTo(9.2740100783e-24, 1e-34));
      expect(PhysicalConstants.nuclearMagneton, closeTo(5.0507837461e-27, 1e-37));
    });

    test('quantum radiation constants have correct values', () {
      expect(PhysicalConstants.stefanBoltzmannConstant, closeTo(5.670374419e-8, 1e-18));
      expect(PhysicalConstants.wienDisplacementConstant, closeTo(2.897771955e-3, 1e-13));
      expect(PhysicalConstants.firstRadiationConstant, closeTo(3.741771852e-16, 1e-26));
      expect(PhysicalConstants.secondRadiationConstant, closeTo(1.438776877e-2, 1e-12));
    });

    test('additional particle masses are correct', () {
      expect(PhysicalConstants.neutronMass.inKilograms, closeTo(1.67492749804e-27, tolerance));
      expect(PhysicalConstants.deuteronMass.inKilograms, closeTo(3.3435837724e-27, tolerance));
      expect(
        PhysicalConstants.alphaParticleMass.inKilograms,
        closeTo(6.6446573357e-27, tolerance),
      );
    });

    test('derived charge-to-mass ratios have correct values', () {
      expect(PhysicalConstants.electronChargeToMassRatio, closeTo(1.75882001076e11, 1e0));
      expect(PhysicalConstants.protonChargeToMassRatio, closeTo(9.5788331560e7, 1e-3));
    });

    test('classical electron radius and Compton wavelength are correct', () {
      expect(PhysicalConstants.classicalElectronRadius, isA<Length>());
      expect(
        PhysicalConstants.classicalElectronRadius.inM,
        closeTo(2.8179403262e-15, tolerance),
      );
      expect(PhysicalConstants.electronComptonWavelength, isA<Length>());
      expect(
        PhysicalConstants.electronComptonWavelength.inM,
        closeTo(2.42631023867e-12, tolerance),
      );
    });

    test('proton rest energy is correct', () {
      expect(PhysicalConstants.protonRestEnergy, isA<Energy>());
      expect(PhysicalConstants.protonRestEnergy.inJoules, closeTo(1.50327759787e-10, tolerance));
    });

    test('length constants are correct Quantity types', () {
      expect(PhysicalConstants.bohrRadius, isA<Length>());
      expect(PhysicalConstants.bohrRadius.inAngstrom, closeTo(0.529, 0.001));
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

      // thermalEnergy
      final thermalE =
          PhysicalConstants.thermalEnergy(const Temperature(300, TemperatureUnit.kelvin));
      expect(thermalE, isA<Energy>());
      expect(thermalE.inJoules, closeTo(1.380649e-23 * 300, highTolerance));

      // deBroglieWavelength — electron at 1e6 m/s
      final wavelength = PhysicalConstants.deBroglieWavelength(
        PhysicalConstants.electronMass,
        1000000,
      );
      expect(wavelength, isA<Length>());
      // λ = h/(mv) = 6.626e-34 / (9.109e-31 * 1e6)
      expect(wavelength.inM, closeTo(6.62607015e-34 / (9.1093837015e-31 * 1000000), highTolerance));
    });

    test('deBroglieWavelength throws on zero velocity', () {
      expect(
        () => PhysicalConstants.deBroglieWavelength(PhysicalConstants.electronMass, 0),
        throwsArgumentError,
      );
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

    test('fundamental astronomical units have correct values', () {
      expect(AstronomicalConstants.astronomicalUnit, isA<Length>());
      expect(AstronomicalConstants.astronomicalUnit.inKilometers, closeTo(149597870.7, 1));
      expect(AstronomicalConstants.lightYear, isA<Length>());
      // Stored as its meter-equivalent value in lightYear units; test in own unit.
      expect(
        AstronomicalConstants.lightYear.getValue(LengthUnit.lightYear),
        closeTo(9.4607304725808e15, 1e8),
      );
      expect(AstronomicalConstants.parsec, isA<Length>());
      expect(
        AstronomicalConstants.parsec.getValue(LengthUnit.parsec),
        closeTo(3.0856775814913673e16, 1e9),
      );
    });

    test('solar body properties have correct values', () {
      expect(AstronomicalConstants.solarRadius, isA<Length>());
      expect(AstronomicalConstants.solarRadius.inKilometers, closeTo(695700, 10));
      expect(AstronomicalConstants.solarEffectiveTemperature, isA<Temperature>());
      expect(
        AstronomicalConstants.solarEffectiveTemperature.inKelvin,
        closeTo(5778, 1),
      );
    });

    test('moon and detailed Earth properties have correct values', () {
      expect(AstronomicalConstants.earthPolarRadius, isA<Length>());
      expect(AstronomicalConstants.earthPolarRadius.inKilometers, closeTo(6356.75, 1));
      expect(AstronomicalConstants.moonMass, isA<Mass>());
      expect(AstronomicalConstants.moonMass.inKilograms, closeTo(7.342e22, 1e18));
      expect(AstronomicalConstants.moonRadius, isA<Length>());
      expect(AstronomicalConstants.moonRadius.inKilometers, closeTo(1737, 1));
      expect(AstronomicalConstants.earthMoonDistance, isA<Length>());
      expect(AstronomicalConstants.earthMoonDistance.inKilometers, closeTo(384400, 100));
    });

    test('planetary masses and radii are correct', () {
      expect(AstronomicalConstants.mercuryMass.inKilograms, closeTo(3.301e23, 1e20));
      expect(AstronomicalConstants.mercuryRadius.inKilometers, closeTo(2439.7, 1));
      expect(AstronomicalConstants.venusMass.inKilograms, closeTo(4.867e24, 1e21));
      expect(AstronomicalConstants.venusRadius.inKilometers, closeTo(6051.8, 1));
      expect(AstronomicalConstants.marsMass.inKilograms, closeTo(6.39e23, 1e20));
      expect(AstronomicalConstants.marsRadius.inKilometers, closeTo(3389.5, 1));
      expect(AstronomicalConstants.jupiterRadius.inKilometers, closeTo(71492, 10));
      expect(AstronomicalConstants.saturnMass.inKilograms, closeTo(5.683e26, 1e23));
      expect(AstronomicalConstants.saturnRadius.inKilometers, closeTo(60268, 10));
      expect(AstronomicalConstants.uranusMass.inKilograms, closeTo(8.681e25, 1e22));
      expect(AstronomicalConstants.uranusRadius.inKilometers, closeTo(25559, 10));
      expect(AstronomicalConstants.neptuneMass.inKilograms, closeTo(1.024e26, 1e23));
      expect(AstronomicalConstants.neptuneRadius.inKilometers, closeTo(24764, 10));
    });

    test('galactic and cosmological constants are correct', () {
      expect(AstronomicalConstants.milkyWayMass, isA<Mass>());
      expect(AstronomicalConstants.milkyWayMass.inKilograms, closeTo(2.98e42, 1e39));
      expect(AstronomicalConstants.galacticCenterDistance, isA<Length>());
      expect(AstronomicalConstants.galacticCenterDistance.inM, closeTo(2.615e20, 1e17));
      expect(AstronomicalConstants.criticalDensity, closeTo(9.47e-27, 1e-29));
      expect(AstronomicalConstants.observableUniverseRadius, isA<Length>());
      expect(AstronomicalConstants.observableUniverseRadius.inM, closeTo(4.40e26, 1e23));
    });

    test('stellar and Planck-scale constants are correct', () {
      expect(AstronomicalConstants.chandrasekharLimit, isA<Mass>());
      expect(AstronomicalConstants.chandrasekharLimit.inKilograms, closeTo(2.785e30, 1e27));
      expect(AstronomicalConstants.solarMassSchwarzschildRadius, isA<Length>());
      expect(
        AstronomicalConstants.solarMassSchwarzschildRadius.inKilometers,
        closeTo(2.954, 0.01),
      );
      expect(AstronomicalConstants.planckMass, isA<Mass>());
      expect(AstronomicalConstants.planckMass.inKilograms, closeTo(2.176434e-8, 1e-14));
      expect(AstronomicalConstants.planckLength, isA<Length>());
      expect(AstronomicalConstants.planckLength.inM, closeTo(1.616255e-35, 1e-41));
      expect(AstronomicalConstants.planckTime, isA<Time>());
      expect(AstronomicalConstants.planckTime.inSeconds, closeTo(5.391247e-44, 1e-50));
    });

    test('Earth orbital and rotational properties are correct', () {
      expect(AstronomicalConstants.siderealDay, isA<Time>());
      expect(AstronomicalConstants.siderealDay.inSeconds, closeTo(86164.0905, 1));
      expect(AstronomicalConstants.siderealYear, isA<Time>());
      expect(AstronomicalConstants.siderealYear.inSeconds, closeTo(3.155815e7, 1000));
      expect(AstronomicalConstants.earthOrbitalVelocity, isA<Speed>());
      expect(AstronomicalConstants.earthOrbitalVelocity.inKilometersPerSecond, closeTo(29.78, 0.1));
      expect(AstronomicalConstants.geostationaryOrbitRadius, isA<Length>());
      expect(AstronomicalConstants.geostationaryOrbitRadius.inKilometers, closeTo(42164, 10));
      expect(AstronomicalConstants.solarConstant, closeTo(1361, 10));
    });

    test('cosmological times and temperatures are correct', () {
      expect(AstronomicalConstants.ageOfUniverse, isA<Time>());
      expect(AstronomicalConstants.ageOfUniverse.inSeconds, closeTo(4.35e17, 1e14));
      expect(AstronomicalConstants.cmbTemperature, isA<Temperature>());
      expect(AstronomicalConstants.cmbTemperature.inKelvin, closeTo(2.72548, 0.001));
    });

    test('orbitalVelocity returns correct speed for Earth around the Sun', () {
      final earthOrbit = AstronomicalConstants.orbitalVelocity(
        AstronomicalConstants.solarMass,
        AstronomicalConstants.astronomicalUnit,
      );
      expect(earthOrbit, isA<Speed>());
      // v = sqrt(GM/r) ≈ 29.78 km/s
      expect(earthOrbit.inKilometersPerSecond, closeTo(29.78, 0.5));
    });

    test('orbitalPeriod returns correct period for Earth around the Sun', () {
      final earthPeriod = AstronomicalConstants.orbitalPeriod(
        AstronomicalConstants.astronomicalUnit,
        AstronomicalConstants.solarMass,
      );
      expect(earthPeriod, isA<Time>());
      // T = 2π√(a³/GM) ≈ 3.156e7 s (365.25 days)
      expect(earthPeriod.inSeconds, closeTo(3.156e7, 1e5));
    });

    test('orbitalPeriod throws on zero or negative inputs', () {
      expect(
        () => AstronomicalConstants.orbitalPeriod(
          const Length(0, LengthUnit.meter),
          AstronomicalConstants.solarMass,
        ),
        throwsArgumentError,
      );
      expect(
        () => AstronomicalConstants.orbitalPeriod(
          AstronomicalConstants.astronomicalUnit,
          const Mass(0, MassUnit.kilogram),
        ),
        throwsArgumentError,
      );
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

      // reynoldsNumberPipe
      final re = EngineeringConstants.reynoldsNumberPipe(
        2.0.metersPerSecond,
        0.1.m,
        1.0e-6, // kinematic viscosity of water at 20°C (m²/s)
      );
      expect(re, isA<double>());
      expect(re, closeTo(200000, tolerance)); // 2 * 0.1 / 1e-6 = 200,000

      // pipePressureDrop
      final pressureDrop = EngineeringConstants.pipePressureDrop(
        0.02, // friction factor
        100.0.m, // length
        0.1.m, // diameter
        2.0.metersPerSecond, // velocity
        1000, // density of water (kg/m³)
      );
      expect(pressureDrop, isA<Pressure>());
      // Δp = f(L/D)(ρv²/2) = 0.02 * (100/0.1) * (1000 * 4 / 2) = 0.02 * 1000 * 2000 = 40,000 Pa
      expect(pressureDrop.inKiloPascals, closeTo(40.0, tolerance));

      // thermalExpansion
      final deltaLength = EngineeringConstants.thermalExpansion(
        10.0.m, // original length
        11.7e-6, // expansion coefficient of steel (1/K)
        const Temperature(100, TemperatureUnit.kelvin), // temperature change
      );
      expect(deltaLength, isA<Length>());
      // ΔL = L₀αΔT = 10 * 11.7e-6 * 100 = 0.0117 m = 11.7 mm
      expect(deltaLength.inMm, closeTo(11.7, tolerance));

      // electricalResistance
      final resistance = EngineeringConstants.electricalResistance(
        1.68e-8, // resistivity of copper (Ω⋅m)
        100.0.m, // length
        1.0e-6.m2, // cross-section area (1 mm²)
      );
      expect(resistance, isA<double>());
      // R = ρL/A = 1.68e-8 * 100 / 1e-6 = 1.68 Ω
      expect(resistance, closeTo(1.68, tolerance));
    });

    test("mechanicalStrain throws on zero Young's modulus", () {
      expect(
        () => EngineeringConstants.mechanicalStrain(
          100.megaPascals,
          const Pressure(0, PressureUnit.pascal),
        ),
        throwsArgumentError,
      );
    });

    test('temperature reference points have correct values', () {
      expect(EngineeringConstants.normalTemperature, isA<Temperature>());
      expect(EngineeringConstants.normalTemperature.inCelsius, closeTo(20.0, tolerance));
      expect(EngineeringConstants.roomTemperature, isA<Temperature>());
      expect(EngineeringConstants.roomTemperature.inCelsius, closeTo(22.0, tolerance));
      expect(EngineeringConstants.waterFreezingPoint, isA<Temperature>());
      expect(EngineeringConstants.waterFreezingPoint.inCelsius, closeTo(0.0, tolerance));
      expect(EngineeringConstants.waterBoilingPoint, isA<Temperature>());
      expect(EngineeringConstants.waterBoilingPoint.inCelsius, closeTo(100.0, tolerance));
      expect(EngineeringConstants.bodyTemperature, isA<Temperature>());
      expect(EngineeringConstants.bodyTemperature.inCelsius, closeTo(37.0, tolerance));
    });

    test('material double constants have correct values', () {
      expect(EngineeringConstants.waterDensityMax, closeTo(999.97, 0.01));
      expect(EngineeringConstants.airDensitySTP, closeTo(1.225, 0.001));
      expect(EngineeringConstants.waterViscosity20C, closeTo(1.002e-3, 1e-6));
      expect(EngineeringConstants.airViscosity20C, closeTo(1.81e-5, 1e-7));
      expect(EngineeringConstants.copperThermalConductivity, closeTo(401, 1));
      expect(EngineeringConstants.waterSpecificHeat, closeTo(4184, 1));
      expect(EngineeringConstants.waterLatentHeatVaporization, closeTo(2.26e6, 1e3));
      expect(EngineeringConstants.waterLatentHeatFusion, closeTo(3.34e5, 100));
      expect(EngineeringConstants.copperResistivity, closeTo(1.68e-8, 1e-10));
      expect(EngineeringConstants.steelThermalExpansion, closeTo(1.2e-5, 1e-7));
      expect(EngineeringConstants.methaneHeatingValue, closeTo(5.0e7, 1e4));
      expect(EngineeringConstants.gasolineAirFuelRatio, closeTo(14.7, 0.1));
      expect(EngineeringConstants.steelPoissonsRatio, closeTo(0.29, 0.01));
      expect(EngineeringConstants.aluminumPoissonsRatio, closeTo(0.33, 0.01));
      expect(EngineeringConstants.concretePoissonsRatio, closeTo(0.20, 0.01));
    });

    test('additional mechanical properties have correct values', () {
      expect(EngineeringConstants.concreteYoungsModulus, isA<Pressure>());
      expect(EngineeringConstants.concreteYoungsModulus.inMegaPascals, closeTo(30000, 1000));
      expect(EngineeringConstants.steelYieldStrength, isA<Pressure>());
      expect(EngineeringConstants.steelYieldStrength.inMegaPascals, closeTo(250, 10));
      expect(EngineeringConstants.atomicMassUnit, isA<Mass>());
      expect(
        EngineeringConstants.atomicMassUnit.inKilograms,
        closeTo(1.66053906660e-27, 1e-37),
      );
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
