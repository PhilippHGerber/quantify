import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'torque_factors.dart';

/// Represents units of torque.
///
/// This enum implements the [LinearUnit] interface to provide conversion capabilities
/// and a display [symbol] for each torque unit.
/// All conversion factors are pre-calculated in the constructor relative to
/// Newton-meter (N·m).
///
/// Note: Torque (N·m) is dimensionally identical to energy (J = N·m), but they
/// are semantically distinct. [TorqueUnit] and the energy unit enum are separate
/// types so the Dart type system prevents accidental mixing.
enum TorqueUnit implements LinearUnit<TorqueUnit> {
  /// Newton-meter (N·m), the SI derived unit of torque.
  newtonMeter(1, 'N·m'),

  /// Millinewton-meter (mN·m), used for small precision torques (e.g. micro-servos).
  millinewtonMeter(TorqueFactors.newtonMetersPerMillinewtonMeter, 'mN·m'),

  /// Kilonewton-meter (kN·m), used in structural and civil engineering.
  kilonewtonMeter(TorqueFactors.newtonMetersPerKilonewtonMeter, 'kN·m'),

  /// Meganewton-meter (MN·m), used for very large structures (e.g. wind turbine gearboxes).
  meganewtonMeter(TorqueFactors.newtonMetersPerMeganewtonMeter, 'MN·m'),

  /// Pound-force-foot (lbf·ft), the primary imperial/US customary unit of torque.
  ///
  /// Commonly used for engine torque specifications in the United States.
  poundFoot(TorqueFactors.newtonMetersPerPoundFoot, 'lbf·ft'),

  /// Pound-force-inch (lbf·in), an imperial unit used for smaller torques.
  ///
  /// Common in mechanical fastener specifications and small motor ratings.
  poundInch(TorqueFactors.newtonMetersPerPoundInch, 'lbf·in'),

  /// Kilogram-force-meter (kgf·m), a gravitational metric unit of torque.
  ///
  /// Used in older metric engineering contexts and some automotive specifications.
  kilogramForceMeter(TorqueFactors.newtonMetersPerKilogramForceMeter, 'kgf·m'),

  /// Ounce-force-inch (ozf·in), used for very small torques such as hobby servos.
  ounceForceInch(TorqueFactors.newtonMetersPerOunceForceInch, 'ozf·in'),

  /// Dyne-centimeter (dyn·cm), the CGS unit of torque.
  ///
  /// Equivalent to 1 × 10⁻⁷ N·m. Used in scientific contexts with CGS units.
  dyneCentimeter(TorqueFactors.newtonMetersPerDyneCentimeter, 'dyn·cm');

  /// Constant constructor for enum members.
  const TorqueUnit(double toNmFactor, this.symbol)
      : _toNmFactor = toNmFactor,
        _factorToNewtonMeter = toNmFactor,
        _factorToMillinewtonMeter = toNmFactor / TorqueFactors.newtonMetersPerMillinewtonMeter,
        _factorToKilonewtonMeter = toNmFactor / TorqueFactors.newtonMetersPerKilonewtonMeter,
        _factorToMeganewtonMeter = toNmFactor / TorqueFactors.newtonMetersPerMeganewtonMeter,
        _factorToPoundFoot = toNmFactor / TorqueFactors.newtonMetersPerPoundFoot,
        _factorToPoundInch = toNmFactor / TorqueFactors.newtonMetersPerPoundInch,
        _factorToKilogramForceMeter = toNmFactor / TorqueFactors.newtonMetersPerKilogramForceMeter,
        _factorToOunceForceInch = toNmFactor / TorqueFactors.newtonMetersPerOunceForceInch,
        _factorToDyneCentimeter = toNmFactor / TorqueFactors.newtonMetersPerDyneCentimeter;

  // ignore: unused_field // Stored for reference; direct conversion factors are used instead.
  final double _toNmFactor;

  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors ---
  final double _factorToNewtonMeter;
  final double _factorToMillinewtonMeter;
  final double _factorToKilonewtonMeter;
  final double _factorToMeganewtonMeter;
  final double _factorToPoundFoot;
  final double _factorToPoundInch;
  final double _factorToKilogramForceMeter;
  final double _factorToOunceForceInch;
  final double _factorToDyneCentimeter;

  /// SI and unit symbols matched **strictly case-sensitive**.
  ///
  /// Includes ASCII `.` fallbacks (e.g. `'N.m'`) alongside the canonical
  /// middle-dot `·` (U+00B7) forms for environments where the Unicode character
  /// is not available.
  ///
  /// Used by `Torque.parser`.
  @internal
  static const Map<String, TorqueUnit> symbolAliases = {
    // newton-meter
    'N·m': TorqueUnit.newtonMeter,
    'N.m': TorqueUnit.newtonMeter,
    // millinewton-meter
    'mN·m': TorqueUnit.millinewtonMeter,
    'mN.m': TorqueUnit.millinewtonMeter,
    // kilonewton-meter
    'kN·m': TorqueUnit.kilonewtonMeter,
    'kN.m': TorqueUnit.kilonewtonMeter,
    // meganewton-meter
    'MN·m': TorqueUnit.meganewtonMeter,
    'MN.m': TorqueUnit.meganewtonMeter,
    // pound-force-foot
    'lbf·ft': TorqueUnit.poundFoot,
    'lbf.ft': TorqueUnit.poundFoot,
    'lb·ft': TorqueUnit.poundFoot,
    'lb.ft': TorqueUnit.poundFoot,
    // pound-force-inch
    'lbf·in': TorqueUnit.poundInch,
    'lbf.in': TorqueUnit.poundInch,
    'lb·in': TorqueUnit.poundInch,
    'lb.in': TorqueUnit.poundInch,
    // kilogram-force-meter
    'kgf·m': TorqueUnit.kilogramForceMeter,
    'kgf.m': TorqueUnit.kilogramForceMeter,
    // ounce-force-inch
    'ozf·in': TorqueUnit.ounceForceInch,
    'ozf.in': TorqueUnit.ounceForceInch,
    'oz·in': TorqueUnit.ounceForceInch,
    'oz.in': TorqueUnit.ounceForceInch,
    // dyne-centimeter
    'dyn·cm': TorqueUnit.dyneCentimeter,
    'dyn.cm': TorqueUnit.dyneCentimeter,
  };

