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
  const AngularVelocity(super._value, super._unit);

  /// Converts this angular velocity's value to the specified [targetUnit].
  ///
  /// This method uses pre-calculated direct conversion factors from the `AngularVelocityUnit`
  /// enum for efficiency, typically involving a single multiplication.
  ///
  /// Example:
  /// ```dart
  /// final av = AngularVelocity(1.0, AngularVelocityUnit.revolutionPerSecond);
  /// final inRpm = av.getValue(AngularVelocityUnit.revolutionPerMinute); // 60.0
  ///
  /// final av2 = AngularVelocity(3000.0, AngularVelocityUnit.revolutionPerMinute);
  /// final inRps = av2.getValue(AngularVelocityUnit.revolutionPerSecond); // 50.0
  /// ```
  @override
  double getValue(AngularVelocityUnit targetUnit) {
    // If the target unit is the same as the current unit, no conversion is needed.
    if (targetUnit == unit) return value;
    // Otherwise, multiply by the direct conversion factor.
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [AngularVelocity] instance with the value converted to the [targetUnit].
  ///
  /// This is useful for obtaining a new `AngularVelocity` object in a different unit
  /// while preserving type safety and the immutability of `Quantity` objects.
  ///
  /// Example:
  /// ```dart
  /// final av = AngularVelocity(60.0, AngularVelocityUnit.revolutionPerMinute);
  /// final inRps = av.convertTo(AngularVelocityUnit.revolutionPerSecond);
  /// // inRps is AngularVelocity(1.0, AngularVelocityUnit.revolutionPerSecond)
  /// print(inRps); // Output: "1.0 rev/s" (depending on toString formatting)
  /// ```
  @override
  AngularVelocity convertTo(AngularVelocityUnit targetUnit) {
    // If the target unit is the same, return this instance (immutable optimization).
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return AngularVelocity(newValue, targetUnit);
  }

  /// Compares this [AngularVelocity] object to another [Quantity<AngularVelocityUnit>].
  ///
  /// Comparison is based on the physical magnitude of the angular velocities.
  /// For an accurate comparison, this angular velocity's value is converted to the unit
  /// of the [other] angular velocity before their numerical values are compared.
  ///
  /// Returns:
  /// - A negative integer if this angular velocity is less than [other].
  /// - Zero if this angular velocity is equal in magnitude to [other].
  /// - A positive integer if this angular velocity is greater than [other].
  ///
  /// Example:
  /// ```dart
  /// final av1 = AngularVelocity(1.0, AngularVelocityUnit.revolutionPerSecond); // 2π rad/s
  /// final av2 = AngularVelocity(60.0, AngularVelocityUnit.revolutionPerMinute); // 1 rev/s
  /// final av3 = AngularVelocity(1.0, AngularVelocityUnit.radianPerSecond);
  ///
  /// print(av1.compareTo(av2)); // 0 (equal magnitude)
  /// print(av1.compareTo(av3)); // 1 (av1 > av3)
  /// print(av3.compareTo(av1)); // -1 (av3 < av1)
  /// ```
  @override
  int compareTo(Quantity<AngularVelocityUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this angular velocity to another.
  ///
  /// The [other] angular velocity is converted to the unit of this angular velocity before addition.
  /// The result is a new [AngularVelocity] instance with the sum, expressed in the unit of this angular velocity.
  ///
  /// Example:
  /// ```dart
  /// final av1 = AngularVelocity(2.0, AngularVelocityUnit.revolutionPerSecond); // 120 rpm
  /// final av2 = AngularVelocity(60.0, AngularVelocityUnit.revolutionPerMinute); // 1 rev/s
  /// final total = av1 + av2; // Result: AngularVelocity(3.0, AngularVelocityUnit.revolutionPerSecond)
  /// ```
  AngularVelocity operator +(AngularVelocity other) {
    final otherValueInThisUnit = other.getValue(unit);
    return AngularVelocity(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another angular velocity from this angular velocity.
  ///
  /// The [other] angular velocity is converted to the unit of this angular velocity before subtraction.
  /// The result is a new [AngularVelocity] instance with the difference, expressed in the unit of this angular velocity.
  ///
  /// Example:
  /// ```dart
  /// final av1 = AngularVelocity(3.0, AngularVelocityUnit.revolutionPerSecond); // 180 rpm
  /// final av2 = AngularVelocity(60.0, AngularVelocityUnit.revolutionPerMinute); // 1 rev/s
  /// final diff = av1 - av2; // Result: AngularVelocity(2.0, AngularVelocityUnit.revolutionPerSecond)
  /// ```
  AngularVelocity operator -(AngularVelocity other) {
    final otherValueInThisUnit = other.getValue(unit);
    return AngularVelocity(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this angular velocity by a scalar value (a dimensionless number).
  ///
  /// Returns a new [AngularVelocity] instance with the scaled value, in the original unit of this angular velocity.
  ///
  /// Example:
  /// ```dart
  /// final av = AngularVelocity(100.0, AngularVelocityUnit.revolutionPerMinute);
  /// final doubled = av * 2.0; // Result: AngularVelocity(200.0, AngularVelocityUnit.revolutionPerMinute)
  /// ```
  AngularVelocity operator *(double scalar) {
    return AngularVelocity(value * scalar, unit);
  }

  /// Divides this angular velocity by a scalar value (a dimensionless number).
  ///
  /// Returns a new [AngularVelocity] instance with the scaled value, in the original unit of this angular velocity.
  /// Throws [ArgumentError] if the [scalar] is zero.
  ///
  /// Example:
  /// ```dart
  /// final av = AngularVelocity(200.0, AngularVelocityUnit.revolutionPerMinute);
  /// final halved = av / 2.0; // Result: AngularVelocity(100.0, AngularVelocityUnit.revolutionPerMinute)
  /// ```
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
