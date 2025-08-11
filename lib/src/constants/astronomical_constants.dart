import 'dart:math' as math;

import '../../acceleration.dart';
import '../../frequency.dart';
import '../../length.dart';
import '../../mass.dart';
import '../../power.dart';
import '../../speed.dart';
import '../../temperature.dart';
import '../../time.dart';
import 'physical_constants.dart';

/// Astronomical and astrophysical constants with their respective units.
///
/// All constants are based on IAU (International Astronomical Union)
/// recommendations and recent astronomical measurements.
///
/// References:
/// - IAU 2015 Resolution B3: https://www.iau.org/static/resolutions/IAU2015_English.pdf
/// - NASA Planetary Fact Sheets: https://nssdc.gsfc.nasa.gov/planetary/factsheet/
/// - CODATA 2018 values for fundamental constants
class AstronomicalConstants {
  // Private constructor to prevent instantiation
  AstronomicalConstants._();

  // === FUNDAMENTAL ASTRONOMICAL UNITS ===

  /// Astronomical Unit (AU).
  /// Value: 149,597,870.7 km (exact by IAU definition).
  ///
  /// The average distance from the Earth to the Sun, used as a fundamental
  /// unit for distances within the Solar System.
  static const Length astronomicalUnit = Length(149597870700, LengthUnit.meter);

  /// Light Year (ly).
  /// Value: 9.4607304725808×10¹⁵ m.
  ///
  /// The distance light travels in one Julian year (365.25 days).
  static const Length lightYear = Length(9460730472580800, LengthUnit.lightYear);

  /// Parsec (pc).
  /// Value: 3.0856775814913673×10¹⁶ m.
  ///
  /// The distance at which one astronomical unit subtends an angle of one arcsecond.
  static const Length parsec = Length(30856775814913672, LengthUnit.parsec);

  // === SOLAR SYSTEM BODIES ===

  /// Solar mass (M☉).
  /// Value: 1.98847×10³⁰ kg.
  ///
  /// The total mass of the Sun, a fundamental unit for stellar masses.
  static const Mass solarMass = Mass(1.98847e30, MassUnit.kilogram);

  /// Solar radius (R☉).
  /// Value: 6.957×10⁸ m.
  ///
  /// The radius of the Sun from its center to the photosphere.
  static const Length solarRadius = Length(695700000, LengthUnit.meter);

  /// Solar luminosity (L☉).
  /// Value: 3.828×10²⁶ W.
  ///
  /// The total power output of the Sun.
  static const Power solarLuminosity = Power(3.828e26, PowerUnit.watt);

  /// Solar effective temperature.
  /// Value: 5778 K.
  ///
  /// The effective black-body temperature of the Sun's photosphere.
  static const Temperature solarEffectiveTemperature = Temperature(5778, TemperatureUnit.kelvin);

  /// Earth mass (M⊕).
  /// Value: 5.9722×10²⁴ kg.
  ///
  /// The total mass of Earth, a fundamental unit for terrestrial planet masses.
  static const Mass earthMass = Mass(5.9722e24, MassUnit.kilogram);

  /// Earth equatorial radius (R⊕).
  /// Value: 6.37814×10⁶ m.
  ///
  /// Earth's radius at the equator.
  static const Length earthRadius = Length(6378140, LengthUnit.meter);

  /// Earth polar radius.
  /// Value: 6.35675×10⁶ m.
  ///
  /// Earth's radius at the poles, reflecting its oblate shape.
  static const Length earthPolarRadius = Length(6356750, LengthUnit.meter);

  /// Moon mass.
  /// Value: 7.342×10²² kg.
  static const Mass moonMass = Mass(7.342e22, MassUnit.kilogram);

  /// Moon radius.
  /// Value: 1.737×10⁶ m.
  static const Length moonRadius = Length(1737000, LengthUnit.meter);

  /// Earth-Moon distance (semi-major axis).
  /// Value: 3.844×10⁸ m.
  static const Length earthMoonDistance = Length(384400000, LengthUnit.meter);

  // === PLANETARY MASSES ===