  /// Full word-form names matched **case-insensitively**.
  ///
  /// Used by `Torque.parser`.
  @internal
  static const Map<String, TorqueUnit> nameAliases = {
    // newton-meter
    'newton-meter': TorqueUnit.newtonMeter,
    'newton-meters': TorqueUnit.newtonMeter,
    'newton meter': TorqueUnit.newtonMeter,
    'newton meters': TorqueUnit.newtonMeter,
    // millinewton-meter
    'millinewton-meter': TorqueUnit.millinewtonMeter,
    'millinewton-meters': TorqueUnit.millinewtonMeter,
    'millinewton meter': TorqueUnit.millinewtonMeter,
    'millinewton meters': TorqueUnit.millinewtonMeter,
    // kilonewton-meter
    'kilonewton-meter': TorqueUnit.kilonewtonMeter,
    'kilonewton-meters': TorqueUnit.kilonewtonMeter,
    'kilonewton meter': TorqueUnit.kilonewtonMeter,
    'kilonewton meters': TorqueUnit.kilonewtonMeter,
    // meganewton-meter
    'meganewton-meter': TorqueUnit.meganewtonMeter,
    'meganewton-meters': TorqueUnit.meganewtonMeter,
    'meganewton meter': TorqueUnit.meganewtonMeter,
    'meganewton meters': TorqueUnit.meganewtonMeter,
    // pound-foot
    'pound-foot': TorqueUnit.poundFoot,
    'pound-feet': TorqueUnit.poundFoot,
    'pound foot': TorqueUnit.poundFoot,
    'pound feet': TorqueUnit.poundFoot,
    'foot-pound': TorqueUnit.poundFoot,
    'foot-pounds': TorqueUnit.poundFoot,
    'foot pound': TorqueUnit.poundFoot,
    'foot pounds': TorqueUnit.poundFoot,
    'pound-force-foot': TorqueUnit.poundFoot,
    'pound-force-feet': TorqueUnit.poundFoot,
    'pound force foot': TorqueUnit.poundFoot,
    'pound force feet': TorqueUnit.poundFoot,
    // pound-inch
    'pound-inch': TorqueUnit.poundInch,
    'pound-inches': TorqueUnit.poundInch,
    'pound inch': TorqueUnit.poundInch,
    'pound inches': TorqueUnit.poundInch,
    'inch-pound': TorqueUnit.poundInch,
    'inch-pounds': TorqueUnit.poundInch,
    'inch pound': TorqueUnit.poundInch,
    'inch pounds': TorqueUnit.poundInch,
    'pound-force-inch': TorqueUnit.poundInch,
    'pound-force-inches': TorqueUnit.poundInch,
    'pound force inch': TorqueUnit.poundInch,
    'pound force inches': TorqueUnit.poundInch,
    // kilogram-force-meter
    'kilogram-force-meter': TorqueUnit.kilogramForceMeter,
    'kilogram-force-meters': TorqueUnit.kilogramForceMeter,
    'kilogram force meter': TorqueUnit.kilogramForceMeter,
    'kilogram force meters': TorqueUnit.kilogramForceMeter,
    'kilogram-force meter': TorqueUnit.kilogramForceMeter,
    'kilogram-force meters': TorqueUnit.kilogramForceMeter,
    // ounce-force-inch
    'ounce-force-inch': TorqueUnit.ounceForceInch,
    'ounce-force-inches': TorqueUnit.ounceForceInch,
    'ounce force inch': TorqueUnit.ounceForceInch,
    'ounce force inches': TorqueUnit.ounceForceInch,
    'ounce-inch': TorqueUnit.ounceForceInch,
    'ounce-inches': TorqueUnit.ounceForceInch,
    'ounce inch': TorqueUnit.ounceForceInch,
    'ounce inches': TorqueUnit.ounceForceInch,
    // dyne-centimeter
    'dyne-centimeter': TorqueUnit.dyneCentimeter,
    'dyne-centimeters': TorqueUnit.dyneCentimeter,
    'dyne centimeter': TorqueUnit.dyneCentimeter,
    'dyne centimeters': TorqueUnit.dyneCentimeter,
  };

  @override
  @internal
  double factorTo(TorqueUnit targetUnit) {
    switch (targetUnit) {
      case TorqueUnit.newtonMeter:
        return _factorToNewtonMeter;
      case TorqueUnit.millinewtonMeter:
        return _factorToMillinewtonMeter;
      case TorqueUnit.kilonewtonMeter:
        return _factorToKilonewtonMeter;
      case TorqueUnit.meganewtonMeter:
        return _factorToMeganewtonMeter;
      case TorqueUnit.poundFoot:
        return _factorToPoundFoot;
      case TorqueUnit.poundInch:
        return _factorToPoundInch;
      case TorqueUnit.kilogramForceMeter:
        return _factorToKilogramForceMeter;
      case TorqueUnit.ounceForceInch:
        return _factorToOunceForceInch;
      case TorqueUnit.dyneCentimeter:
        return _factorToDyneCentimeter;
    }
  }
}
