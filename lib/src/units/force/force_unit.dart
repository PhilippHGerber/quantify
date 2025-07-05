import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'force_factors.dart';

/// Represents units of force.
///
/// This enum implements the [Unit] interface to provide conversion capabilities
/// and a display [symbol] for each force unit.
/// All conversion factors are pre-calculated in the constructor relative to
/// Newton (N).
enum ForceUnit implements Unit<ForceUnit> {
  /// Newton (N), the SI derived unit of force.
  newton(1, 'N'),

  /// Kilonewton (kN), a common multiple of the Newton.
  kilonewton(ForceFactors.newtonsPerKilonewton, 'kN'),

  /// Meganewton (MN), used for very large forces (e.g., rocket thrust).
  meganewton(ForceFactors.newtonsPerMeganewton, 'MN'),

  /// Millinewton (mN), a common sub-multiple of the Newton.
  millinewton(ForceFactors.newtonsPerMillinewton, 'mN'),

  /// Pound-force (lbf), the imperial/US customary unit of force.
  poundForce(ForceFactors.newtonsPerPoundForce, 'lbf'),

  /// Dyne (dyn), the CGS unit of force.
  dyne(ForceFactors.newtonsPerDyne, 'dyn'),

  /// Kilogram-force (kgf) or Kilopond (kp), a gravitational metric unit of force.
  kilogramForce(ForceFactors.newtonsPerKilogramForce, 'kgf');

  /// Constant constructor for enum members.
  const ForceUnit(double toNewtonFactor, this.symbol)
      : _toNewtonFactor = toNewtonFactor,
        _factorToNewton = toNewtonFactor / 1.0,
        _factorToKilonewton = toNewtonFactor / ForceFactors.newtonsPerKilonewton,
        _factorToMeganewton = toNewtonFactor / ForceFactors.newtonsPerMeganewton,
        _factorToMillinewton = toNewtonFactor / ForceFactors.newtonsPerMillinewton,
        _factorToPoundForce = toNewtonFactor / ForceFactors.newtonsPerPoundForce,
        _factorToDyne = toNewtonFactor / ForceFactors.newtonsPerDyne,
        _factorToKilogramForce = toNewtonFactor / ForceFactors.newtonsPerKilogramForce;

  // ignore: unused_field
  final double _toNewtonFactor;

  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors ---
  final double _factorToNewton;
  final double _factorToKilonewton;
  final double _factorToMeganewton;
  final double _factorToMillinewton;
  final double _factorToPoundForce;
  final double _factorToDyne;
  final double _factorToKilogramForce;

  @override
  @internal
  double factorTo(ForceUnit targetUnit) {
    switch (targetUnit) {
      case ForceUnit.newton:
        return _factorToNewton;
      case ForceUnit.kilonewton:
        return _factorToKilonewton;
      case ForceUnit.meganewton:
        return _factorToMeganewton;
      case ForceUnit.millinewton:
        return _factorToMillinewton;
      case ForceUnit.poundForce:
        return _factorToPoundForce;
      case ForceUnit.dyne:
        return _factorToDyne;
      case ForceUnit.kilogramForce:
        return _factorToKilogramForce;
    }
  }
}
