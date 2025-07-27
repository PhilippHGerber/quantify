// ignore_for_file: prefer_int_literals // All constants are doubles for precision.

import 'dart:math' as math;

/// Defines base conversion factors for various frequency units relative to the
/// Hertz (Hz), which is the SI derived unit for frequency (s⁻¹).
///
/// These constants represent: `1 [Unit] = Z [Hertz]`.
class FrequencyFactors {
  // --- SI Prefixed Units (relative to Hertz) ---

  /// Hertz per Terahertz: 1 THz = 1e12 Hz.
  static const double hzPerTerahertz = 1e12;

  /// Hertz per Gigahertz: 1 GHz = 1e9 Hz.
  static const double hzPerGigahertz = 1e9;

  /// Hertz per Megahertz: 1 MHz = 1e6 Hz.
  static const double hzPerMegahertz = 1e6;

  /// Hertz per Kilohertz: 1 kHz = 1e3 Hz.
  static const double hzPerKilohertz = 1e3;

  // --- Rotational / Event-based Units ---

  /// Hertz per Revolution Per Minute (RPM): 1 rev/min = (1/60) rev/s = (1/60) Hz.
  static const double hzPerRpm = 1.0 / 60.0;

  /// Hertz per Beats Per Minute (BPM): Same as RPM.
  static const double hzPerBpm = 1.0 / 60.0;

  /// Hertz per Radian per second (rad/s): 1 rad/s = 1/(2π) Hz.
  /// Since 1 rev/s (or 1 Hz) is 2π rad/s.
  static const double hzPerRadPerSecond = 1.0 / (2 * math.pi);

  /// Hertz per Degree per second (deg/s): 1 deg/s = 1/360 Hz.
  /// Since 1 rev/s (or 1 Hz) is 360 deg/s.
  static const double hzPerDegPerSecond = 1.0 / 360.0;
}
