// ignore_for_file: prefer_int_literals // All constants are doubles for precision.

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

  // Note: Revolutions Per Second (RPS) is not included as a separate factor
  // because 1 RPS is exactly 1 Hz, making its factor 1.0.
}
