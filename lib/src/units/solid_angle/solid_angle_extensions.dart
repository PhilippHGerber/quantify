import 'solid_angle.dart';
import 'solid_angle_unit.dart';

/// Provides convenient access to [SolidAngle] values in specific units.
extension SolidAngleValueGetters on SolidAngle {
  /// Returns the solid angle value in Steradians (sr).
  double get inSteradians => getValue(SolidAngleUnit.steradian);

  /// Returns the solid angle value in Square Degrees (deg²).
  double get inSquareDegrees => getValue(SolidAngleUnit.squareDegree);

  /// Returns the solid angle value in Spat (sp).
  double get inSpat => getValue(SolidAngleUnit.spat);

  /// Returns a new [SolidAngle] object representing this solid angle in Steradians (sr).
  SolidAngle get asSteradians => convertTo(SolidAngleUnit.steradian);

  /// Returns a new [SolidAngle] object representing this solid angle in Square Degrees (deg²).
  SolidAngle get asSquareDegrees => convertTo(SolidAngleUnit.squareDegree);

  /// Returns a new [SolidAngle] object representing this solid angle in Spat (sp).
  SolidAngle get asSpat => convertTo(SolidAngleUnit.spat);
}

/// Provides convenient factory methods for creating [SolidAngle] instances from [num].
extension SolidAngleCreation on num {
  /// Creates a [SolidAngle] instance from this value in Steradians (sr).
  SolidAngle get sr => SolidAngle(toDouble(), SolidAngleUnit.steradian);

  /// Creates a [SolidAngle] instance from this value in Steradians (sr).
  /// Alias for `sr`.
  SolidAngle get steradians => SolidAngle(toDouble(), SolidAngleUnit.steradian);

  /// Creates a [SolidAngle] instance from this value in Square Degrees (deg²).
  ///
  /// Following the pattern of `m2` for square meters.
  SolidAngle get deg2 => SolidAngle(toDouble(), SolidAngleUnit.squareDegree);

  /// Creates a [SolidAngle] instance from this value in Square Degrees (deg²).
  /// Alias for `deg2`.
  SolidAngle get squareDegrees => SolidAngle(toDouble(), SolidAngleUnit.squareDegree);

  /// Creates a [SolidAngle] instance from this value in Spat (sp).
  SolidAngle get sp => SolidAngle(toDouble(), SolidAngleUnit.spat);

  /// Creates a [SolidAngle] instance from this value in Spat (sp).
  /// Alias for `sp`.
  SolidAngle get spats => SolidAngle(toDouble(), SolidAngleUnit.spat);
}
