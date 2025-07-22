import 'dart:math' as math;

/// Defines base conversion factors for various solid angle units relative to the
/// Steradian (sr), which is the SI derived unit for solid angle.
///
/// These constants represent: `1 [Unit] = Z [Steradians]`.
class SolidAngleFactors {
  /// Steradians per Square Degree: (π/180)².
  /// This is derived from the conversion of one degree to radians, squared.
  static const double steradiansPerSquareDegree = (math.pi / 180.0) * (math.pi / 180.0);

  /// Steradians per Spat: The solid angle of a full sphere, which is 4π steradians.
  /// A spat is an obsolete unit for a full sphere solid angle.
  static const double steradiansPerSpat = 4 * math.pi;
}
