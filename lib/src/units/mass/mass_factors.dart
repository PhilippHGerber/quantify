// ignore_for_file: prefer_int_literals // All constants are doubles for precision in calculations.


/// Defines base conversion factors for various mass units relative to the Kilogram (kg),
/// which is the SI base unit for mass.
class MassFactors {
  // --- SI Units (relative to Kilogram) ---

  /// Kilograms per Hectogram: 1 hectogram = 0.1 kilograms.
  static const double kilogramsPerHectogram = 0.1;

  /// Kilograms per Decagram: 1 decagram = 0.01 kilograms.
  static const double kilogramsPerDecagram = 0.01;

  /// Kilograms per Gram: 1 gram = 0.001 kilograms.
  static const double kilogramsPerGram = 0.001;

  /// Kilograms per Decigram: 1 decigram = 0.0001 kilograms.
  static const double kilogramsPerDecigram = 0.0001;

  /// Kilograms per Centigram: 1 centigram = 0.00001 kilograms.
  static const double kilogramsPerCentigram = 0.00001;

  /// Kilograms per Milligram: 1 milligram = 0.000001 kilograms.
  /// (1 mg = 0.001 g, and 1 g = 0.001 kg)
  static const double kilogramsPerMilligram = kilogramsPerGram * 0.001;

  /// Kilograms per Microgram: 1 microgram = 1e-9 kilograms.
  static const double kilogramsPerMicrogram = 1e-9;

  /// Kilograms per Nanogram: 1 nanogram = 1e-12 kilograms.
  static const double kilogramsPerNanogram = 1e-12;

  /// Kilograms per Megagram: 1 megagram = 1000 kilograms (equivalent to 1 tonne).
  static const double kilogramsPerMegagram = 1000.0;

  /// Kilograms per Gigagram: 1 gigagram = 1e6 kilograms.
  static const double kilogramsPerGigagram = 1e6;

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

  /// Kilograms per Short Ton (US): 1 short ton = 2000 pounds.
  /// 1 short ton = (2000 * 0.45359237) kilograms = 907.18474 kg.
  static const double kilogramsPerShortTon = kilogramsPerPound * 2000.0;

  /// Kilograms per Long Ton (UK): 1 long ton = 2240 pounds.
  /// 1 long ton = (2240 * 0.45359237) kilograms = 1016.0469088 kg.
  static const double kilogramsPerLongTon = kilogramsPerPound * 2240.0;

  // --- Special Units ---

  /// Kilograms per Atomic Mass Unit: 1 u ≈ 1.66053906660e-27 kilograms.
  /// Based on 2018 CODATA recommended value.
  static const double kilogramsPerAtomicMassUnit = 1.66053906660e-27;

  /// Kilograms per Carat: 1 carat = 0.0002 kilograms (exact).
  /// The metric carat is defined as exactly 200 milligrams.
  static const double kilogramsPerCarat = 0.0002;

  // --- Other potential units (can be added if needed) ---
  // Example: Troy ounce (for precious metals)
  // /// Kilograms per Troy Ounce: 1 troy ounce ≈ 0.0311034768 kilograms.
  // static const double kilogramsPerTroyOunce = 0.0311034768;
}
