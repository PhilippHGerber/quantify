// ignore_for_file: prefer_int_literals // All constants are doubles for precision in calculations.

import '../../../quantify.dart' show Unit;
import '../../core/unit.dart' show Unit;

/// Defines base conversion factors for various mass units relative to the Kilogram (kg),
/// which is the SI base unit for mass.
///
/// These constants are based on international standards and exact definitions where available
/// (e.g., the international avoirdupois pound).
///
/// The structure `X_per_Y` means "how many X are in one Y".
/// However, for consistency with how factors are used (1 [Unit] = X BaseUnit),
/// these constants represent: `1 [Unit] = Z [Kilograms]`.
/// So, `kilogramsPerGram` means `1 gram = kilogramsPerGram kilograms`.
class MassFactors {
  // --- SI Units (relative to Kilogram) ---

  /// Kilograms per Gram: 1 gram = 0.001 kilograms.
  static const double kilogramsPerGram = 0.001;

  /// Kilograms per Milligram: 1 milligram = 0.000001 kilograms.
  /// (1 mg = 0.001 g, and 1 g = 0.001 kg)
  static const double kilogramsPerMilligram = kilogramsPerGram * 0.001;

  /// Kilograms per Tonne (Metric Ton): 1 tonne = 1000 kilograms.
  static const double kilogramsPerTonne = 1000.0;

  // --- Imperial / US Customary Units (relative to Kilogram) ---

  /// Kilograms per Pound (Avoirdupois): 1 pound = 0.45359237 kilograms.
  /// This is an exact definition based on the international pound and yard agreement of 1959.
  static const double kilogramsPerPound = 0.45359237;

  /// Kilograms per Ounce (Avoirdupois): 1 ounce = 1/16 pound.
  /// 1 ounce = (0.45359237 / 16) kilograms.
  static const double kilogramsPerOunce = kilogramsPerPound / 16.0;

  /// Kilograms per Stone: 1 stone = 14 pounds.
  /// 1 stone = (14 * 0.45359237) kilograms.
  static const double kilogramsPerStone = kilogramsPerPound * 14.0;

  /// Kilograms per Slug: 1 slug ≈ 14.5939029372 kilograms.
  /// The slug is a unit of mass in the gravitational systems of units,
  /// defined as the mass that accelerates by 1 ft/s² when a force of one pound-force (lbf)
  /// is exerted on it.
  /// 1 slug = 1 lbf⋅s²/ft.
  /// Using g₀ = 9.80665 m/s² (standard gravity) and 1 ft = 0.3048 m:
  /// 1 lbf = 0.45359237 kg * 9.80665 m/s² (force)
  /// 1 slug = (0.45359237 * 9.80665) / 0.3048 kg (approx, if derived from lbf definition relative to kg-mass and g0)
  /// A more commonly cited direct conversion factor for slug to kg is used here.
  /// For example, NIST Special Publication 811 (2008 edition), Appendix B.8, lists:
  /// slug -> 1.459 390 E+01 kg
  static const double kilogramsPerSlug = 14.5939029372;

  // --- Other common units (can be added if needed) ---
  // Example: Carat (for gemstones)
  // /// Kilograms per Carat (metric): 1 carat = 0.0002 kilograms (0.2 grams).
  // static const double kilogramsPerCarat = 0.0002;
}
