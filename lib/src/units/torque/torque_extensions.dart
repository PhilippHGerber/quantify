import 'torque.dart';
import 'torque_unit.dart';

// SI/IEC unit symbols use uppercase letters by international standard
// (e.g., 'MN·m' for meganewton-meter).
// Dart's lowerCamelCase rule is intentionally overridden here to preserve
// domain correctness and discoverability for scientists and engineers.
// ignore_for_file: non_constant_identifier_names

/// Provides convenient access to [Torque] values in specific units.
extension TorqueValueGetters on Torque {
  /// Returns the torque value in Newton-meters (N·m).
  double get inNewtonMeters => getValue(TorqueUnit.newtonMeter);

  /// Returns the torque value in millinewton-meters (mN·m).
  double get inMillinewtonMeters => getValue(TorqueUnit.millinewtonMeter);

  /// Returns the torque value in kilonewton-meters (kN·m).
  double get inKilonewtonMeters => getValue(TorqueUnit.kilonewtonMeter);

  /// Returns the torque value in meganewton-meters (MN·m).
  double get inMeganewtonMeters => getValue(TorqueUnit.meganewtonMeter);

  /// Returns the torque value in pound-force-feet (lbf·ft).
  double get inPoundFeet => getValue(TorqueUnit.poundFoot);

  /// Returns the torque value in pound-force-inches (lbf·in).
  double get inPoundInches => getValue(TorqueUnit.poundInch);

  /// Returns the torque value in kilogram-force-meters (kgf·m).
  double get inKilogramForceMeters => getValue(TorqueUnit.kilogramForceMeter);

  /// Returns the torque value in ounce-force-inches (ozf·in).
  double get inOunceForceInches => getValue(TorqueUnit.ounceForceInch);

  /// Returns the torque value in dyne-centimeters (dyn·cm).
  double get inDyneCentimeters => getValue(TorqueUnit.dyneCentimeter);

  /// Returns a [Torque] object representing this torque in Newton-meters (N·m).
  Torque get asNewtonMeters => convertTo(TorqueUnit.newtonMeter);

  /// Returns a [Torque] object representing this torque in millinewton-meters (mN·m).
  Torque get asMillinewtonMeters => convertTo(TorqueUnit.millinewtonMeter);

  /// Returns a [Torque] object representing this torque in kilonewton-meters (kN·m).
  Torque get asKilonewtonMeters => convertTo(TorqueUnit.kilonewtonMeter);

  /// Returns a [Torque] object representing this torque in meganewton-meters (MN·m).
  Torque get asMeganewtonMeters => convertTo(TorqueUnit.meganewtonMeter);

  /// Returns a [Torque] object representing this torque in pound-force-feet (lbf·ft).
  Torque get asPoundFeet => convertTo(TorqueUnit.poundFoot);

  /// Returns a [Torque] object representing this torque in pound-force-inches (lbf·in).
  Torque get asPoundInches => convertTo(TorqueUnit.poundInch);

  /// Returns a [Torque] object representing this torque in kilogram-force-meters (kgf·m).
  Torque get asKilogramForceMeters => convertTo(TorqueUnit.kilogramForceMeter);

  /// Returns a [Torque] object representing this torque in ounce-force-inches (ozf·in).
  Torque get asOunceForceInches => convertTo(TorqueUnit.ounceForceInch);

  /// Returns a [Torque] object representing this torque in dyne-centimeters (dyn·cm).
  Torque get asDyneCentimeters => convertTo(TorqueUnit.dyneCentimeter);
}

/// Provides convenient factory methods for creating [Torque] instances from [num].
extension TorqueCreation on num {
  /// Creates a [Torque] instance from this value in Newton-meters (N·m).
  ///
  /// The SI symbol 'N·m' uses an uppercase N (Newton) and lowercase m (meter).
  Torque get Nm => Torque(toDouble(), TorqueUnit.newtonMeter);

  /// Creates a [Torque] instance from this value in Newton-meters (N·m).
  /// Dart-idiomatic alias for [Nm].
  Torque get newtonMeter => Torque(toDouble(), TorqueUnit.newtonMeter);

  /// Creates a [Torque] instance from this value in Newton-meters (N·m).
  Torque get newtonMeters => Torque(toDouble(), TorqueUnit.newtonMeter);

  /// Creates a [Torque] instance from this value in millinewton-meters (mN·m).
  Torque get mNm => Torque(toDouble(), TorqueUnit.millinewtonMeter);

