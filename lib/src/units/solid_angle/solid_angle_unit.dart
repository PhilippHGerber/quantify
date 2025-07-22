import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'solid_angle_factors.dart';

/// Represents units of solid angle.
///
/// This enum implements the [Unit] interface to provide conversion capabilities
/// and a display [symbol] for each solid angle unit.
/// All conversion factors are pre-calculated in the constructor relative to
/// Steradian (sr).
enum SolidAngleUnit implements Unit<SolidAngleUnit> {
  /// Steradian (sr), the SI derived unit of solid angle.
  steradian(1, 'sr'),

  /// Square Degree (deg²), a non-SI unit for solid angle.
  squareDegree(SolidAngleFactors.steradiansPerSquareDegree, 'deg²'),

  /// Spat (sp), an obsolete unit for the solid angle of a full sphere (4π sr).
  spat(SolidAngleFactors.steradiansPerSpat, 'sp');

  /// Constant constructor for enum members.
  const SolidAngleUnit(double toSteradianFactor, this.symbol)
      : _toSteradianFactor = toSteradianFactor,
        _factorToSteradian = toSteradianFactor / 1.0,
        _factorToSquareDegree = toSteradianFactor / SolidAngleFactors.steradiansPerSquareDegree,
        _factorToSpat = toSteradianFactor / SolidAngleFactors.steradiansPerSpat;

  // ignore: unused_field // The factor to convert this unit to Steradian (sr).
  final double _toSteradianFactor;

  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors ---
  final double _factorToSteradian;
  final double _factorToSquareDegree;
  final double _factorToSpat;

  @override
  @internal
  double factorTo(SolidAngleUnit targetUnit) {
    switch (targetUnit) {
      case SolidAngleUnit.steradian:
        return _factorToSteradian;
      case SolidAngleUnit.squareDegree:
        return _factorToSquareDegree;
      case SolidAngleUnit.spat:
        return _factorToSpat;
    }
  }
}
