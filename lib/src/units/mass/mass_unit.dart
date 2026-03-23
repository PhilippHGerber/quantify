import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'mass_factors.dart';

/// Represents units of mass.
///
/// This enum implements the [LinearUnit] interface to provide conversion capabilities
/// and a display [symbol] for each mass unit.
/// All conversion factors are pre-calculated in the constructor relative to Kilogram (kg),
/// which is the SI base unit for mass.
enum MassUnit implements LinearUnit<MassUnit> {
  /// Kilogram (kg), the SI base unit of mass.
  kilogram(1, 'kg'),

  /// Hectogram (hg), equal to 0.1 kilograms.
  hectogram(MassFactors.kilogramsPerHectogram, 'hg'),

  /// Decagram (dag), equal to 0.01 kilograms.
  decagram(MassFactors.kilogramsPerDecagram, 'dag'),

  /// Gram (g), equal to 0.001 kilograms.
  gram(MassFactors.kilogramsPerGram, 'g'),

  /// Decigram (dg), equal to 0.0001 kilograms.
  decigram(MassFactors.kilogramsPerDecigram, 'dg'),

  /// Centigram (cg), equal to 0.00001 kilograms.
  centigram(MassFactors.kilogramsPerCentigram, 'cg'),

  /// Milligram (mg), equal to 0.000001 kilograms (or 0.001 grams).
  milligram(MassFactors.kilogramsPerMilligram, 'mg'),

  /// Microgram (μg), equal to 1e-9 kilograms.
  microgram(MassFactors.kilogramsPerMicrogram, 'μg'),

  /// Nanogram (ng), equal to 1e-12 kilograms.
  nanogram(MassFactors.kilogramsPerNanogram, 'ng'),

  /// Megagram (Mg), equal to 1000 kilograms. It is equivalent to a metric ton (tonne).
  megagram(MassFactors.kilogramsPerMegagram, 'Mg'),

  /// Gigagram (Gg), equal to 1e6 kilograms.
  gigagram(MassFactors.kilogramsPerGigagram, 'Gg'),

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
  slug(MassFactors.kilogramsPerSlug, 'slug'),

  /// Short Ton (US), equal to 2000 pounds or approximately 907.18474 kilograms.
  shortTon(MassFactors.kilogramsPerShortTon, 'short ton'),

  /// Long Ton (UK), equal to 2240 pounds or approximately 1016.0469088 kilograms.
  longTon(MassFactors.kilogramsPerLongTon, 'long ton'),

  /// Atomic Mass Unit (u), approximately 1.66053906660e-27 kilograms.
  /// Used for expressing atomic and molecular masses.
  atomicMassUnit(MassFactors.kilogramsPerAtomicMassUnit, 'u'),

  /// Carat (ct), equal to exactly 0.0002 kilograms (200 milligrams).
  /// Used for measuring the mass of gemstones and pearls.
  carat(MassFactors.kilogramsPerCarat, 'ct');

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
        _factorToKilogram = toKilogramFactor / 1.0, // Base unit factor for kilogram is 1.0
        _factorToHectogram = toKilogramFactor / MassFactors.kilogramsPerHectogram,
        _factorToDecagram = toKilogramFactor / MassFactors.kilogramsPerDecagram,
        _factorToGram = toKilogramFactor / MassFactors.kilogramsPerGram,
        _factorToDecigram = toKilogramFactor / MassFactors.kilogramsPerDecigram,
        _factorToCentigram = toKilogramFactor / MassFactors.kilogramsPerCentigram,
        _factorToMilligram = toKilogramFactor / MassFactors.kilogramsPerMilligram,
        _factorToMicrogram = toKilogramFactor / MassFactors.kilogramsPerMicrogram,
        _factorToNanogram = toKilogramFactor / MassFactors.kilogramsPerNanogram,
        _factorToMegagram = toKilogramFactor / MassFactors.kilogramsPerMegagram,
        _factorToGigagram = toKilogramFactor / MassFactors.kilogramsPerGigagram,
        _factorToTonne = toKilogramFactor / MassFactors.kilogramsPerTonne,
        _factorToPound = toKilogramFactor / MassFactors.kilogramsPerPound,
        _factorToOunce = toKilogramFactor / MassFactors.kilogramsPerOunce,
        _factorToStone = toKilogramFactor / MassFactors.kilogramsPerStone,
        _factorToSlug = toKilogramFactor / MassFactors.kilogramsPerSlug,
        _factorToShortTon = toKilogramFactor / MassFactors.kilogramsPerShortTon,
        _factorToLongTon = toKilogramFactor / MassFactors.kilogramsPerLongTon,
        _factorToAtomicMassUnit = toKilogramFactor / MassFactors.kilogramsPerAtomicMassUnit,
        _factorToCarat = toKilogramFactor / MassFactors.kilogramsPerCarat;

