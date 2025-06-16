import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'mass_factors.dart';

/// Represents units of mass.
///
/// This enum implements the [Unit] interface to provide conversion capabilities
/// and a display [symbol] for each mass unit.
/// All conversion factors are pre-calculated in the constructor relative to Kilogram (kg),
/// which is the SI base unit for mass.
enum MassUnit implements Unit<MassUnit> {
  /// Kilogram (kg), the SI base unit of mass.
  kilogram(1, 'kg'),

  /// Gram (g), equal to 0.001 kilograms.
  gram(MassFactors.kilogramsPerGram, 'g'),

  /// Milligram (mg), equal to 0.000001 kilograms (or 0.001 grams).
  milligram(MassFactors.kilogramsPerMilligram, 'mg'),

  /// Tonne (metric ton) (t), equal to 1000 kilograms.
  tonne(MassFactors.kilogramsPerTonne, 't'),

  /// Pound (lb), an avoirdupois pound, defined as exactly 0.45359237 kilograms.
  pound(MassFactors.kilogramsPerPound, 'lb'),

  /// Ounce (oz), an avoirdupois ounce, defined as 1/16 of an avoirdupois pound.
  ounce(MassFactors.kilogramsPerOunce, 'oz'),

  /// Stone (st), a unit of weight in the imperial system, equal to 14 pounds.
  stone(MassFactors.kilogramsPerStone, 'st'),

  /// Slug, a unit of mass in the British Imperial and US customary systems,
  /// defined as the mass that accelerates by 1 ft/s² when a force of one pound-force (lbf) is exerted on it.
  /// 1 slug ≈ 14.59390 kilograms.
  slug(MassFactors.kilogramsPerSlug, 'slug');

  /// Constant constructor for enum members.
  ///
  /// [_toKilogramFactor] is the factor to convert from this unit to the base unit (Kilogram).
  /// For Kilogram itself, this is 1.0.
  /// [symbol] is the display symbol for the unit.
  ///
  /// The constructor pre-calculates all direct conversion factors
  /// from this unit to every other `MassUnit`.
  /// The formula `factor_A_to_B = _toBaseFactor_A / _toBaseFactor_B` is used,
  /// where the base unit is Kilogram.
  const MassUnit(double toKilogramFactor, this.symbol)
      : _toKilogramFactor = toKilogramFactor,
        // Initialize direct factors from THIS unit to OTHERS.
        // factor_A_to_B = factor_A_to_Base / factor_B_to_Base
        // Here, Base is Kilogram. So, factor_A_to_Kilogram = _toKilogramFactor_A / 1.0
        _factorToKilogram = toKilogramFactor / 1.0, // Base unit factor for kilogram is 1.0
        _factorToGram = toKilogramFactor / MassFactors.kilogramsPerGram,
        _factorToMilligram = toKilogramFactor / MassFactors.kilogramsPerMilligram,
        _factorToTonne = toKilogramFactor / MassFactors.kilogramsPerTonne,
        _factorToPound = toKilogramFactor / MassFactors.kilogramsPerPound,
        _factorToOunce = toKilogramFactor / MassFactors.kilogramsPerOunce,
        _factorToStone = toKilogramFactor / MassFactors.kilogramsPerStone,
        _factorToSlug = toKilogramFactor / MassFactors.kilogramsPerSlug;

  /// The factor to convert a value from this unit to the base unit (Kilogram).
  /// Example: For Gram, this is 0.001 (meaning 1 g = 0.001 kg).
  /// After constructor initialization, its value is primarily baked into
  /// the specific _factorToXxx fields for direct inter-unit conversions.
  /// It's generally not accessed directly by methods outside this enum's constructor
  /// but is crucial for deriving the pre-calculated factors.
  // ignore: unused_field
  final double _toKilogramFactor;

  /// The human-readable symbol for this mass unit (e.g., "kg", "g", "lb").
  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors from this unit to all others ---
  // These are calculated once in the const constructor for performance.

  final double _factorToKilogram;
  final double _factorToGram;
  final double _factorToMilligram;
  final double _factorToTonne;
  final double _factorToPound;
  final double _factorToOunce;
  final double _factorToStone;
  final double _factorToSlug;

  /// Returns the direct conversion factor to convert a value from this [MassUnit]
  /// to the [targetUnit].
  ///
  /// This method is marked as `@internal` and is primarily used by the `Mass`
  /// class for conversions.
  ///
  /// Example: `MassUnit.gram.factorTo(MassUnit.kilogram)` would return `0.001`.
  /// `MassUnit.kilogram.factorTo(MassUnit.gram)` would return `1000.0`.
  ///
  /// - [targetUnit]: The `MassUnit` to which a value should be converted.
  ///
  /// Returns the multiplication factor.
  @override
  @internal
  double factorTo(MassUnit targetUnit) {
    switch (targetUnit) {
      case MassUnit.kilogram:
        return _factorToKilogram;
      case MassUnit.gram:
        return _factorToGram;
      case MassUnit.milligram:
        return _factorToMilligram;
      case MassUnit.tonne:
        return _factorToTonne;
      case MassUnit.pound:
        return _factorToPound;
      case MassUnit.ounce:
        return _factorToOunce;
      case MassUnit.stone:
        return _factorToStone;
      case MassUnit.slug:
        return _factorToSlug;
    }
  }
}
