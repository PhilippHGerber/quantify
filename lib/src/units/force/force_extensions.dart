import 'force.dart';
import 'force_unit.dart';

// SI/IEC unit symbols use uppercase letters by international standard
// (e.g., 'MN' for meganewton).
// Dart's lowerCamelCase rule is intentionally overridden here to preserve
// domain correctness and discoverability for scientists and engineers.
// ignore_for_file: non_constant_identifier_names

/// Provides convenient access to [Force] values in specific units.
extension ForceValueGetters on Force {
  /// Returns the force value in Newtons (N).
  double get inNewtons => getValue(ForceUnit.newton);

  /// Returns the force value in Kilonewtons (kN).
  double get inKilonewtons => getValue(ForceUnit.kilonewton);

  /// Returns the force value in Meganewtons (MN).
  double get inMeganewtons => getValue(ForceUnit.meganewton);

  /// Returns the force value in Giganewtons (GN).
  double get inGiganewtons => getValue(ForceUnit.giganewton);

  /// Returns the force value in Millinewtons (mN).
  double get inMillinewtons => getValue(ForceUnit.millinewton);

  /// Returns the force value in Micronewtons (µN).
  double get inMicronewtons => getValue(ForceUnit.micronewton);

  /// Returns the force value in Nanonewtons (nN).
  double get inNanonewtons => getValue(ForceUnit.nanonewton);

  /// Returns the force value in Pounds-force (lbf).
  double get inPoundsForce => getValue(ForceUnit.poundForce);

  /// Returns the force value in Dyne (dyn).
  double get inDynes => getValue(ForceUnit.dyne);

  /// Returns the force value in Kilogram-force (kgf).
  double get inKilogramsForce => getValue(ForceUnit.kilogramForce);

  /// Returns the force value in Gram-force (gf).
  double get inGramsForce => getValue(ForceUnit.gramForce);

  /// Returns the force value in Poundals (pdl).
  double get inPoundals => getValue(ForceUnit.poundal);

  /// Returns a [Force] object representing this force in Newtons (N).
  Force get asNewtons => convertTo(ForceUnit.newton);

  /// Returns a [Force] object representing this force in Kilonewtons (kN).
  Force get asKilonewtons => convertTo(ForceUnit.kilonewton);

  /// Returns a [Force] object representing this force in Meganewtons (MN).
  Force get asMeganewtons => convertTo(ForceUnit.meganewton);

  /// Returns a [Force] object representing this force in Giganewtons (GN).
  Force get asGiganewtons => convertTo(ForceUnit.giganewton);

  /// Returns a [Force] object representing this force in Millinewtons (mN).
  Force get asMillinewtons => convertTo(ForceUnit.millinewton);

  /// Returns a [Force] object representing this force in Micronewtons (µN).
  Force get asMicronewtons => convertTo(ForceUnit.micronewton);

  /// Returns a [Force] object representing this force in Nanonewtons (nN).
  Force get asNanonewtons => convertTo(ForceUnit.nanonewton);

  /// Returns a [Force] object representing this force in Pounds-force (lbf).
  Force get asPoundsForce => convertTo(ForceUnit.poundForce);

  /// Returns a [Force] object representing this force in Dyne (dyn).
  Force get asDynes => convertTo(ForceUnit.dyne);

  /// Returns a [Force] object representing this force in Kilogram-force (kgf).
  Force get asKilogramsForce => convertTo(ForceUnit.kilogramForce);

  /// Returns a [Force] object representing this force in Gram-force (gf).
  Force get asGramsForce => convertTo(ForceUnit.gramForce);

  /// Returns a [Force] object representing this force in Poundals (pdl).
  Force get asPoundals => convertTo(ForceUnit.poundal);
}

/// Provides convenient factory methods for creating [Force] instances from [num].
extension ForceCreation on num {
  /// Creates a [Force] instance from this value in Newtons (N).
  Force get N => Force(toDouble(), ForceUnit.newton);

  /// Creates a [Force] instance from this value in Newtons (N).
  Force get newtons => Force(toDouble(), ForceUnit.newton);

  /// Creates a [Force] instance from this value in Kilonewtons (kN).
  Force get kN => Force(toDouble(), ForceUnit.kilonewton);

  /// Creates a [Force] instance from this value in Kilonewtons (kN).
  Force get kilonewtons => Force(toDouble(), ForceUnit.kilonewton);

  /// Creates a [Force] instance from this value in Meganewtons (MN).
  ///
  /// The SI symbol for meganewton is 'MN' (capital M = mega prefix).
  Force get MN => Force(toDouble(), ForceUnit.meganewton);

  /// Creates a [Force] instance from this value in Meganewtons (MN).
  /// Dart-idiomatic alias for the SI symbol [MN].
  Force get meganewtons => Force(toDouble(), ForceUnit.meganewton);

  /// Creates a [Force] instance from this value in Giganewtons (GN).
  Force get GN => Force(toDouble(), ForceUnit.giganewton);

  /// Creates a [Force] instance from this value in Giganewtons (GN).
  Force get giganewtons => Force(toDouble(), ForceUnit.giganewton);

  /// Creates a [Force] instance from this value in Millinewtons (mN).
  Force get mN => Force(toDouble(), ForceUnit.millinewton);

  /// Creates a [Force] instance from this value in Millinewtons (mN).
  Force get millinewtons => Force(toDouble(), ForceUnit.millinewton);

  /// Creates a [Force] instance from this value in Micronewtons (µN).
  Force get uN => Force(toDouble(), ForceUnit.micronewton);

  /// Creates a [Force] instance from this value in Micronewtons (µN).
  /// Alias for [uN].
  Force get micronewtons => Force(toDouble(), ForceUnit.micronewton);

  /// Creates a [Force] instance from this value in Nanonewtons (nN).
  Force get nN => Force(toDouble(), ForceUnit.nanonewton);

  /// Creates a [Force] instance from this value in Nanonewtons (nN).
  Force get nanonewtons => Force(toDouble(), ForceUnit.nanonewton);

  /// Creates a [Force] instance from this value in Pounds-force (lbf).
  Force get lbf => Force(toDouble(), ForceUnit.poundForce);

  /// Creates a [Force] instance from this value in Pounds-force (lbf).
  /// Alias for [lbf].
  Force get poundsForce => Force(toDouble(), ForceUnit.poundForce);

  /// Creates a [Force] instance from this value in Dyne (dyn).
  Force get dyn => Force(toDouble(), ForceUnit.dyne);

  /// Creates a [Force] instance from this value in Dyne (dyn).
  Force get dynes => Force(toDouble(), ForceUnit.dyne);

  /// Creates a [Force] instance from this value in Kilogram-force (kgf).
  Force get kgf => Force(toDouble(), ForceUnit.kilogramForce);

  /// Creates a [Force] instance from this value in Gram-force (gf).
  Force get gf => Force(toDouble(), ForceUnit.gramForce);

  /// Creates a [Force] instance from this value in Poundals (pdl).
  Force get pdl => Force(toDouble(), ForceUnit.poundal);
}
