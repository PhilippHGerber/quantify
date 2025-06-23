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
  static const double radiansPerDegree = radiansPerRevolution / 360.0;

  /// Radians per Gradian.
  static const double radiansPerGradian = radiansPerRevolution / 400.0;

  /// Radians per Arcminute.
  static const double radiansPerArcminute = radiansPerDegree / 60.0;

  /// Radians per Arcsecond.
  static const double radiansPerArcsecond = radiansPerArcminute / 60.0;

  /// Radians per Milliradian.
  static const double radiansPerMilliradian = 0.001;

  // --- Factors to convert FROM Radians TO a unit ---
  // This avoids division of imprecise doubles in the const constructor.
  // Formula: 1 Radian = Z [Unit]

  /// Degrees per Radian.
  static const double degreesPerRadian = 180.0 / math.pi;

  /// Gradians per Radian.
  static const double gradiansPerRadian = 200.0 / math.pi;

  /// Revolutions per Radian.
  static const double revolutionsPerRadian = 1.0 / (2 * math.pi);

  /// Arcminutes per Radian.
  static const double arcminutesPerRadian = degreesPerRadian * 60.0;

  /// Arcseconds per Radian.
  static const double arcsecondsPerRadian = arcminutesPerRadian * 60.0;

  /// Milliradians per Radian.
  static const double milliradiansPerRadian = 1000;
}
