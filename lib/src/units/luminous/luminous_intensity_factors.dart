// ignore_for_file: prefer_int_literals // All constants are doubles for precision.

/// Defines base conversion factors for various luminous intensity units relative
/// to the Candela (cd), which is the SI base unit for luminous intensity.
///
/// These constants represent: `1 [Unit] = Z [Candelas]`.
/// So, `candelasPerMillicandela` means `1 millicandela = candelasPerMillicandela candelas`.
class LuminousIntensityFactors {
  // --- SI Prefixed Units (relative to Candela) ---

  /// Candelas per Millicandela: 1 millicandela (mcd) = 0.001 candelas (cd).
  static const double candelasPerMillicandela = 0.001;

  /// Candelas per Kilocandela: 1 kilocandela (kcd) = 1000 candelas (cd).
  /// Note: Kilocandela is a valid SI unit but less commonly used in practice
  /// compared to candela or millicandela for typical light sources.
  static const double candelasPerKilocandela = 1000.0;

  // --- Other historical or specialized units (less common) ---
  // Example: Hefnerkerze (HK) or Hefner candle, an old German unit of luminous intensity.
  // 1 HK ≈ 0.903 cd.
  // static const double candelasPerHefnerCandle = 0.903;

  // Example: Carcel, an old French unit.
  // 1 Carcel ≈ 9.74 cd (varies by definition).
  // static const double candelasPerCarcel = 9.74;

  // For a primary SI base unit like Candela, prefixed versions are the most relevant.
  // Other units are typically for historical context or very specialized applications.
  // Focusing on SI prefixed units for the core implementation.
}
