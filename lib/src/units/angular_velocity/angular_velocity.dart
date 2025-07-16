import 'package:meta/meta.dart';

import '../../core/quantity.dart';
import '../angle/angle.dart';
import '../angle/angle_unit.dart';
import '../time/time.dart';
import '../time/time_extensions.dart';
import 'angular_velocity_unit.dart';

/// Represents a quantity of angular velocity (or rotational speed).
///
/// Angular velocity is a derived quantity representing the rate of change of
/// an angle over time. The SI unit is radians per second (rad/s).
@immutable
class AngularVelocity extends Quantity<AngularVelocityUnit> {
  /// Creates a new `AngularVelocity` with a given [value] and [unit].
  const AngularVelocity(super.value, super.unit);

  /// Converts this angular velocity's value to the specified [targetUnit].
  @override
  double getValue(AngularVelocityUnit targetUnit) {
    if (targetUnit == unit) return value;
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [AngularVelocity] instance with the value converted to the [targetUnit].
  @override
  AngularVelocity convertTo(AngularVelocityUnit targetUnit) {
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return AngularVelocity(newValue, targetUnit);
  }

  @override
  int compareTo(Quantity<AngularVelocityUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this angular velocity to another.
  AngularVelocity operator +(AngularVelocity other) {
    final otherValueInThisUnit = other.getValue(unit);
    return AngularVelocity(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another angular velocity from this one.
  AngularVelocity operator -(AngularVelocity other) {
    final otherValueInThisUnit = other.getValue(unit);
    return AngularVelocity(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this angular velocity by a scalar.
  AngularVelocity operator *(double scalar) {
    return AngularVelocity(value * scalar, unit);
  }

  /// Divides this angular velocity by a scalar.
  AngularVelocity operator /(double scalar) {
    if (scalar == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return AngularVelocity(value / scalar, unit);
  }

  // --- Dimensional Analysis: Methode statt überladenem Operator ---

  /// Calculates the total [Angle] of rotation over a given [Time] duration.
  ///
  /// `Angle = Angular Velocity × Time`
  ///
  /// The calculation is performed in the base units (rad/s and s) to ensure
  /// correctness, and the result is returned as an [Angle] in radians.
  ///
  /// Example:
  /// ```dart
  /// final speed = 3000.rpm;
  /// final duration = 2.0.seconds;
  /// final totalAngle = speed.totalAngleOver(duration);
  /// print(totalAngle.inRevolutions); // Output: 100.0
  /// ```
  Angle totalAngleOver(Time time) {
    final valueInRadPerSec = getValue(AngularVelocityUnit.radianPerSecond);
    final timeInSeconds = time.inSeconds;
    final resultingAngleInRadians = valueInRadPerSec * timeInSeconds;
    return Angle(resultingAngleInRadians, AngleUnit.radian);
  }
}
