import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'angle_factors.dart';

/// Represents units for a plane angle.
///
/// This enum implements the [LinearUnit] interface to provide conversion capabilities
/// and a display [symbol] for each angle unit. All conversion factors are
/// pre-calculated in the constructor relative to Radian (rad).
enum AngleUnit implements LinearUnit<AngleUnit> {
  /// Radian (rad), the SI-derived unit of angle. Used by `dart:math`.
  radian(1, 'rad'),

  /// Degree (°), the most common unit of angle. 360° in a full circle.
  degree(AngleFactors.radiansPerDegree, '°'),

  /// Gradian (grad/gon), a unit of angle where a right angle is 100 gradians.
  /// 400 grad in a full circle. Commonly used in surveying.
  gradian(AngleFactors.radiansPerGradian, 'grad'),

  /// Revolution (rev/turn), where 1 revolution is a full circle.
  revolution(AngleFactors.radiansPerRevolution, 'rev'),

  /// Arcminute ('), a unit of angle equal to 1/60 of a degree.
  /// Used in astronomy and navigation.
  arcminute(AngleFactors.radiansPerArcminute, "'"),

  /// Arcsecond ("), a unit of angle equal to 1/60 of an arcminute.
  /// Used for very precise angular measurements.
  arcsecond(AngleFactors.radiansPerArcsecond, '"'),

  /// Milliradian (mrad), equal to 0.001 radians.
  /// Used in optics and ballistics.
  milliradian(AngleFactors.radiansPerMilliradian, 'mrad');

  /// Constant constructor for enum members.
  ///
  /// [toRadianFactor] is the factor to convert from this unit to the base unit (Radian).
  /// [symbol] is the display symbol for the unit.
  ///
  /// The constructor pre-calculates all direct conversion factors
  /// from this unit to every other `AngleUnit`.
  const AngleUnit(double toRadianFactor, this.symbol)
      : _toRadianFactor = toRadianFactor,
        _factorToRadian = toRadianFactor / 1.0,
        _factorToDegree = toRadianFactor / AngleFactors.radiansPerDegree,
        _factorToGradian = toRadianFactor / AngleFactors.radiansPerGradian,
        _factorToRevolution = toRadianFactor / AngleFactors.radiansPerRevolution,
        _factorToArcminute = toRadianFactor / AngleFactors.radiansPerArcminute,
        _factorToArcsecond = toRadianFactor / AngleFactors.radiansPerArcsecond,
        _factorToMilliradian = toRadianFactor / AngleFactors.radiansPerMilliradian;

  // ignore: unused_field // The factor to convert from this unit to Radian.
  final double _toRadianFactor;

  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors from this unit to all others ---
  final double _factorToRadian;
  final double _factorToDegree;
  final double _factorToGradian;
  final double _factorToRevolution;
  final double _factorToArcminute;
  final double _factorToArcsecond;
  final double _factorToMilliradian;

  /// SI and unit symbols matched **strictly case-sensitive**.
  ///
  /// Used by `Angle.parser`.
  @internal
  static const Map<String, AngleUnit> symbolAliases = {
    // radian
    'rad': AngleUnit.radian,
    // degree
    '°': AngleUnit.degree,
    'deg': AngleUnit.degree,
    // gradian
    'grad': AngleUnit.gradian,
    'gon': AngleUnit.gradian,
    // revolution
    'rev': AngleUnit.revolution,
    'turn': AngleUnit.revolution,
    // arcminute
    "'": AngleUnit.arcminute,
    'arcmin': AngleUnit.arcminute,
    // arcsecond
    '"': AngleUnit.arcsecond,
    'arcsec': AngleUnit.arcsecond,
    // milliradian
    'mrad': AngleUnit.milliradian,
  };

  /// Full word-form names matched **case-insensitively**.
  ///
  /// Used by `Angle.parser`.
  @internal
  static const Map<String, AngleUnit> nameAliases = {
    // radian
    'radian': AngleUnit.radian,
    'radians': AngleUnit.radian,
    'rad': AngleUnit.radian,
    // degree
    'degree': AngleUnit.degree,
    'degrees': AngleUnit.degree,
    'deg': AngleUnit.degree,
    // gradian
    'gradian': AngleUnit.gradian,
    'gradians': AngleUnit.gradian,
    'grad': AngleUnit.gradian,
    'gon': AngleUnit.gradian,
    // revolution
    'revolution': AngleUnit.revolution,
    'revolutions': AngleUnit.revolution,
    'rev': AngleUnit.revolution,
    'turn': AngleUnit.revolution,
    'turns': AngleUnit.revolution,
    // arcminute
    'arcminute': AngleUnit.arcminute,
    'arcminutes': AngleUnit.arcminute,
    // arcsecond
    'arcsecond': AngleUnit.arcsecond,
    'arcseconds': AngleUnit.arcsecond,
    // milliradian
    'milliradian': AngleUnit.milliradian,
    'milliradians': AngleUnit.milliradian,
    'mrad': AngleUnit.milliradian,
  };

  /// Returns the direct conversion factor to convert a value from this [AngleUnit]
  /// to the [targetUnit].
  @override
  @internal
  double factorTo(AngleUnit targetUnit) {
    switch (targetUnit) {
      case AngleUnit.radian:
        return _factorToRadian;
      case AngleUnit.degree:
        return _factorToDegree;
      case AngleUnit.gradian:
        return _factorToGradian;
      case AngleUnit.revolution:
        return _factorToRevolution;
      case AngleUnit.arcminute:
        return _factorToArcminute;
      case AngleUnit.arcsecond:
        return _factorToArcsecond;
      case AngleUnit.milliradian:
        return _factorToMilliradian;
    }
  }
}
