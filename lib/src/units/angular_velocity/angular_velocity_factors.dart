import '../angle/angle_factors.dart';

/// Defines base conversion factors for various angular velocity units relative
/// to the Radian per Second (rad/s), which is the SI-derived unit.
///
/// These constants represent: `1 [Unit] = Z [Radians Per Second]`.
class AngularVelocityFactors {
  /// Radians per second per Degree per second: 1 °/s = (π/180) rad/s.
  static const double radPerSec_per_degPerSec = AngleFactors.radiansPerDegree;

  /// Radians per second per Revolution per minute (RPM): 1 rev/min = (2π/60) rad/s.
  static const double radPerSec_per_revPerMin = AngleFactors.radiansPerRevolution / 60.0;

  /// Radians per second per Revolution per second (RPS): 1 rev/s = 2π rad/s.
  static const double radPerSec_per_revPerSec = AngleFactors.radiansPerRevolution;
}
