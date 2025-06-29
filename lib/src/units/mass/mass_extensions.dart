import 'mass.dart';
import 'mass_unit.dart';

/// Provides convenient access to [Mass] values in specific units
/// using getter properties.
///
/// These getters simplify retrieving the numerical value of a mass
/// in a desired unit without explicitly calling `getValue()`.
extension MassValueGetters on Mass {
  /// Returns the mass value in Kilograms (kg).
  double get inKilograms => getValue(MassUnit.kilogram);

  /// Returns the mass value in Hectograms (hg).
  double get inHectograms => getValue(MassUnit.hectogram);

  /// Returns the mass value in Decagrams (dag).
  double get inDecagrams => getValue(MassUnit.decagram);

  /// Returns the mass value in Grams (g).
  double get inGrams => getValue(MassUnit.gram);

  /// Returns the mass value in Decigrams (dg).
  double get inDecigrams => getValue(MassUnit.decigram);

  /// Returns the mass value in Centigrams (cg).
  double get inCentigrams => getValue(MassUnit.centigram);

  /// Returns the mass value in Milligrams (mg).
  double get inMilligrams => getValue(MassUnit.milligram);

  /// Returns the mass value in Micrograms (μg).
  double get inMicrograms => getValue(MassUnit.microgram);

  /// Returns the mass value in Nanograms (ng).
  double get inNanograms => getValue(MassUnit.nanogram);

  /// Returns the mass value in Megagrams (Mg).
  double get inMegaG => getValue(MassUnit.megagram);

  /// Returns the mass value in Gigagrams (Gg).
  double get inGigaG => getValue(MassUnit.gigagram);

  /// Returns the mass value in Tonnes (t, metric tons).
  double get inTonnes => getValue(MassUnit.tonne);

  /// Returns the mass value in Pounds (lb).
  double get inPounds => getValue(MassUnit.pound);

  /// Returns the mass value in Ounces (oz).
  double get inOunces => getValue(MassUnit.ounce);

  /// Returns the mass value in Stones (st).
  double get inStones => getValue(MassUnit.stone);

  /// Returns the mass value in Slugs (slug).
  double get inSlugs => getValue(MassUnit.slug);

  /// Returns the mass value in Short Tons (US).
  double get inShortTons => getValue(MassUnit.shortTon);

  /// Returns the mass value in Long Tons (UK).
  double get inLongTons => getValue(MassUnit.longTon);

  /// Returns the mass value in Atomic Mass Units (u).
  double get inAtomicMassUnits => getValue(MassUnit.atomicMassUnit);

  /// Returns the mass value in Carats (ct).
  double get inCarats => getValue(MassUnit.carat);

  // --- "As" Getters for new Mass objects ---

  /// Returns a new [Mass] object representing this mass in Kilograms (kg).
  Mass get asKilograms => convertTo(MassUnit.kilogram);

  /// Returns a new [Mass] object representing this mass in Hectograms (hg).
  Mass get asHectograms => convertTo(MassUnit.hectogram);

  /// Returns a new [Mass] object representing this mass in Decagrams (dag).
  Mass get asDecagrams => convertTo(MassUnit.decagram);

  /// Returns a new [Mass] object representing this mass in Grams (g).
  Mass get asGrams => convertTo(MassUnit.gram);

  /// Returns a new [Mass] object representing this mass in Decigrams (dg).
  Mass get asDecigrams => convertTo(MassUnit.decigram);

  /// Returns a new [Mass] object representing this mass in Centigrams (cg).
  Mass get asCentigrams => convertTo(MassUnit.centigram);

  /// Returns a new [Mass] object representing this mass in Milligrams (mg).
  Mass get asMilligrams => convertTo(MassUnit.milligram);

  /// Returns a new [Mass] object representing this mass in Micrograms (μg).
  Mass get asMicrograms => convertTo(MassUnit.microgram);

  /// Returns a new [Mass] object representing this mass in Nanograms (ng).
  Mass get asNanograms => convertTo(MassUnit.nanogram);

  /// Returns a new [Mass] object representing this mass in Megagrams (Mg).
  Mass get asMegaG => convertTo(MassUnit.megagram);

  /// Returns a new [Mass] object representing this mass in Gigagrams (Gg).
  Mass get asGigaG => convertTo(MassUnit.gigagram);

  /// Returns a new [Mass] object representing this mass in Tonnes (t).
  Mass get asTonnes => convertTo(MassUnit.tonne);

  /// Returns a new [Mass] object representing this mass in Pounds (lb).
  Mass get asPounds => convertTo(MassUnit.pound);

  /// Returns a new [Mass] object representing this mass in Ounces (oz).
  Mass get asOunces => convertTo(MassUnit.ounce);

  /// Returns a new [Mass] object representing this mass in Stones (st).
  Mass get asStones => convertTo(MassUnit.stone);

  /// Returns a new [Mass] object representing this mass in Slugs (slug).
  Mass get asSlugs => convertTo(MassUnit.slug);

  /// Returns a new [Mass] object representing this mass in Short Tons (US).
  Mass get asShortTons => convertTo(MassUnit.shortTon);

  /// Returns a new [Mass] object representing this mass in Long Tons (UK).
  Mass get asLongTons => convertTo(MassUnit.longTon);

  /// Returns a new [Mass] object representing this mass in Atomic Mass Units (u).
  Mass get asAtomicMassUnits => convertTo(MassUnit.atomicMassUnit);

