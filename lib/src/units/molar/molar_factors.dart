// ignore_for_file: prefer_int_literals // All constants are doubles for precision in calculations.

/// Defines base conversion factors for various molar amount units relative to the Mole (mol),
/// which is the SI base unit for amount of substance.
///
/// These constants represent: `1 [Unit] = Z [Moles]`.
/// So, `molesPerMillimole` means `1 millimole = molesPerMillimole moles`.
class MolarFactors {
  // --- SI Prefixed Units (relative to Mole) ---

  /// Moles per Megamole: 1 megamole (Mmol) = 1e6 moles (mol).
  static const double molesPerMegamole = 1e6;

  /// Moles per Kilomole: 1 kilomole (kmol) = 1000 moles (mol).
  static const double molesPerKilomole = 1000.0;

  /// Moles per Millimole: 1 millimole (mmol) = 0.001 moles (mol).
  static const double molesPerMillimole = 0.001;

  /// Moles per Micromole: 1 micromole (µmol) = 1e-6 moles (mol).
  static const double molesPerMicromole = 1e-6;

  /// Moles per Nanomole: 1 nanomole (nmol) = 1e-9 moles (mol).
  static const double molesPerNanomole = 1e-9;

  /// Moles per Picomole: 1 picomole (pmol) = 1e-12 moles (mol).
  static const double molesPerPicomole = 1e-12;

  /// Moles per Femtomole: 1 femtomole (fmol) = 1e-15 moles (mol).
  static const double molesPerFemtomole = 1e-15;

  // --- Imperial / chemical-engineering units ---

  /// Moles per Pound-mole: 1 lb-mol = 453.59237 mol.
  ///
  /// A pound-mole is the amount of substance whose mass in pounds equals its
  /// molar mass in g/mol.  Derived directly from the exact pound-to-gram
  /// conversion: 1 lb = 453.59237 g (exact, by definition since 1959).
  static const double molesPerPoundMole = 453.59237;
}
