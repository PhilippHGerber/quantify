// ignore_for_file: prefer_int_literals // All constants are doubles for precision.

/// Defines base conversion factors for various electric charge units relative to the
/// Coulomb (C), which is the SI derived unit for electric charge (A·s).
///
/// These constants represent: `1 [Unit] = Z [Coulombs]`.
class ElectricChargeFactors {
  // --- SI Prefixed Units (relative to Coulomb) ---

  /// Coulombs per Millicoulomb: 1 mC = 1e-3 C.
  static const double coulombsPerMillicoulomb = 1e-3;

  /// Coulombs per Microcoulomb: 1 µC = 1e-6 C.
  static const double coulombsPerMicrocoulomb = 1e-6;

  /// Coulombs per Nanocoulomb: 1 nC = 1e-9 C.
  static const double coulombsPerNanocoulomb = 1e-9;

  // --- Other Common Units ---

  /// Coulombs per Elementary Charge (e): The charge of a single proton.
  /// This is an exact value by the 2019 redefinition of the SI base units.
  static const double coulombsPerElementaryCharge = 1.602176634e-19;

  /// Coulombs per Ampere-Hour (Ah): Commonly used for battery capacity.
  /// 1 Ah = 1 A * 3600 s = 3600 C.
  static const double coulombsPerAmpereHour = 3600.0;
}
