import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'force_factors.dart';

/// Represents units of force.
///
/// This enum implements the [LinearUnit] interface to provide conversion capabilities
/// and a display [symbol] for each force unit.
/// All conversion factors are pre-calculated in the constructor relative to
/// Newton (N).
enum ForceUnit implements LinearUnit<ForceUnit> {
  /// Newton (N), the SI derived unit of force.
  newton(1, 'N'),

  /// Nanonewton (nN), the standard scale for AFM and cellular mechanics.
  nanonewton(ForceFactors.newtonsPerNanonewton, 'nN'),

  /// Micronewton (µN), for MEMS and ion thruster output.
  micronewton(ForceFactors.newtonsPerMicronewton, 'µN'),

  /// Millinewton (mN), a common sub-multiple of the Newton.
  millinewton(ForceFactors.newtonsPerMillinewton, 'mN'),

  /// Kilonewton (kN), a common multiple of the Newton.
  kilonewton(ForceFactors.newtonsPerKilonewton, 'kN'),

  /// Meganewton (MN), used for very large forces (e.g., rocket thrust).
  meganewton(ForceFactors.newtonsPerMeganewton, 'MN'),

  /// Giganewton (GN), used in geology (tectonic plate forces).
  giganewton(ForceFactors.newtonsPerGiganewton, 'GN'),

  /// Pound-force (lbf), the imperial/US customary unit of force.
  poundForce(ForceFactors.newtonsPerPoundForce, 'lbf'),

  /// Dyne (dyn), the CGS unit of force.
  dyne(ForceFactors.newtonsPerDyne, 'dyn'),

  /// Kilogram-force (kgf) or Kilopond (kp), a gravitational metric unit of force.
  kilogramForce(ForceFactors.newtonsPerKilogramForce, 'kgf'),

  /// Gram-force (gf), the force exerted by one gram in standard gravity.
  gramForce(ForceFactors.newtonsPerGramForce, 'gf'),

  /// Poundal (pdl), the force to accelerate 1 pound-mass by 1 ft/s².
  poundal(ForceFactors.newtonsPerPoundal, 'pdl');

  /// Constant constructor for enum members.
  const ForceUnit(double toNewtonFactor, this.symbol)
      : _toNewtonFactor = toNewtonFactor,
        _factorToNewton = toNewtonFactor / 1.0,
        _factorToNanonewton = toNewtonFactor / ForceFactors.newtonsPerNanonewton,
        _factorToMicronewton = toNewtonFactor / ForceFactors.newtonsPerMicronewton,
        _factorToMillinewton = toNewtonFactor / ForceFactors.newtonsPerMillinewton,
        _factorToKilonewton = toNewtonFactor / ForceFactors.newtonsPerKilonewton,
        _factorToMeganewton = toNewtonFactor / ForceFactors.newtonsPerMeganewton,
        _factorToGiganewton = toNewtonFactor / ForceFactors.newtonsPerGiganewton,
        _factorToPoundForce = toNewtonFactor / ForceFactors.newtonsPerPoundForce,
        _factorToDyne = toNewtonFactor / ForceFactors.newtonsPerDyne,
        _factorToKilogramForce = toNewtonFactor / ForceFactors.newtonsPerKilogramForce,
        _factorToGramForce = toNewtonFactor / ForceFactors.newtonsPerGramForce,
        _factorToPoundal = toNewtonFactor / ForceFactors.newtonsPerPoundal;

  // ignore: unused_field // Used to store the conversion factor to Newton (N).
  final double _toNewtonFactor;

  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors ---
  final double _factorToNewton;
  final double _factorToNanonewton;
  final double _factorToMicronewton;
  final double _factorToMillinewton;
  final double _factorToKilonewton;
  final double _factorToMeganewton;
  final double _factorToGiganewton;
  final double _factorToPoundForce;
  final double _factorToDyne;
  final double _factorToKilogramForce;
  final double _factorToGramForce;
  final double _factorToPoundal;

