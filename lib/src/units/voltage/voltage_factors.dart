// ignore_for_file: prefer_int_literals // All constants are doubles for precision in calculations.

/// Defines base conversion factors for various electric potential (voltage) units
/// relative to the Volt (V), which is the SI derived unit.
///
/// These constants represent: `1 [Unit] = Z [Volts]`.
/// So, `voltsPerMillivolt` means `1 millivolt = voltsPerMillivolt volts`.
class VoltageFactors {
  // --- SI Prefixed Units (relative to Volt) ---

  /// Volts per Nanovolt: 1 nanovolt (nV) = 1e-9 volts (V).
  static const double voltsPerNanovolt = 1.0e-9;

  /// Volts per Microvolt: 1 microvolt (µV) = 1e-6 volts (V).
  static const double voltsPerMicrovolt = 0.000001; // 1e-6

  /// Volts per Millivolt: 1 millivolt (mV) = 0.001 volts (V).
  static const double voltsPerMillivolt = 0.001;

  /// Volts per Kilovolt: 1 kilovolt (kV) = 1000 volts (V).
  static const double voltsPerKilovolt = 1000.0;

  /// Volts per Megavolt: 1 megavolt (MV) = 1,000,000 volts (V).
  static const double voltsPerMegavolt = 1000000.0;

  /// Volts per Gigavolt: 1 gigavolt (GV) = 1,000,000,000 volts (V).
  static const double voltsPerGigavolt = 1000000000.0;

  // --- Non-SI Units ---

  /// Volts per Statvolt: 1 statvolt (statV) ≈ 299.792458 volts (V).
  /// The statvolt is the CGS electrostatic unit of electric potential.
  static const double voltsPerStatvolt = 299.792458;

  /// Volts per Abvolt: 1 abvolt (abV) = 1e-8 volts (V).
  /// The abvolt is the CGS electromagnetic unit of electric potential.
  static const double voltsPerAbvolt = 1.0e-8;
}
