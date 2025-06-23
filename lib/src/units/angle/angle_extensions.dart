import 'angle.dart';
import 'angle_unit.dart';

/// Provides convenient access to [Angle] values in specific units.
extension AngleValueGetters on Angle {
  /// Returns the angle value in Radians (rad).
  double get inRadians => getValue(AngleUnit.radian);

  /// Returns the angle value in Degrees (°).
  double get inDegrees => getValue(AngleUnit.degree);

  /// Returns the angle value in Gradians (grad).
  double get inGradians => getValue(AngleUnit.gradian);

  /// Returns the angle value in Revolutions (rev).
  double get inRevolutions => getValue(AngleUnit.revolution);

  /// Returns the angle value in Arcminutes (').
  double get inArcminutes => getValue(AngleUnit.arcminute);

  /// Returns the angle value in Arcseconds (").
  double get inArcseconds => getValue(AngleUnit.arcsecond);

  /// Returns the angle value in Milliradians (mrad).
  double get inMilliradians => getValue(AngleUnit.milliradian);

  /// Returns an [Angle] object representing this angle in Radians (rad).
  Angle get asRadians => convertTo(AngleUnit.radian);

  /// Returns an [Angle] object representing this angle in Degrees (°).
  Angle get asDegrees => convertTo(AngleUnit.degree);

  /// Returns an [Angle] object representing this angle in Gradians (grad).
  Angle get asGradians => convertTo(AngleUnit.gradian);

  /// Returns an [Angle] object representing this angle in Revolutions (rev).
  Angle get asRevolutions => convertTo(AngleUnit.revolution);

  /// Returns an [Angle] object representing this angle in Arcminutes (').
  Angle get asArcminutes => convertTo(AngleUnit.arcminute);

  /// Returns an [Angle] object representing this angle in Arcseconds (").
  Angle get asArcseconds => convertTo(AngleUnit.arcsecond);

  /// Returns an [Angle] object representing this angle in Milliradians (mrad).
  Angle get asMilliradians => convertTo(AngleUnit.milliradian);
}

/// Provides convenient factory methods for creating [Angle] instances from [num].
extension AngleCreation on num {
  /// Creates an [Angle] instance from this numerical value in Radians (rad).
  Angle get radians => Angle(toDouble(), AngleUnit.radian);

  /// Creates an [Angle] instance from this numerical value in Degrees (°).
  Angle get degrees => Angle(toDouble(), AngleUnit.degree);

  /// Creates an [Angle] instance from this numerical value in Gradians (grad).
  Angle get gradians => Angle(toDouble(), AngleUnit.gradian);

  /// Creates an [Angle] instance from this numerical value in Gradians (grad).
  /// Alias for `gradians`.
  Angle get grad => Angle(toDouble(), AngleUnit.gradian);

  /// Creates an [Angle] instance from this numerical value in Revolutions (rev).
  Angle get revolutions => Angle(toDouble(), AngleUnit.revolution);

  /// Creates an [Angle] instance from this numerical value in Revolutions (rev).
  /// Alias for `revolutions`.
  Angle get rev => Angle(toDouble(), AngleUnit.revolution);

  /// Creates an [Angle] instance from this numerical value in Arcminutes (').
  Angle get arcminutes => Angle(toDouble(), AngleUnit.arcminute);

  /// Creates an [Angle] instance from this numerical value in Arcseconds (").
  Angle get arcseconds => Angle(toDouble(), AngleUnit.arcsecond);

  /// Creates an [Angle] instance from this numerical value in Milliradians (mrad).
  Angle get milliradians => Angle(toDouble(), AngleUnit.milliradian);

  /// Creates an [Angle] instance from this numerical value in Milliradians (mrad).
  /// Alias for `milliradians`.
  Angle get mrad => Angle(toDouble(), AngleUnit.milliradian);
}