  /// Mercury mass.
  /// Value: 3.301×10²³ kg.
  static const Mass mercuryMass = Mass(3.301e23, MassUnit.kilogram);

  /// Mercury radius (mean).
  /// Value: 2.4397×10⁶ m.
  /// Source: NASA Planetary Fact Sheet.
  static const Length mercuryRadius = Length(2439700, LengthUnit.meter);

  /// Venus mass.
  /// Value: 4.867×10²⁴ kg.
  static const Mass venusMass = Mass(4.867e24, MassUnit.kilogram);

  /// Venus radius (mean).
  /// Value: 6.0518×10⁶ m.
  /// Source: NASA Planetary Fact Sheet.
  static const Length venusRadius = Length(6051800, LengthUnit.meter);

  /// Mars mass.
  /// Value: 6.39×10²³ kg.
  static const Mass marsMass = Mass(6.39e23, MassUnit.kilogram);

  /// Mars radius (mean).
  /// Value: 3.3895×10⁶ m.
  /// Source: NASA Planetary Fact Sheet.
  static const Length marsRadius = Length(3389500, LengthUnit.meter);

  /// Jupiter mass (MJ).
  /// Value: 1.898×10²⁷ kg.
  ///
  /// A fundamental unit for gas giant masses.
  static const Mass jupiterMass = Mass(1.898e27, MassUnit.kilogram);

  /// Jupiter radius (equatorial).
  /// Value: 7.1492×10⁷ m.
  /// Source: NASA Planetary Fact Sheet.
  static const Length jupiterRadius = Length(71492000, LengthUnit.meter);

  /// Saturn mass.
  /// Value: 5.683×10²⁶ kg.
  static const Mass saturnMass = Mass(5.683e26, MassUnit.kilogram);

  /// Saturn radius (equatorial).
  /// Value: 6.0268×10⁷ m.
  /// Source: NASA Planetary Fact Sheet.
  static const Length saturnRadius = Length(60268000, LengthUnit.meter);

  /// Uranus mass.
  /// Value: 8.681×10²⁵ kg.
  static const Mass uranusMass = Mass(8.681e25, MassUnit.kilogram);

  /// Uranus radius (equatorial).
  /// Value: 2.5559×10⁷ m.
  /// Source: NASA Planetary Fact Sheet.
  static const Length uranusRadius = Length(25559000, LengthUnit.meter);

  /// Neptune mass.
  /// Value: 1.024×10²⁶ kg.
  static const Mass neptuneMass = Mass(1.024e26, MassUnit.kilogram);

  /// Neptune radius (equatorial).
  /// Value: 2.4764×10⁷ m.
  /// Source: NASA Planetary Fact Sheet.
  static const Length neptuneRadius = Length(24764000, LengthUnit.meter);

  // === GALACTIC AND EXTRAGALACTIC ===

  /// Milky Way mass.
  /// Value: ~1.5×10¹² M☉ ≈ 2.98×10⁴² kg.
  ///
  /// The estimated total mass of the Milky Way galaxy, including dark matter.
  static const Mass milkyWayMass = Mass(2.98e42, MassUnit.kilogram);

  /// Galactic center distance.
  /// Value: 2.615×10²⁰ m ≈ 26,000 ly.
  ///
  /// The distance from the Solar System to Sagittarius A*, the galactic center.
  static const Length galacticCenterDistance = Length(2.615e20, LengthUnit.meter);

  /// Hubble constant (H₀).
  /// Value: 67.4 km/(s⋅Mpc) ≈ 2.18×10⁻¹⁸ s⁻¹.
  ///
  /// The current expansion rate of the universe. Represented as a [Frequency]
  /// in its base unit of inverse seconds (s⁻¹).
  static const Frequency hubbleConstant = Frequency(2.18e-18, FrequencyUnit.hertz);

  /// Critical density of the universe.
  /// Value: 9.47×10⁻²⁷ kg/m³.
  ///
  /// The mass-energy density required for a flat universe geometry.
  /// Note: This would ideally be a `Density` quantity.
  static const double criticalDensity = 9.47e-27; // kg/m³