  /// The factor to convert a value from this unit to the base unit (Kilogram).
  /// Example: For Gram, this is 0.001 (meaning 1 g = 0.001 kg).
  // ignore: unused_field
  final double _toKilogramFactor;

  /// The human-readable symbol for this mass unit (e.g., "kg", "g", "lb").
  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors from this unit to all others ---
  final double _factorToKilogram;
  final double _factorToHectogram;
  final double _factorToDecagram;
  final double _factorToGram;
  final double _factorToDecigram;
  final double _factorToCentigram;
  final double _factorToMilligram;
  final double _factorToMicrogram;
  final double _factorToNanogram;
  final double _factorToMegagram;
  final double _factorToGigagram;
  final double _factorToTonne;
  final double _factorToPound;
  final double _factorToOunce;
  final double _factorToStone;
  final double _factorToSlug;
  final double _factorToShortTon;
  final double _factorToLongTon;
  final double _factorToAtomicMassUnit;
  final double _factorToCarat;

  /// SI and unit symbols matched **strictly case-sensitive**.
  ///
  /// Keys must be the exact symbol string (e.g. `'Mg'` for megagram, `'mg'`
  /// for milligram). No case folding is applied during lookup.
  ///
  /// Used by `Mass.parser`.
  @internal
  static const Map<String, MassUnit> symbolAliases = {
    // kilogram
    'kg': MassUnit.kilogram,
    // hectogram
    'hg': MassUnit.hectogram,
    // decagram
    'dag': MassUnit.decagram,
    // gram
    'g': MassUnit.gram,
    // decigram
    'dg': MassUnit.decigram,
    // centigram
    'cg': MassUnit.centigram,
    // milligram — lowercase m distinguishes milli from mega
    'mg': MassUnit.milligram,
    // microgram
    'μg': MassUnit.microgram,
    'ug': MassUnit.microgram, // ASCII fallback for μg
    // nanogram
    'ng': MassUnit.nanogram,
    // megagram — capital M distinguishes mega from milli
    'Mg': MassUnit.megagram,
    // gigagram
    'Gg': MassUnit.gigagram,
    // tonne
    't': MassUnit.tonne,
    // pound
    'lb': MassUnit.pound,
    'lbs': MassUnit.pound,
    // ounce
    'oz': MassUnit.ounce,
    // stone
    'st': MassUnit.stone,
    // slug (symbol equals the word; also in nameAliases for case-insensitive match)
    'slug': MassUnit.slug,
    // atomic mass unit
    'u': MassUnit.atomicMassUnit,
    // carat
    'ct': MassUnit.carat,
  };

