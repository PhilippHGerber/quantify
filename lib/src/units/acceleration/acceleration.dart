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
  @override
  double getValue(AccelerationUnit targetUnit) {
    if (targetUnit == unit) return value;
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [Acceleration] instance with the value converted to the [targetUnit].
  @override
  Acceleration convertTo(AccelerationUnit targetUnit) {
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return Acceleration(newValue, targetUnit);
  }

  @override
  int compareTo(Quantity<AccelerationUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this acceleration to another.
  Acceleration operator +(Acceleration other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Acceleration(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another acceleration from this one.
  Acceleration operator -(Acceleration other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Acceleration(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this acceleration by a scalar.
  Acceleration operator *(double scalar) {
    return Acceleration(value * scalar, unit);
  }

  /// Divides this acceleration by a scalar.
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