  /// SI and unit symbols matched **strictly case-sensitive**.
  ///
  /// Used by `Force.parser`.
  @internal
  static const Map<String, ForceUnit> symbolAliases = {
    // newton
    'N': ForceUnit.newton,
    // nanonewton
    'nN': ForceUnit.nanonewton,
    // micronewton
    'µN': ForceUnit.micronewton,
    'uN': ForceUnit.micronewton,
    // millinewton
    'mN': ForceUnit.millinewton,
    // kilonewton
    'kN': ForceUnit.kilonewton,
    // meganewton
    'MN': ForceUnit.meganewton,
    // giganewton
    'GN': ForceUnit.giganewton,
    // pound-force
    'lbf': ForceUnit.poundForce,
    // dyne
    'dyn': ForceUnit.dyne,
    // kilogram-force
    'kgf': ForceUnit.kilogramForce,
    'kp': ForceUnit.kilogramForce,
    // gram-force
    'gf': ForceUnit.gramForce,
    // poundal
    'pdl': ForceUnit.poundal,
  };

  /// Full word-form names matched **case-insensitively**.
  ///
  /// Used by `Force.parser`.
  @internal
  static const Map<String, ForceUnit> nameAliases = {
    // newton
    'newton': ForceUnit.newton,
    'newtons': ForceUnit.newton,
    // nanonewton
    'nanonewton': ForceUnit.nanonewton,
    'nanonewtons': ForceUnit.nanonewton,
    // micronewton
    'micronewton': ForceUnit.micronewton,
    'micronewtons': ForceUnit.micronewton,
    // millinewton
    'millinewton': ForceUnit.millinewton,
    'millinewtons': ForceUnit.millinewton,
    // kilonewton
    'kilonewton': ForceUnit.kilonewton,
    'kilonewtons': ForceUnit.kilonewton,
    // meganewton
    'meganewton': ForceUnit.meganewton,
    'meganewtons': ForceUnit.meganewton,
    // giganewton
    'giganewton': ForceUnit.giganewton,
    'giganewtons': ForceUnit.giganewton,
    // pound-force
    'pound-force': ForceUnit.poundForce,
    'pounds-force': ForceUnit.poundForce,
    'pound force': ForceUnit.poundForce,
    'pounds force': ForceUnit.poundForce,
    // dyne
    'dyne': ForceUnit.dyne,
    'dynes': ForceUnit.dyne,
    // kilogram-force
    'kilogram-force': ForceUnit.kilogramForce,
    'kilograms-force': ForceUnit.kilogramForce,
    'kilogram force': ForceUnit.kilogramForce,
    'kilograms force': ForceUnit.kilogramForce,
    'kilopond': ForceUnit.kilogramForce,
    'kiloponds': ForceUnit.kilogramForce,
    // gram-force
    'gram-force': ForceUnit.gramForce,
    'grams-force': ForceUnit.gramForce,
    'gram force': ForceUnit.gramForce,
    'grams force': ForceUnit.gramForce,
    // poundal
    'poundal': ForceUnit.poundal,
    'poundals': ForceUnit.poundal,
  };

  @override
  @internal
  double factorTo(ForceUnit targetUnit) {
    switch (targetUnit) {
      case ForceUnit.newton:
        return _factorToNewton;
      case ForceUnit.nanonewton:
        return _factorToNanonewton;
      case ForceUnit.micronewton:
        return _factorToMicronewton;
      case ForceUnit.millinewton:
        return _factorToMillinewton;
      case ForceUnit.kilonewton:
        return _factorToKilonewton;
      case ForceUnit.meganewton:
        return _factorToMeganewton;
      case ForceUnit.giganewton:
        return _factorToGiganewton;
      case ForceUnit.poundForce:
        return _factorToPoundForce;
      case ForceUnit.dyne:
        return _factorToDyne;
      case ForceUnit.kilogramForce:
        return _factorToKilogramForce;
      case ForceUnit.gramForce:
        return _factorToGramForce;
      case ForceUnit.poundal:
        return _factorToPoundal;
    }
  }
}
