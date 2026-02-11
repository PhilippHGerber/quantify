/// Defines base conversion factors for various acceleration units relative to the
/// Meter per Second Squared (m/s²), which is the SI derived unit for acceleration.
///
/// These constants represent: `1 [Unit] = Z [Meters Per Second Squared]`.
class AccelerationFactors {
  /// Meters per second squared per Standard Gravity (g): 1 g = 9.80665 m/s² (exact by convention).
  /// This is the acceleration due to gravity at sea level at about 45° latitude.
  static const double mpssPerStandardGravity = 9.80665;

  /// Meters per second squared per Kilometer per hour per second:
  /// 1 (km/h)/s = (1000m / 3600s) / s = 1000/3600 m/s².
  static const double mpssPerKmhPerSec = 1000.0 / 3600.0;

  /// Meters per second squared per Mile per hour per second:
  /// 1 (mph)/s = (1609.344m / 3600s) / s.
  static const double mpssPerMphPerSec = 1609.344 / 3600.0;

  /// Meters per second squared per Knot per second:
  /// 1 (kn)/s = (1852m / 3600s) / s.
  static const double mpssPerKnotPerSec = 1852.0 / 3600.0;

  /// Meters per second squared per Foot per second squared:
  /// 1 ft/s² = 0.3048 m/s².
  static const double mpssPerFpsSquared = 0.3048;

  /// Meters per second squared per Centimeter per second squared (Galileo):
  /// 1 cm/s² = 0.01 m/s².
  static const double mpssPerCmpss = 0.01;
}
