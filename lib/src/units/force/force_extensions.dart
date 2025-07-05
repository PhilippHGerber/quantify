import 'force.dart';
import 'force_unit.dart';

/// Provides convenient access to [Force] values in specific units.
extension ForceValueGetters on Force {
  /// Returns the force value in Newtons (N).
  double get inNewtons => getValue(ForceUnit.newton);

  /// Returns the force value in Kilonewtons (kN).
  double get inKilonewtons => getValue(ForceUnit.kilonewton);

  /// Returns the force value in Meganewtons (MN).
  double get inMeganewtons => getValue(ForceUnit.meganewton);

  /// Returns the force value in Millinewtons (mN).
  double get inMillinewtons => getValue(ForceUnit.millinewton);

  /// Returns the force value in Pounds-force (lbf).
  double get inPoundsForce => getValue(ForceUnit.poundForce);

  /// Returns the force value in Dyne (dyn).
  double get inDynes => getValue(ForceUnit.dyne);

  /// Returns the force value in Kilogram-force (kgf).
  double get inKilogramsForce => getValue(ForceUnit.kilogramForce);

  /// Returns a [Force] object representing this force in Newtons (N).
  Force get asNewtons => convertTo(ForceUnit.newton);

  /// Returns a [Force] object representing this force in Kilonewtons (kN).
  Force get asKilonewtons => convertTo(ForceUnit.kilonewton);

  /// Returns a [Force] object representing this force in Meganewtons (MN).
  Force get asMeganewtons => convertTo(ForceUnit.meganewton);

  /// Returns a [Force] object representing this force in Millinewtons (mN).
  Force get asMillinewtons => convertTo(ForceUnit.millinewton);

  /// Returns a [Force] object representing this force in Pounds-force (lbf).
  Force get asPoundsForce => convertTo(ForceUnit.poundForce);

  /// Returns a [Force] object representing this force in Dyne (dyn).
  Force get asDynes => convertTo(ForceUnit.dyne);

  /// Returns a [Force] object representing this force in Kilogram-force (kgf).
  Force get asKilogramsForce => convertTo(ForceUnit.kilogramForce);
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
  Force get MN => Force(toDouble(), ForceUnit.meganewton);

  /// Creates a [Force] instance from this value in Meganewtons (MN).
  Force get meganewtons => Force(toDouble(), ForceUnit.meganewton);

  /// Creates a [Force] instance from this value in Millinewtons (mN).
  Force get mN => Force(toDouble(), ForceUnit.millinewton);

  /// Creates a [Force] instance from this value in Millinewtons (mN).
  Force get millinewtons => Force(toDouble(), ForceUnit.millinewton);

  /// Creates a [Force] instance from this value in Pounds-force (lbf).
  Force get lbf => Force(toDouble(), ForceUnit.poundForce);

  /// Creates a [Force] instance from this value in Dyne (dyn).
  Force get dyn => Force(toDouble(), ForceUnit.dyne);

  /// Creates a [Force] instance from this value in Dyne (dyn).
  Force get dynes => Force(toDouble(), ForceUnit.dyne);

  /// Creates a [Force] instance from this value in Kilogram-force (kgf).
  Force get kgf => Force(toDouble(), ForceUnit.kilogramForce);
}