  /// Observable universe radius.
  /// Value: 4.40×10²⁶ m ≈ 46.5 billion ly.
  ///
  /// The current proper distance to the edge of the observable universe.
  static const Length observableUniverseRadius = Length(4.40e26, LengthUnit.meter);

  // === STELLAR CONSTANTS ===

  /// Chandrasekhar limit.
  /// Value: 2.785×10³⁰ kg ≈ 1.4 M☉.
  ///
  /// The maximum mass of a stable white dwarf star.
  static const Mass chandrasekharLimit = Mass(2.785e30, MassUnit.kilogram);

  /// Schwarzschild radius of a solar mass black hole.
  /// Value: 2.954×10³ m ≈ 2.95 km.
  ///
  /// The event horizon radius for a non-rotating black hole with the mass of the Sun.
  static const Length solarMassSchwarzschildRadius = Length(2954, LengthUnit.meter);

  /// Planck mass.
  /// Value: 2.176434×10⁻⁸ kg.
  ///
  /// A fundamental mass scale in quantum gravity.
  static const Mass planckMass = Mass(2.176434e-8, MassUnit.kilogram);

  /// Planck length.
  /// Value: 1.616255×10⁻³⁵ m.
  ///
  /// A fundamental length scale in quantum gravity.
  static const Length planckLength = Length(1.616255e-35, LengthUnit.meter);

  /// Planck time.
  /// Value: 5.391247×10⁻⁴⁴ s.
  ///
  /// A fundamental time scale in quantum gravity.
  static const Time planckTime = Time(5.391247e-44, TimeUnit.second);

  // === EARTH PROPERTIES ===

  /// Standard gravity (g₀).
  /// Value: 9.80665 m/s² (exact by definition).
  ///
  /// The standard acceleration due to gravity at Earth's surface.
  static const Acceleration standardGravity = Acceleration(
    9.80665,
    AccelerationUnit.meterPerSecondSquared,
  );

  /// Earth's rotational period (sidereal day).
  /// Value: 86164.0905 s ≈ 23h 56m 4s.
  ///
  /// The time for one rotation of Earth relative to distant stars.
  static const Time siderealDay = Time(86164.0905, TimeUnit.second);

  /// Earth's orbital period (sidereal year).
  /// Value: 3.155815×10⁷ s ≈ 365.256 days.
  ///
  /// The time for one orbit of Earth around the Sun.
  static const Time siderealYear = Time(31558150, TimeUnit.second);

  /// Earth's mean orbital velocity.
  /// Value: 29.78 km/s.
  /// Source: NASA Planetary Fact Sheet.
  static const Speed earthOrbitalVelocity = Speed(29780, SpeedUnit.meterPerSecond);

  /// Geostationary orbit radius, measured from Earth's center.
  /// Value: 42,164 km.
  /// The altitude at which an object's orbital period matches Earth's rotational period.
  static const Length geostationaryOrbitRadius = Length(42164000, LengthUnit.meter);

  /// Solar constant.
  /// The mean solar electromagnetic radiation per unit area that would be incident
  /// on a plane perpendicular to the rays, at a distance of one astronomical unit (AU) from the Sun.
  /// Value: ~1361 W/m².
  /// Note: This would ideally be an `Irradiance` quantity (Power/Area).
  static const double solarConstant = 1361;

  /// Escape velocity from Earth's surface.
  /// Value: 1.119×10⁴ m/s ≈ 11.19 km/s.
  ///
  /// The minimum speed needed for an object to escape from Earth's gravitational
  /// influence without further propulsion.
  static const Speed earthEscapeVelocity = Speed(11190, SpeedUnit.meterPerSecond);

  // === COSMOLOGICAL TIMES ===

  /// Age of the universe.
  /// Value: 4.35×10¹⁷ s ≈ 13.8 billion years.
  ///
  /// The time elapsed since the Big Bang.
  static const Time ageOfUniverse = Time(435000000000000000, TimeUnit.second);

