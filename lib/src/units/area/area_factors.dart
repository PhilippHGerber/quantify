// ignore_for_file: prefer_int_literals // All constants are doubles for precision.

/// Defines base conversion factors for various area units relative to the
/// Square Meter (m²), which is the SI derived unit for area.
///
/// These constants represent: `1 [Unit] = Z [Square Meters]`.
class AreaFactors {
  /// Square Meters per Square Meter: 1 m² = 1.0 m².
  static const double m2 = 1.0;

  /// Square Meters per Square Decimetre: 1 dm² = 0.01 m².
  static const double dm2 = 0.01;

  /// Square Meters per Square Centimetre: 1 cm² = 0.0001 m².
  static const double cm2 = 0.0001;

  /// Square Meters per Square Millimetre: 1 mm² = 0.000001 m².
  static const double mm2 = 0.000001;

  /// Square Meters per Square Micrometre: 1 µm² = 1e-12 m².
  static const double um2 = 0.000000000001;

  /// Square Meters per Square Decametre: 1 dam² = 100.0 m².
  static const double dam2 = 100.0;

  /// Square Meters per Square Hectometre: 1 hm² = 10000.0 m².
  static const double hm2 = 10000.0;

  /// Square Meters per Square Kilometre: 1 km² = 1000000.0 m².
  static const double km2 = 1000000.0;

  /// Square Meters per Square Megameter: 1 Mm² = 1e12 m².
  static const double squareMegameter = 1000000000000.0;

  /// Square Meters per Square Inch: 1 in² = 0.00064516 m².
  static const double in2 = 0.00064516;

  /// Square Meters per Square Foot: 1 ft² = 0.09290304 m².
  static const double ft2 = 0.09290304;

  /// Square Meters per Square Yard: 1 yd² = 0.83612736 m² (from 0.9144²).
  static const double yd2 = 0.83612736;

  /// Square Meters per Square Mile: 1 mi² = 2589988.110336 m².
  static const double mi2 = 2589988.110336;

  /// Square Meters per Acre: 1 ac = 4046.8564224 m².
  static const double ac = 4046.8564224;
}
