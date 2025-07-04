import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'angular_velocity_factors.dart';

/// Represents units for angular velocity.
///
/// This enum implements the [Unit] interface to provide conversion capabilities
/// and a display [symbol] for each angular velocity unit. All conversion factors
/// are pre-calculated in the constructor relative to Radian per Second (rad/s).
enum AngularVelocityUnit implements Unit<AngularVelocityUnit> {
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
