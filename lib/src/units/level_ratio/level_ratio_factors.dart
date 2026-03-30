import 'dart:math' as math;

/// Defines conversion constants for logarithmic level ratios.
class LevelRatioFactors {
  /// Decibels per neper using the amplitude convention.
  static const double decibelsPerNeper = 20.0 / math.ln10;

  /// Nepers per decibel using the amplitude convention.
  static const double nepersPerDecibel = math.ln10 / 20.0;
}
