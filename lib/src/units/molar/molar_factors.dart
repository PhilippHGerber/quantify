// ignore_for_file: prefer_int_literals // All constants are doubles for precision in calculations.

/// Defines base conversion factors for various molar amount units relative to the Mole (mol),
/// which is the SI base unit for amount of substance.
///
/// These constants represent: `1 [Unit] = Z [Moles]`.
/// So, `molesPerMillimole` means `1 millimole = molesPerMillimole moles`.
class MolarFactors {
  // --- SI Prefixed Units (relative to Mole) ---

  /// Moles per Millimole: 1 millimole (mmol) = 0.001 moles (mol).
  static const double molesPerMillimole = 0.001;

  /// Moles per Micromole: 1 micromole (µmol) = 0.000001 moles (mol).
  static const double molesPerMicromole = 0.000001;

  /// Moles per Nanomole: 1 nanomole (nmol) = 1e-9 moles (mol).
  static const double molesPerNanomole = 1.0e-9;

  /// Moles per Picomole: 1 picomole (pmol) = 1e-12 moles (mol).
  static const double molesPerPicomole = 1.0e-12;

  /// Moles per Kilomole: 1 kilomole (kmol) = 1000 moles (mol).
  static const double molesPerKilomole = 1000.0;

  // --- Other potential units (less common for direct amount of substance,
  //      but could be relevant in specific contexts or conversions) ---

  // Example: Pound-mole (lb-mol) - an imperial unit occasionally used in chemical engineering.
  // 1 lb-mol is the amount of a substance whose mass in pounds is numerically equal
  // to its molar mass in g/mol.
  // 1 lb-mol ≈ 453.59237 mol (since 1 lb ≈ 453.59237 g)
  // static const double molesPerPoundMole = 453.592370000104; // Derived from lb to g conversion.
  // Using a more direct reference or if precision is critical, this might need verification.
  // For now, focusing on SI prefixed units.
}
