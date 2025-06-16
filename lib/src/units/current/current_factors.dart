// ignore_for_file: prefer_int_literals // All constants are doubles for precision in calculations.

/// Defines base conversion factors for various electric current units relative
/// to the Ampere (A), which is the SI base unit for electric current.
///
/// These constants represent: `1 [Unit] = Z [Amperes]`.
/// So, `amperesPerMilliampere` means `1 milliampere = amperesPerMilliampere amperes`.
class CurrentFactors {
  // --- SI Prefixed Units (relative to Ampere) ---

  /// Amperes per Milliampere: 1 milliampere (mA) = 0.001 amperes (A).
  static const double amperesPerMilliampere = 0.001;

  /// Amperes per Microampere: 1 microampere (µA) = 0.000001 amperes (A).
  static const double amperesPerMicroampere = 0.000001; // 1e-6

  /// Amperes per Nanoampere: 1 nanoampere (nA) = 1e-9 amperes (A).
  static const double amperesPerNanoampere = 1.0e-9;

  /// Amperes per Kiloampere: 1 kiloampere (kA) = 1000 amperes (A).
  static const double amperesPerKiloampere = 1000.0;

  // --- Other potential units (less common for general use, but exist) ---
  // Example: Biot (Bi) or abampere, an electromagnetic CGS unit of current.
  // 1 Biot (abampere) = 10 Amperes.
  // static const double amperesPerBiot = 10.0;

  // Example: Statampere, an electrostatic CGS unit of current.
  // 1 Statampere ≈ 3.33564 × 10⁻¹⁰ Amperes.
  // static const double amperesPerStatampere = 3.3356409519815204e-10;
  // For now, focusing on SI prefixed units.
}
