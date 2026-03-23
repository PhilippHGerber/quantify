import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'angular_velocity_factors.dart';

/// Represents units for angular velocity.
///
/// This enum implements the [LinearUnit] interface to provide conversion capabilities
/// and a display [symbol] for each angular velocity unit. All conversion factors
/// are pre-calculated in the constructor relative to Radian per Second (rad/s).
enum AngularVelocityUnit implements LinearUnit<AngularVelocityUnit> {
  /// Radian per second (rad/s), the SI-derived unit of angular velocity.
  radianPerSecond(1, 'rad/s'),

  /// Degree per second (°/s).
  degreePerSecond(AngularVelocityFactors.radPSecPerDegPSec, '°/s'),

  /// Revolution per minute (rpm), a common unit for rotational speed.
  revolutionPerMinute(AngularVelocityFactors.radPSecPerRevPMin, 'rpm'),

  /// Revolution per second (rps).
  revolutionPerSecond(AngularVelocityFactors.radPSecPerRevPSec, 'rps');

  /// Constant constructor for enum members.
  const AngularVelocityUnit(double toBaseFactor, this.symbol)
      : _toRadPerSecFactor = toBaseFactor,
        _factorToRadianPerSecond = toBaseFactor / 1.0,
        _factorToDegreePerSecond = toBaseFactor / AngularVelocityFactors.radPSecPerDegPSec,
        _factorToRevolutionPerMinute = toBaseFactor / AngularVelocityFactors.radPSecPerRevPMin,
        _factorToRevolutionPerSecond = toBaseFactor / AngularVelocityFactors.radPSecPerRevPSec;

  /// SI and unit symbols matched **strictly case-sensitive**.
  static const Map<String, AngularVelocityUnit> symbolAliases = {
    'rad/s': radianPerSecond,
    '°/s': degreePerSecond,
    'rpm': revolutionPerMinute,
    'rps': revolutionPerSecond,
  };

  /// Full word-form names and non-SI abbreviations matched **case-insensitively**.
  static const Map<String, AngularVelocityUnit> nameAliases = {
    'radian per second': radianPerSecond,
    'radianpersecond': radianPerSecond,
    'rad per s': radianPerSecond,
    'radpers': radianPerSecond,
    'degree per second': degreePerSecond,
    'degreepersecond': degreePerSecond,
    'deg per s': degreePerSecond,
    'degpers': degreePerSecond,
    'revolution per minute': revolutionPerMinute,
    'revolutionperminute': revolutionPerMinute,
    'rev per min': revolutionPerMinute,
    'revpermin': revolutionPerMinute,
    'rpm': revolutionPerMinute,
    'revolution per second': revolutionPerSecond,
    'revolutionpersecond': revolutionPerSecond,
    'rev per s': revolutionPerSecond,
    'revpers': revolutionPerSecond,
    'rps': revolutionPerSecond,
  };

  // ignore: unused_field // The factor to convert from this unit to Radian per Second.
  final double _toRadPerSecFactor;

  @override
  final String symbol;

  // --- Pre-calculated direct conversion factors ---
  final double _factorToRadianPerSecond;
  final double _factorToDegreePerSecond;
  final double _factorToRevolutionPerMinute;
  final double _factorToRevolutionPerSecond;

  @override
  @internal
  double factorTo(AngularVelocityUnit targetUnit) {
    switch (targetUnit) {
      case AngularVelocityUnit.radianPerSecond:
        return _factorToRadianPerSecond;
      case AngularVelocityUnit.degreePerSecond:
        return _factorToDegreePerSecond;
      case AngularVelocityUnit.revolutionPerMinute:
        return _factorToRevolutionPerMinute;
      case AngularVelocityUnit.revolutionPerSecond:
        return _factorToRevolutionPerSecond;
    }
  }
}
