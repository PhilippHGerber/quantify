import 'package:meta/meta.dart';

import '../../core/quantity.dart';
import '../speed/speed.dart';
import '../speed/speed_extensions.dart';
import '../speed/speed_unit.dart';
import '../time/time.dart';
import '../time/time_extensions.dart';
import 'acceleration_unit.dart';

/// Represents a quantity of acceleration.
///
/// Acceleration is a derived quantity representing the rate of change of
/// velocity over time. The SI derived unit is Meter per Second Squared (m/s²).
@immutable
class Acceleration extends Quantity<AccelerationUnit> {
  /// Creates a new `Acceleration` with a given [value] and [unit].
  const Acceleration(super._value, super._unit);

  /// Creates an `Acceleration` instance from a change in `Speed` over a `Time` duration.
  ///
  /// This factory performs the dimensional calculation `Acceleration = ΔSpeed / Time`.
  /// It converts the inputs to their base SI units for correctness.
  /// Throws an [ArgumentError] if the `time` is zero.
  ///
  /// Example:
  /// ```dart
  /// final speedChange = 27.8.mps; // approx 100 km/h
  /// final duration = 5.s;
  /// final carAcceleration = Acceleration.from(speedChange, duration);
  /// print(carAcceleration.inMetersPerSecondSquared); // Output: 5.56
  /// ```
  factory Acceleration.from(Speed speed, Time time) {
    final mps = speed.inMps;
    final seconds = time.inSeconds;
    if (seconds == 0) {
      throw ArgumentError('Time cannot be zero when calculating acceleration.');
    }
    return Acceleration(mps / seconds, AccelerationUnit.meterPerSecondSquared);
  }

