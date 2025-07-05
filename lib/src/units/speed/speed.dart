import 'package:meta/meta.dart';

import '../../../length.dart';
import '../time/time.dart';
import '../time/time_extensions.dart';
import 'speed_unit.dart';

/// Represents a quantity of speed (or velocity).
///
/// Speed is a derived quantity representing the rate of change of position
/// over time. The SI derived unit is Meter per Second (m/s).
@immutable
class Speed extends Quantity<SpeedUnit> {
  /// Creates a new `Speed` with a given [value] and [unit].
  const Speed(super.value, super.unit);

  /// Creates a `Speed` instance from a `Length` and a `Time`.
  ///
  /// This factory method performs the dimensional calculation `Speed = Length / Time`.
  /// It converts the inputs to their base SI units (meters and seconds) for correctness.
  /// Throws an [ArgumentError] if the `time` is zero.
  ///
  /// Example:
  /// ```dart
  /// final distance = 100.m;
  /// final duration = 10.s;
  /// final speed = Speed.from(distance, duration); // Results in Speed(10.0, SpeedUnit.meterPerSecond)
  /// ```
  factory Speed.from(Length distance, Time time) {
    final meters = distance.inM;
    final seconds = time.inSeconds;
    if (seconds == 0) {
      throw ArgumentError('Time cannot be zero when calculating speed.');
    }
    return Speed(meters / seconds, SpeedUnit.meterPerSecond);
  }

  /// Converts this speed's value to the specified [targetUnit].
  @override
  double getValue(SpeedUnit targetUnit) {
    if (targetUnit == unit) return value;
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [Speed] instance with the value converted to the [targetUnit].
  @override
  Speed convertTo(SpeedUnit targetUnit) {
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return Speed(newValue, targetUnit);
  }

  /// Compares this [Speed] object to another [Quantity<SpeedUnit>].
  @override
  int compareTo(Quantity<SpeedUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this speed to another.
  Speed operator +(Speed other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Speed(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another speed from this one.
  Speed operator -(Speed other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Speed(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this speed by a scalar.
  Speed operator *(double scalar) {
    return Speed(value * scalar, unit);
  }

  /// Divides this speed by a scalar.
  Speed operator /(double scalar) {
    if (scalar == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return Speed(value / scalar, unit);
  }

  // --- Dimensional Analysis ---

  /// Calculates the total [Length] traveled over a given [Time] duration.
  ///
  /// This method performs the dimensional calculation `Length = Speed × Time`.
  /// The calculation is performed in the base units (m/s and s) to ensure
  /// correctness, and the result is returned as a `Length` in meters.
  ///
  /// Example:
  /// ```dart
  /// final carSpeed = 60.kmh;
  /// final travelTime = 2.h;
  /// final distance = carSpeed.distanceOver(travelTime);
  /// print(distance.inKm); // Output: 120.0
  /// ```
  Length distanceOver(Time duration) {
    final valueInMps = getValue(SpeedUnit.meterPerSecond);
    final timeInSeconds = duration.inSeconds;
    final resultingDistanceInMeters = valueInMps * timeInSeconds;
    return Length(resultingDistanceInMeters, LengthUnit.meter);
  }
}
