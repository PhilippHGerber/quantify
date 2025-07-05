// ignore_for_file: prefer_int_literals // All constants are doubles for precision.

/// Defines base conversion factors for various speed units relative to the
/// Meter per Second (m/s), which is the SI derived unit for speed.
///
/// These constants represent: `1 [Unit] = Z [Meters Per Second]`.
/// So, `mpsPerKmh` means `1 kilometer per hour = mpsPerKmh meters per second`.
class SpeedFactors {
  /// Meters per second per Kilometer per hour: 1 km/h = 1000m / 3600s.
  static const double mpsPerKmh = 1000.0 / 3600.0;

  /// Meters per second per Mile per hour: 1 mph = 1609.344m / 3600s.
  /// (based on the exact definition of a mile in meters).
  static const double mpsPerMph = 1609.344 / 3600.0;

  /// Meters per second per Knot: 1 kn = 1852m / 3600s.
  /// (based on the international definition of a nautical mile).
  static const double mpsPerKnot = 1852.0 / 3600.0;

  /// Meters per second per Foot per second: 1 ft/s = 0.3048 m/s.
  /// (based on the exact definition of a foot in meters).
  static const double mpsPerFps = 0.3048;

  // --- Other potential units (can be added if needed) ---
  // Example: Speed of Light (c)
  // /// Meters per second per speed of light: 1 c = 299792458 m/s.
  // static const double mpsPerSpeedOfLight = 299792458.0;
}
