/// Physical, astronomical, and engineering constants for the quantify package.
///
/// This library provides type-safe access to fundamental constants with
/// appropriate units from physics, astronomy, and engineering.
/// By importing this single file, you gain access to all three constant
/// categories.
///
/// ## Usage
///
/// ```dart
/// import 'package:quantify/quantify.dart';
/// import 'package:quantify/constants.dart';
///
/// void main() {
///   // Physical constants are now type-safe Quantities where possible
///   final lightSpeed = PhysicalConstants.speedOfLight;
///   final electronEnergy = PhysicalConstants.electronRestEnergy;
///
///   // Astronomical constants
///   final earthGravity = AstronomicalConstants.standardGravity;
///   final sunPower = AstronomicalConstants.solarLuminosity;
///
///   // Engineering constants
///   final steelStiffness = EngineeringConstants.steelYoungsModulus;
///
///   // Use in convenience methods for powerful, type-safe calculations
///   final photonEnergy = PhysicalConstants.photonEnergy(500.0.nm);
///   final escapeVelocity = AstronomicalConstants.escapeVelocity(
///     AstronomicalConstants.earthMass,
///     AstronomicalConstants.earthRadius,
///   );
///
///   print('Speed of light: ${lightSpeed.asKilometersPerHour}');
///   print('Earth standard gravity:  ');
///   print('${earthGravity.asMetersPerSecondSquared}');
///   print('Energy of a 500nm photon: ');
///   print('${photonEnergy.inElectronvolts.toStringAsFixed(2)} eV');
/// }
/// ```
///
/// ## Constant Categories
///
/// ### PhysicalConstants
/// Fundamental constants from physics including the speed of light,
/// Planck constant, elementary charge, particle masses, quantum and
/// electromagnetic constants, and convenience methods for common
/// physics calculations.
///
/// ### AstronomicalConstants
/// Constants from astronomy and astrophysics including solar system
/// body properties (masses, radii, distances), galactic and cosmological
/// scales, stellar physics constants, and convenience methods for orbital
/// mechanics.
///
/// ### EngineeringConstants
/// Practical constants for engineering including standard conditions
/// (STP, NTP), material properties (density, strength),
/// mechanical properties (Young's modulus), and convenience methods
/// for common engineering calculations.
library;

export 'src/constants/astronomical_constants.dart';
export 'src/constants/engineering_constants.dart';
export 'src/constants/physical_constants.dart';
