/// Physical, astronomical, and engineering constants for the quantify package.
///
/// This library provides type-safe access to fundamental constants with
/// appropriate units from physics, astronomy, and engineering.
///
/// ## Usage
///
/// ```dart
/// import 'package:quantify/constants.dart';
///
/// // Physical constants
/// final lightSpeed = PhysicalConstants.speedOfLightPerSecond;
/// final electronMass = PhysicalConstants.electronMass;
///
/// // Astronomical constants
/// final earthMass = AstronomicalConstants.earthMass;
/// final solarRadius = AstronomicalConstants.solarRadius;
///
/// // Engineering constants
/// final roomTemp = EngineeringConstants.roomTemperature;
/// final steelModulus = EngineeringConstants.steelYoungsModulus;
///
/// // Convenience calculations
/// final photonEnergy = PhysicalConstants.photonEnergy(500.0.nm);
/// final escapeVel = AstronomicalConstants.escapeVelocity(earthMass, earthRadius);
/// ```
///
/// ## Categories
///
/// ### PhysicalConstants
/// Fundamental constants from physics including:
/// - Speed of light, Planck constant, elementary charge
/// - Particle masses (electron, proton, neutron)
/// - Quantum and electromagnetic constants
/// - Convenience methods for common physics calculations
///
/// ### AstronomicalConstants
/// Constants from astronomy and astrophysics including:
/// - Solar system bodies (masses, radii, distances)
/// - Galactic and cosmological scales
/// - Stellar physics constants
/// - Convenience methods for orbital mechanics
///
/// ### EngineeringConstants
/// Practical constants for engineering including:
/// - Standard conditions (STP, NTP, atmospheric pressure)
/// - Material properties (density, thermal conductivity, etc.)
/// - Mechanical properties (Young's modulus, strength)
/// - Convenience methods for engineering calculations
///
/// ## Type Safety
///
/// All constants are provided with appropriate Quantity types where possible:
/// ```dart
/// final distance = PhysicalConstants.bohrRadius; // Returns Length
/// final mass = AstronomicalConstants.earthMass;   // Returns Mass
/// final temp = EngineeringConstants.roomTemperature; // Returns Temperature
/// ```
///
/// Constants requiring compound units not yet implemented are provided
/// as doubles with clear documentation of their units.
///
/// ## Future Extensions
///
/// As more Quantity types are added to quantify (Speed, Energy, Force, etc.),
/// the constants will be updated to use these types for even better type safety.
library;

// Export all constant classes
export 'src/constants/astronomical_constants.dart';
export 'src/constants/engineering_constants.dart';
export 'src/constants/physical_constants.dart';
