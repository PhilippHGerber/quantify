// ignore_for_file: prefer_int_literals // All constants are doubles for precision.

/// Defines base conversion factors for various volume units relative to the
/// Cubic Millimeter (mm³), which is the chosen internal base unit for precision.
///
/// These constants represent: `1 [Unit] = Z [Cubic Millimeters]`.
/// By using the smallest SI unit as a base, all other SI units can be
/// represented as precise integers, avoiding floating-point division errors.
class VolumeFactors {
  // --- SI Cubic Units (relative to Cubic Millimeter) ---
  /// The base unit for precise internal calculations.
  static const double mm3 = 1.0;

  /// Cubic Millimeters per Cubic Centimeter (mL): 1 cm³ = 1000 mm³.
  static const double cm3 = mm3 * 1000.0;

  /// Cubic Millimeters per Cubic Decimeter (L): 1 dm³ = 1,000,000 mm³.
  static const double dm3 = cm3 * 1000.0;

  /// Cubic Millimeters per Centiliter (cl): 1 cl = 10 mL = 10,000 mm³.
  static const double cl = cm3 * 10.0;

  /// Cubic Millimeters per Cubic Meter (kl): 1 m³ = 1,000,000,000 mm³.
  static const double m3 = dm3 * 1000.0;

  /// Cubic Millimeters per Cubic Decameter (Ml).
  static const double dam3 = m3 * 1000.0;

  /// Cubic Millimeters per Cubic Hectometer (Gl).
  static const double hm3 = dam3 * 1000.0;

  /// Cubic Millimeters per Cubic Kilometer (Tl).
  static const double km3 = hm3 * 1000.0;

  // --- Imperial / US Customary Units (relative to Cubic Millimeter) ---
  // A single definition from a precise constant (25.4 mm in an inch).
  /// Cubic Millimeters per Cubic Inch: 1 in³ = (25.4)³ mm³.
  static const double in3 = 16387.064; // 25.4 * 25.4 * 25.4 is exact

  /// Cubic Millimeters per Cubic Foot: 1 ft³ = 1728 in³.
  static const double ft3 = in3 * 1728.0;

  /// Cubic Millimeters per Cubic Mile: 1 mi³ = (5280)³ ft³.
  static const double mi3 = ft3 * 147197952000.0;

  // --- US Customary Liquid Units (relative to Cubic Millimeter) ---
  /// Cubic Millimeters per US Liquid Gallon: 1 gal = 231 in³.
  static const double gal = in3 * 231.0;

  /// Cubic Millimeters per US Liquid Quart: 1 qt = 1/4 gal.
  static const double qt = gal / 4.0;

  /// Cubic Millimeters per US Liquid Pint: 1 pt = 1/2 qt.
  static const double pt = qt / 2.0;

  /// Cubic Millimeters per US Fluid Ounce: 1 fl-oz = 1/16 pt.
  static const double flOz = pt / 16.0;

  // --- US Customary Cooking Units (relative to Cubic Millimeter) ---
  /// Cubic Millimeters per US Tablespoon: 1 tbsp = 1/2 US fl-oz.
  static const double tbsp = flOz / 2.0;

  /// Cubic Millimeters per US Teaspoon: 1 tsp = 1/3 tbsp.
  static const double tsp = tbsp / 3.0;
}
