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
  const Speed(super._value, super._unit);

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
  ///
  /// This method uses pre-calculated direct conversion factors from the `SpeedUnit`
  /// enum for efficiency, typically involving a single multiplication.
  ///
  /// Example:
  /// ```dart
  /// final s = Speed(1.0, SpeedUnit.meterPerSecond);
  /// final inKmh = s.getValue(SpeedUnit.kilometerPerHour); // 3.6
  ///
  /// final s2 = Speed(36.0, SpeedUnit.kilometerPerHour);
  /// final inMps = s2.getValue(SpeedUnit.meterPerSecond); // 10.0
  /// ```
  @override
  double getValue(SpeedUnit targetUnit) {
    // If the target unit is the same as the current unit, no conversion is needed.
    if (targetUnit == unit) return value;
    // Otherwise, multiply by the direct conversion factor.
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [Speed] instance with the value converted to the [targetUnit].
  ///
  /// This is useful for obtaining a new `Speed` object in a different unit
  /// while preserving type safety and the immutability of `Quantity` objects.
  ///
  /// Example:
  /// ```dart
  /// final s = Speed(36.0, SpeedUnit.kilometerPerHour);
  /// final inMps = s.convertTo(SpeedUnit.meterPerSecond);
  /// // inMps is Speed(10.0, SpeedUnit.meterPerSecond)
  /// print(inMps); // Output: "10.0 m/s" (depending on toString formatting)
  /// ```
  @override
  Speed convertTo(SpeedUnit targetUnit) {
    // If the target unit is the same, return this instance (immutable optimization).
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return Speed(newValue, targetUnit);
  }

  /// Compares this [Speed] object to another [Quantity<SpeedUnit>].
  ///
  /// Comparison is based on the physical magnitude of the speeds.
  /// For an accurate comparison, this speed's value is converted to the unit
  /// of the [other] speed before their numerical values are compared.
  ///
  /// Returns:
  /// - A negative integer if this speed is less than [other].
  /// - Zero if this speed is equal in magnitude to [other].
  /// - A positive integer if this speed is greater than [other].
  ///
  /// Example:
  /// ```dart
  /// final s1 = Speed(100.0, SpeedUnit.kilometerPerHour); // ~27.78 m/s
  /// final s2 = Speed(60.0, SpeedUnit.milePerHour);       // ~26.82 m/s
  /// final s3 = Speed(10.0, SpeedUnit.meterPerSecond);    // 36.0 km/h
  ///
  /// print(s1.compareTo(s3)); // 1 (s1 > s3, since 100 km/h > 36 km/h)
  /// print(s2.compareTo(s1)); // -1 (s2 < s1)
  /// print(s1.compareTo(Speed(100.0, SpeedUnit.kilometerPerHour))); // 0
  /// ```
  @override
  int compareTo(Quantity<SpeedUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this speed to another.
  ///
  /// The [other] speed is converted to the unit of this speed before addition.
  /// The result is a new [Speed] instance with the sum, expressed in the unit of this speed.
  ///
  /// Example:
  /// ```dart
  /// final s1 = Speed(10.0, SpeedUnit.meterPerSecond); // 36 km/h
  /// final s2 = Speed(36.0, SpeedUnit.kilometerPerHour); // 10 m/s
  /// final total = s1 + s2; // Result: Speed(20.0, SpeedUnit.meterPerSecond)
  /// ```
  Speed operator +(Speed other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Speed(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another speed from this speed.
  ///
  /// The [other] speed is converted to the unit of this speed before subtraction.
  /// The result is a new [Speed] instance with the difference, expressed in the unit of this speed.
  ///
  /// Example:
  /// ```dart
  /// final s1 = Speed(30.0, SpeedUnit.meterPerSecond);
  /// final s2 = Speed(36.0, SpeedUnit.kilometerPerHour); // 10 m/s
  /// final diff = s1 - s2; // Result: Speed(20.0, SpeedUnit.meterPerSecond)
  /// ```
  Speed operator -(Speed other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Speed(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this speed by a scalar value (a dimensionless number).
  ///
  /// Returns a new [Speed] instance with the scaled value, in the original unit of this speed.
  ///
  /// Example:
  /// ```dart
  /// final s = Speed(10.0, SpeedUnit.meterPerSecond);
  /// final scaled = s * 3.0; // Result: Speed(30.0, SpeedUnit.meterPerSecond)
  /// ```
  Speed operator *(double scalar) {
    return Speed(value * scalar, unit);
  }

  /// Divides this speed by a scalar value (a dimensionless number).
  ///
  /// Returns a new [Speed] instance with the scaled value, in the original unit of this speed.
  /// Throws [ArgumentError] if the [scalar] is zero.
  ///
  /// Example:
  /// ```dart
  /// final s = Speed(30.0, SpeedUnit.meterPerSecond);
  /// final scaled = s / 3.0; // Result: Speed(10.0, SpeedUnit.meterPerSecond)
  /// ```
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
