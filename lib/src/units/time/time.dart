import 'package:meta/meta.dart';

import '../../core/quantity.dart';
import 'time_unit.dart';

/// Represents a quantity of time (duration).
@immutable
class Time extends Quantity<TimeUnit> {
  /// Creates a new Time quantity with the given [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final duration = Time(120.0, TimeUnit.second);
  /// final meetingLength = Time(1.5, TimeUnit.hour);
  /// ```
  const Time(super.value, super.unit);

  /// Converts this time's value to the specified [targetUnit].
  @override
  double getValue(TimeUnit targetUnit) {
    if (targetUnit == unit) return value;
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [Time] instance with the value converted to the [targetUnit].
  ///
  /// Example:
  /// ```dart
  /// final twoMinutes = Time(2.0, TimeUnit.minute);
  /// final inSeconds = twoMinutes.convertTo(TimeUnit.second); // Time(120.0, TimeUnit.second)
  /// print(inSeconds.value); // 120.0
  /// ```
  @override
  Time convertTo(TimeUnit targetUnit) {
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return Time(newValue, targetUnit);
  }

  /// Compares this [Time] object to another [Quantity<TimeUnit>].
  ///
  /// Comparison is based on the physical magnitude of the durations.
  @override
  int compareTo(Quantity<TimeUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }
}