  /// Full word-form names and non-colliding abbreviations matched
  /// **case-insensitively** (after `.toLowerCase()` and whitespace normalization).
  ///
  /// Used by `Mass.parser`.
  @internal
  static const Map<String, MassUnit> nameAliases = {
    // kilogram
    'kilogram': MassUnit.kilogram,
    'kilograms': MassUnit.kilogram,
    'kilogramme': MassUnit.kilogram,
    'kilogrammes': MassUnit.kilogram,
    'kilo': MassUnit.kilogram,
    'kilos': MassUnit.kilogram,
    // hectogram
    'hectogram': MassUnit.hectogram,
    'hectograms': MassUnit.hectogram,
    // decagram
    'decagram': MassUnit.decagram,
    'decagrams': MassUnit.decagram,
    // gram
    'gram': MassUnit.gram,
    'grams': MassUnit.gram,
    'gramme': MassUnit.gram,
    'grammes': MassUnit.gram,
    // decigram
    'decigram': MassUnit.decigram,
    'decigrams': MassUnit.decigram,
    // centigram
    'centigram': MassUnit.centigram,
    'centigrams': MassUnit.centigram,
    // milligram
    'milligram': MassUnit.milligram,
    'milligrams': MassUnit.milligram,
    // microgram
    'microgram': MassUnit.microgram,
    'micrograms': MassUnit.microgram,
    'mcg': MassUnit.microgram, // common medical notation
    // nanogram
    'nanogram': MassUnit.nanogram,
    'nanograms': MassUnit.nanogram,
    // megagram
    'megagram': MassUnit.megagram,
    'megagrams': MassUnit.megagram,
    // gigagram
    'gigagram': MassUnit.gigagram,
    'gigagrams': MassUnit.gigagram,

    // --- Non-SI / Imperial / Customary Units (Mirrored from symbols for case-insensitivity) ---

    // tonne
    'tonne': MassUnit.tonne,
    'tonnes': MassUnit.tonne,
    'metric ton': MassUnit.tonne,
    'metric tons': MassUnit.tonne,
    'ton': MassUnit.tonne,
    'tons': MassUnit.tonne,
    // pound
    'pound': MassUnit.pound,
    'pounds': MassUnit.pound,
    'lb': MassUnit.pound,
    'lbs': MassUnit.pound,
    // ounce
    'ounce': MassUnit.ounce,
    'ounces': MassUnit.ounce,
    'oz': MassUnit.ounce,
    // stone
    'stone': MassUnit.stone,
    'stones': MassUnit.stone,
    'st': MassUnit.stone,
    // slug
    'slug': MassUnit.slug,
    'slugs': MassUnit.slug,
    // short ton (multi-word — whitespace normalization handles extra spaces)
    'short ton': MassUnit.shortTon,
    'short tons': MassUnit.shortTon,
    // long ton
    'long ton': MassUnit.longTon,
    'long tons': MassUnit.longTon,
    // atomic mass unit
    'amu': MassUnit.atomicMassUnit,
    'atomic mass unit': MassUnit.atomicMassUnit,
    'atomic mass units': MassUnit.atomicMassUnit,
    'u': MassUnit.atomicMassUnit,
    // carat
    'carat': MassUnit.carat,
    'carats': MassUnit.carat,
    'ct': MassUnit.carat,
  };

  /// Returns the direct conversion factor to convert a value from this [MassUnit]
  /// to the [targetUnit].
  @override
  @internal
  double factorTo(MassUnit targetUnit) {
    switch (targetUnit) {
      case MassUnit.kilogram:
        return _factorToKilogram;
      case MassUnit.hectogram:
        return _factorToHectogram;
      case MassUnit.decagram:
        return _factorToDecagram;
      case MassUnit.gram:
        return _factorToGram;
      case MassUnit.decigram:
        return _factorToDecigram;
      case MassUnit.centigram:
        return _factorToCentigram;
      case MassUnit.milligram:
        return _factorToMilligram;
      case MassUnit.microgram:
        return _factorToMicrogram;
      case MassUnit.nanogram:
        return _factorToNanogram;
      case MassUnit.megagram:
        return _factorToMegagram;
      case MassUnit.gigagram:
        return _factorToGigagram;
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
      case MassUnit.shortTon:
        return _factorToShortTon;
      case MassUnit.longTon:
        return _factorToLongTon;
      case MassUnit.atomicMassUnit:
        return _factorToAtomicMassUnit;
      case MassUnit.carat:
        return _factorToCarat;
    }
  }
}
