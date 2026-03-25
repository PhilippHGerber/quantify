import 'dart:math' as math;

/// Defines base conversion factors for various angle units relative to the
/// Radian (rad), which is the SI-derived unit for plane angle and the
/// standard for `dart:math`.
class AngleFactors {
  // --- Factors to convert FROM a unit TO Radians (the base unit) ---
  // Formula: 1 [Unit] = Z [Radians]

  /// Radians per Revolution. Base for other cyclic units.
  static const double radiansPerRevolution = 2 * math.pi;

  /// Radians per Degree.
  /// Defined exactly to ensure precision in non-radian conversions.
  static const double radiansPerDegree = radiansPerRevolution / 360.0;

  /// Radians per Gradian.
  /// Defined exactly to ensure precision in non-radian conversions.
  static const double radiansPerGradian = radiansPerRevolution / 400.0;

  /// Radians per Arcminute.
  static const double radiansPerArcminute = radiansPerRevolution / (360.0 * 60.0);

  /// Radians per Arcsecond.
  static const double radiansPerArcsecond = radiansPerRevolution / (360.0 * 3600.0);

  /// Radians per Milliradian.
  static const double radiansPerMilliradian = 0.001;
}
