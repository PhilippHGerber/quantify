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

  /// Returns the mass value in Grams (g).
  double get inGrams => getValue(MassUnit.gram);

  /// Returns the mass value in Milligrams (mg).
  double get inMilligrams => getValue(MassUnit.milligram);

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

  // --- "As" Getters for new Mass objects ---

  /// Returns a new [Mass] object representing this mass in Kilograms (kg).
  Mass get asKilograms => convertTo(MassUnit.kilogram);

  /// Returns a new [Mass] object representing this mass in Grams (g).
  Mass get asGrams => convertTo(MassUnit.gram);

  /// Returns a new [Mass] object representing this mass in Milligrams (mg).
  Mass get asMilligrams => convertTo(MassUnit.milligram);

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
}

/// Provides convenient factory methods for creating [Mass] instances from [num]
/// using getter properties named after common unit symbols or names.
///
/// This allows for an intuitive and concise way to create mass quantities,
/// for example: `70.kg` or `500.grams`.
extension MassCreation on num {
  /// Creates a [Mass] instance representing this numerical value in Kilograms (kg).
  Mass get kg => Mass(toDouble(), MassUnit.kilogram);

  /// Creates a [Mass] instance representing this numerical value in Grams (g).
  Mass get g => Mass(toDouble(), MassUnit.gram);

  /// Creates a [Mass] instance representing this numerical value in Grams (g).
  /// Alias for `g`.
  Mass get grams => Mass(toDouble(), MassUnit.gram);

  /// Creates a [Mass] instance representing this numerical value in Milligrams (mg).
  Mass get mg => Mass(toDouble(), MassUnit.milligram);

  /// Creates a [Mass] instance representing this numerical value in Milligrams (mg).
  /// Alias for `mg`.
  Mass get milligrams => Mass(toDouble(), MassUnit.milligram);

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
}
