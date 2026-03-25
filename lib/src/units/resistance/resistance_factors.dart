// ignore_for_file: prefer_int_literals // All constants are doubles for precision in calculations.

/// Defines base conversion factors for various electrical resistance units
/// relative to the Ohm (Ω), which is the SI derived unit.
///
/// These constants represent: `1 [Unit] = Z [Ohms]`.
/// So, `ohmsPerKiloohm` means `1 kiloohm = ohmsPerKiloohm ohms`.
class ResistanceFactors {
  // --- SI Prefixed Units (relative to Ohm) ---

  /// Ohms per Nanoohm: 1 nanoohm (nΩ) = 1e-9 ohms (Ω).
  static const double ohmsPerNanoohm = 1.0e-9;

  /// Ohms per Microohm: 1 microohm (µΩ) = 1e-6 ohms (Ω).
  static const double ohmsPerMicroohm = 0.000001; // 1e-6

  /// Ohms per Milliohm: 1 milliohm (mΩ) = 0.001 ohms (Ω).
  static const double ohmsPerMilliohm = 0.001;

  /// Ohms per Kiloohm: 1 kiloohm (kΩ) = 1000 ohms (Ω).
  static const double ohmsPerKiloohm = 1000.0;

  /// Ohms per Megaohm: 1 megaohm (MΩ) = 1,000,000 ohms (Ω).
  static const double ohmsPerMegaohm = 1000000.0;

  /// Ohms per Gigaohm: 1 gigaohm (GΩ) = 1,000,000,000 ohms (Ω).
  static const double ohmsPerGigaohm = 1000000000.0;
}