  /// Cosmic microwave background temperature.
  /// Value: 2.72548 K.
  ///
  /// The current temperature of the cosmic microwave background radiation.
  static const Temperature cmbTemperature = Temperature(2.72548, TemperatureUnit.kelvin);

  // === CONVENIENCE METHODS ===

  /// Calculates the gravitational acceleration at the surface of a celestial body.
  ///
  /// Returns the acceleration as an [Acceleration] quantity.
  /// Usage: `final g = AstronomicalConstants.surfaceGravity(earthMass, earthRadius);`
  static Acceleration surfaceGravity(Mass bodyMass, Length bodyRadius) {
    final mass = bodyMass.getValue(MassUnit.kilogram);
    final radius = bodyRadius.getValue(LengthUnit.meter);
    const gravConstant = PhysicalConstants.gravitationalConstant;
    final accelerationValue = gravConstant * mass / (radius * radius); // g = GM/r²
    return Acceleration(accelerationValue, AccelerationUnit.meterPerSecondSquared);
  }

  /// Calculates the escape velocity from the surface of a celestial body.
  ///
  /// Returns the velocity as a [Speed] quantity.
  /// Usage: `final v = AstronomicalConstants.escapeVelocity(earthMass, earthRadius);`
  static Speed escapeVelocity(Mass bodyMass, Length bodyRadius) {
    final mass = bodyMass.getValue(MassUnit.kilogram);
    final radius = bodyRadius.getValue(LengthUnit.meter);
    const gravConstant = PhysicalConstants.gravitationalConstant;
    final v2 = 2.0 * gravConstant * mass / radius; // v² = 2GM/r
    return Speed(math.sqrt(v2), SpeedUnit.meterPerSecond);
  }

  /// Calculates the velocity for a circular orbit at a given radius from a central mass.
  ///
  /// Returns the velocity as a [Speed] quantity.
  /// Usage: `final v = AstronomicalConstants.orbitalVelocity(earthMass, satelliteOrbitRadius);`
  static Speed orbitalVelocity(Mass centralMass, Length orbitalRadius) {
    final mass = centralMass.getValue(MassUnit.kilogram);
    final radius = orbitalRadius.getValue(LengthUnit.meter);
    const gravConstant = PhysicalConstants.gravitationalConstant;
    final v2 = gravConstant * mass / radius; // v² = GM/r
    return Speed(math.sqrt(v2), SpeedUnit.meterPerSecond);
  }

  /// Calculates the Schwarzschild radius (event horizon) for a given mass.
  ///
  /// Returns the radius as a [Length] quantity.
  /// Usage: `final rs = AstronomicalConstants.schwarzschildRadius(solarMass);`
  static Length schwarzschildRadius(Mass mass) {
    final massInKg = mass.getValue(MassUnit.kilogram);
    const gravConstant = PhysicalConstants.gravitationalConstant;
    final speedOfLightMs = PhysicalConstants.speedOfLight.inMetersPerSecond;
    final rs = 2.0 * gravConstant * massInKg / (speedOfLightMs * speedOfLightMs); // rs = 2GM/c²
    return Length(rs, LengthUnit.meter);
  }

  /// Calculates the orbital period of a body around a central mass using
  /// Kepler's third law.
  ///
  /// `T = 2π * sqrt(a³ / GM)`
  ///
  /// - [semiMajorAxis]: The semi-major axis of the orbit.
  /// - [centralMass]: The mass of the central body being orbited.
  ///
  /// Returns the orbital period as a [Time] quantity in seconds.
  /// Throws [ArgumentError] if the central mass or semi-major axis is zero.
  static Time orbitalPeriod(Length semiMajorAxis, Mass centralMass) {
    if (centralMass.value <= 0 || semiMajorAxis.value <= 0) {
      throw ArgumentError('Central mass and semi-major axis must be positive.');
    }
    final a3 = math.pow(semiMajorAxis.inM, 3);
    final gm = PhysicalConstants.gravitationalConstant * centralMass.inKilograms;
    final seconds = 2 * math.pi * math.sqrt(a3 / gm);
    return Time(seconds, TimeUnit.second);
  }
}