  /// Creates a [Torque] instance from this value in millinewton-meters (mN·m).
  Torque get millinewtonMeter => Torque(toDouble(), TorqueUnit.millinewtonMeter);

  /// Creates a [Torque] instance from this value in millinewton-meters (mN·m).
  Torque get millinewtonMeters => Torque(toDouble(), TorqueUnit.millinewtonMeter);

  /// Creates a [Torque] instance from this value in kilonewton-meters (kN·m).
  Torque get kNm => Torque(toDouble(), TorqueUnit.kilonewtonMeter);

  /// Creates a [Torque] instance from this value in kilonewton-meters (kN·m).
  Torque get kilonewtonMeter => Torque(toDouble(), TorqueUnit.kilonewtonMeter);

  /// Creates a [Torque] instance from this value in kilonewton-meters (kN·m).
  Torque get kilonewtonMeters => Torque(toDouble(), TorqueUnit.kilonewtonMeter);

  /// Creates a [Torque] instance from this value in meganewton-meters (MN·m).
  ///
  /// The SI symbol for meganewton-meter is 'MN·m' (capital M = mega prefix).
  Torque get MNm => Torque(toDouble(), TorqueUnit.meganewtonMeter);

  /// Creates a [Torque] instance from this value in meganewton-meters (MN·m).
  Torque get meganewtonMeter => Torque(toDouble(), TorqueUnit.meganewtonMeter);

  /// Creates a [Torque] instance from this value in meganewton-meters (MN·m).
  Torque get meganewtonMeters => Torque(toDouble(), TorqueUnit.meganewtonMeter);

  /// Creates a [Torque] instance from this value in pound-force-feet (lbf·ft).
  Torque get lbfFt => Torque(toDouble(), TorqueUnit.poundFoot);

  /// Creates a [Torque] instance from this value in pound-force-feet (lbf·ft).
  Torque get poundFoot => Torque(toDouble(), TorqueUnit.poundFoot);

  /// Creates a [Torque] instance from this value in pound-force-feet (lbf·ft).
  Torque get poundFeet => Torque(toDouble(), TorqueUnit.poundFoot);

  /// Creates a [Torque] instance from this value in pound-force-inches (lbf·in).
  Torque get lbfIn => Torque(toDouble(), TorqueUnit.poundInch);

  /// Creates a [Torque] instance from this value in pound-force-inches (lbf·in).
  Torque get poundInch => Torque(toDouble(), TorqueUnit.poundInch);

  /// Creates a [Torque] instance from this value in pound-force-inches (lbf·in).
  Torque get poundInches => Torque(toDouble(), TorqueUnit.poundInch);

  /// Creates a [Torque] instance from this value in kilogram-force-meters (kgf·m).
  Torque get kgfM => Torque(toDouble(), TorqueUnit.kilogramForceMeter);

  /// Creates a [Torque] instance from this value in kilogram-force-meters (kgf·m).
  Torque get kilogramForceMeter => Torque(toDouble(), TorqueUnit.kilogramForceMeter);

  /// Creates a [Torque] instance from this value in kilogram-force-meters (kgf·m).
  Torque get kilogramForceMeters => Torque(toDouble(), TorqueUnit.kilogramForceMeter);

  /// Creates a [Torque] instance from this value in ounce-force-inches (ozf·in).
  Torque get ozfIn => Torque(toDouble(), TorqueUnit.ounceForceInch);

  /// Creates a [Torque] instance from this value in ounce-force-inches (ozf·in).
  Torque get ounceForceInch => Torque(toDouble(), TorqueUnit.ounceForceInch);

  /// Creates a [Torque] instance from this value in ounce-force-inches (ozf·in).
  Torque get ounceForceInches => Torque(toDouble(), TorqueUnit.ounceForceInch);

  /// Creates a [Torque] instance from this value in dyne-centimeters (dyn·cm).
  Torque get dynCm => Torque(toDouble(), TorqueUnit.dyneCentimeter);

  /// Creates a [Torque] instance from this value in dyne-centimeters (dyn·cm).
  Torque get dyneCentimeter => Torque(toDouble(), TorqueUnit.dyneCentimeter);

  /// Creates a [Torque] instance from this value in dyne-centimeters (dyn·cm).
  Torque get dyneCentimeters => Torque(toDouble(), TorqueUnit.dyneCentimeter);
}