  /// Returns a new [Mass] object representing this mass in Carats (ct).
  Mass get asCarats => convertTo(MassUnit.carat);
}

/// Provides convenient factory methods for creating [Mass] instances from [num]
/// using getter properties named after common unit symbols or names.
///
/// This allows for an intuitive and concise way to create mass quantities,
/// for example: `70.kg` or `500.grams`.
extension MassCreation on num {
  /// Creates a [Mass] instance representing this numerical value in Kilograms (kg).
  Mass get kg => Mass(toDouble(), MassUnit.kilogram);

  /// Creates a [Mass] instance representing this numerical value in Hectograms (hg).
  Mass get hg => Mass(toDouble(), MassUnit.hectogram);

  /// Creates a [Mass] instance representing this numerical value in Decagrams (dag).
  Mass get dag => Mass(toDouble(), MassUnit.decagram);

  /// Creates a [Mass] instance representing this numerical value in Grams (g).
  Mass get g => Mass(toDouble(), MassUnit.gram);

  /// Creates a [Mass] instance representing this numerical value in Grams (g).
  /// Alias for `g`.
  Mass get grams => Mass(toDouble(), MassUnit.gram);

  /// Creates a [Mass] instance representing this numerical value in Decigrams (dg).
  Mass get dg => Mass(toDouble(), MassUnit.decigram);

  /// Creates a [Mass] instance representing this numerical value in Centigrams (cg).
  Mass get cg => Mass(toDouble(), MassUnit.centigram);

  /// Creates a [Mass] instance representing this numerical value in Milligrams (mg).
  Mass get mg => Mass(toDouble(), MassUnit.milligram);

  /// Creates a [Mass] instance representing this numerical value in Milligrams (mg).
  /// Alias for `mg`.
  Mass get milligrams => Mass(toDouble(), MassUnit.milligram);

  /// Creates a [Mass] instance representing this numerical value in Micrograms (μg).
  Mass get ug => Mass(toDouble(), MassUnit.microgram);

  /// Creates a [Mass] instance representing this numerical value in Micrograms (μg).
  /// Alias for `ug`.
  Mass get micrograms => Mass(toDouble(), MassUnit.microgram);

  /// Creates a [Mass] instance representing this numerical value in Nanograms (ng).
  Mass get ng => Mass(toDouble(), MassUnit.nanogram);

  /// Creates a [Mass] instance representing this numerical value in Nanograms (ng).
  /// Alias for `ng`.
  Mass get nanograms => Mass(toDouble(), MassUnit.nanogram);

  /// Creates a [Mass] instance representing this numerical value in Megagrams (Mg).
  Mass get megaG => Mass(toDouble(), MassUnit.megagram);

  /// Creates a [Mass] instance representing this numerical value in Gigagrams (Gg).
  Mass get gigaG => Mass(toDouble(), MassUnit.gigagram);

  /// Creates a [Mass] instance representing this numerical value in Tonnes (t, metric tons).
  Mass get t => Mass(toDouble(), MassUnit.tonne);

  /// Creates a [Mass] instance representing this numerical value in Tonnes (t, metric tons).
  /// Alias for `t`.
  Mass get tonnes => Mass(toDouble(), MassUnit.tonne);

  /// Creates a [Mass] instance representing this numerical value in Pounds (lb).
  Mass get lb => Mass(toDouble(), MassUnit.pound);

  /// Creates a [Mass] instance representing this numerical value in Pounds (lb).
  /// Alias for `lb`.
  Mass get pounds => Mass(toDouble(), MassUnit.pound);

  /// Creates a [Mass] instance representing this numerical value in Ounces (oz).
  Mass get oz => Mass(toDouble(), MassUnit.ounce);

  /// Creates a [Mass] instance representing this numerical value in Ounces (oz).
  /// Alias for `oz`.
  Mass get ounces => Mass(toDouble(), MassUnit.ounce);

  /// Creates a [Mass] instance representing this numerical value in Stones (st).
  Mass get st => Mass(toDouble(), MassUnit.stone);

  /// Creates a [Mass] instance representing this numerical value in Stones (st).
  /// Alias for `st`.
  Mass get stones => Mass(toDouble(), MassUnit.stone);

  /// Creates a [Mass] instance representing this numerical value in Slugs (slug).
  Mass get slugs => Mass(toDouble(), MassUnit.slug);

  /// Creates a [Mass] instance representing this numerical value in Short Tons (US).
  Mass get shortTons => Mass(toDouble(), MassUnit.shortTon);

  /// Creates a [Mass] instance representing this numerical value in Long Tons (UK).
  Mass get longTons => Mass(toDouble(), MassUnit.longTon);

  /// Creates a [Mass] instance representing this numerical value in Atomic Mass Units (u).
  Mass get u => Mass(toDouble(), MassUnit.atomicMassUnit);

  /// Creates a [Mass] instance representing this numerical value in Atomic Mass Units (u).
  /// Alias for `u`.
  Mass get atomicMassUnits => Mass(toDouble(), MassUnit.atomicMassUnit);

  /// Creates a [Mass] instance representing this numerical value in Carats (ct).
  Mass get ct => Mass(toDouble(), MassUnit.carat);

  /// Creates a [Mass] instance representing this numerical value in Carats (ct).
  /// Alias for `ct`.
  Mass get carats => Mass(toDouble(), MassUnit.carat);
}