  /// Converts this acceleration's value to the specified [targetUnit].
  ///
  /// This method uses pre-calculated direct conversion factors from the `AccelerationUnit`
  /// enum for efficiency, typically involving a single multiplication.
  ///
  /// Example:
  /// ```dart
  /// final a = Acceleration(9.80665, AccelerationUnit.meterPerSecondSquared); // 1 g
  /// final inG = a.getValue(AccelerationUnit.standardGravity); // 1.0
  ///
  /// final a2 = Acceleration(2.0, AccelerationUnit.standardGravity);
  /// final inMpss = a2.getValue(AccelerationUnit.meterPerSecondSquared); // ~19.613
  /// ```
  @override
  double getValue(AccelerationUnit targetUnit) {
    // If the target unit is the same as the current unit, no conversion is needed.
    if (targetUnit == unit) return value;
    // Otherwise, multiply by the direct conversion factor.
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [Acceleration] instance with the value converted to the [targetUnit].
  ///
  /// This is useful for obtaining a new `Acceleration` object in a different unit
  /// while preserving type safety and the immutability of `Quantity` objects.
  ///
  /// Example:
  /// ```dart
  /// final a = Acceleration(9.80665, AccelerationUnit.meterPerSecondSquared);
  /// final inG = a.convertTo(AccelerationUnit.standardGravity);
  /// // inG is Acceleration(1.0, AccelerationUnit.standardGravity)
  /// print(inG); // Output: "1.0 g" (depending on toString formatting)
  /// ```
  @override
  Acceleration convertTo(AccelerationUnit targetUnit) {
    // If the target unit is the same, return this instance (immutable optimization).
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return Acceleration(newValue, targetUnit);
  }

  /// Compares this [Acceleration] object to another [Quantity<AccelerationUnit>].
  ///
  /// Comparison is based on the physical magnitude of the accelerations.
  /// For an accurate comparison, this acceleration's value is converted to the unit
  /// of the [other] acceleration before their numerical values are compared.
  ///
  /// Returns:
  /// - A negative integer if this acceleration is less than [other].
  /// - Zero if this acceleration is equal in magnitude to [other].
  /// - A positive integer if this acceleration is greater than [other].
  ///
  /// Example:
  /// ```dart
  /// final a1 = Acceleration(9.80665, AccelerationUnit.meterPerSecondSquared); // 1 g
  /// final a2 = Acceleration(1.0, AccelerationUnit.standardGravity);           // 1 g
  /// final a3 = Acceleration(5.0, AccelerationUnit.meterPerSecondSquared);
  ///
  /// print(a1.compareTo(a2)); // 0 (equal magnitude)
  /// print(a1.compareTo(a3)); // 1 (a1 > a3)
  /// print(a3.compareTo(a1)); // -1 (a3 < a1)
  /// ```
  @override
  int compareTo(Quantity<AccelerationUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this acceleration to another.
  ///
  /// The [other] acceleration is converted to the unit of this acceleration before addition.
  /// The result is a new [Acceleration] instance with the sum, expressed in the unit of this acceleration.
  ///
  /// Example:
  /// ```dart
  /// final a1 = Acceleration(5.0, AccelerationUnit.meterPerSecondSquared);
  /// final a2 = Acceleration(1.0, AccelerationUnit.standardGravity); // ~9.80665 m/s²
  /// final total = a1 + a2; // Result: Acceleration(~14.807, AccelerationUnit.meterPerSecondSquared)
  /// ```
  Acceleration operator +(Acceleration other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Acceleration(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another acceleration from this acceleration.
  ///
  /// The [other] acceleration is converted to the unit of this acceleration before subtraction.
  /// The result is a new [Acceleration] instance with the difference, expressed in the unit of this acceleration.
  ///
  /// Example:
  /// ```dart
  /// final a1 = Acceleration(20.0, AccelerationUnit.meterPerSecondSquared);
  /// final a2 = Acceleration(1.0, AccelerationUnit.standardGravity); // ~9.80665 m/s²
  /// final net = a1 - a2; // Result: Acceleration(~10.19, AccelerationUnit.meterPerSecondSquared)
  /// ```
  Acceleration operator -(Acceleration other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Acceleration(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this acceleration by a scalar value (a dimensionless number).
  ///
  /// Returns a new [Acceleration] instance with the scaled value, in the original unit of this acceleration.
  ///
  /// Example:
  /// ```dart
  /// final a = Acceleration(3.0, AccelerationUnit.meterPerSecondSquared);
  /// final doubled = a * 2.0; // Result: Acceleration(6.0, AccelerationUnit.meterPerSecondSquared)
  /// ```
  Acceleration operator *(double scalar) {
    return Acceleration(value * scalar, unit);
  }

  /// Divides this acceleration by a scalar value (a dimensionless number).
  ///
  /// Returns a new [Acceleration] instance with the scaled value, in the original unit of this acceleration.
  /// Throws [ArgumentError] if the [scalar] is zero.
  ///
  /// Example:
  /// ```dart
  /// final a = Acceleration(6.0, AccelerationUnit.meterPerSecondSquared);
  /// final scaled = a / 3.0; // Result: Acceleration(2.0, AccelerationUnit.meterPerSecondSquared)
  /// ```
  Acceleration operator /(double scalar) {
    if (scalar == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return Acceleration(value / scalar, unit);
  }

  // --- Dimensional Analysis ---

  /// Calculates the change in [Speed] over a given [Time] duration.
  ///
  /// This method performs the dimensional calculation `ΔSpeed = Acceleration × Time`.
  /// The calculation is performed in the base units (m/s² and s) to ensure
  /// correctness, and the result is returned as a `Speed` in m/s.
  ///
  /// Example:
  /// ```dart
  /// final gravity = 1.gravity; // 9.80665 m/s²
  /// final fallTime = 3.s;
  /// final finalSpeed = gravity.speedGainedOver(fallTime);
  /// print(finalSpeed.inMps); // Output: ~29.42
  /// ```
  Speed speedGainedOver(Time duration) {
    final valueInMpss = getValue(AccelerationUnit.meterPerSecondSquared);
    final timeInSeconds = duration.inSeconds;
    final resultingSpeedInMps = valueInMpss * timeInSeconds;
    return Speed(resultingSpeedInMps, SpeedUnit.meterPerSecond);
  }
}
