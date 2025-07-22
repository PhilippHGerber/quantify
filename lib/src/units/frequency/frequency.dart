import 'package:meta/meta.dart';

import '../../core/quantity.dart';
import '../time/time.dart';
import '../time/time_extensions.dart';
import '../time/time_unit.dart';
import 'frequency_unit.dart';

/// Represents a quantity of frequency.
///
/// Frequency is a derived quantity representing the number of occurrences of a
/// repeating event per unit of time. The SI derived unit is the Hertz (Hz),
/// defined as one cycle per second (s⁻¹).
@immutable
class Frequency extends Quantity<FrequencyUnit> {
  /// Creates a new `Frequency` with a given [value] and [unit].
  const Frequency(super.value, super.unit);

  // --- Dimensional Analysis ---

  /// Creates a `Frequency` instance from a `Time` duration representing the
  /// period of one cycle (f = 1/T).
  ///
  /// Throws an [ArgumentError] if the `time` is zero.
  ///
  /// Example:
  /// ```dart
  /// final period = 20.ms; // A 20 millisecond period
  /// final frequency = Frequency.from(period);
  /// print(frequency.inHertz); // Output: 50.0
  /// ```
  factory Frequency.from(Time time) {
    final seconds = time.inSeconds;
    if (seconds == 0) {
      throw ArgumentError('Time period cannot be zero when calculating frequency.');
    }
    return Frequency(1.0 / seconds, FrequencyUnit.hertz);
  }

  /// Calculates the time period for one cycle of this frequency (T = 1/f).
  ///
  /// Throws an [UnsupportedError] if the frequency is zero.
  /// The result is returned as a `Time` quantity in seconds.
  ///
  /// Example:
  /// ```dart
  /// final cpuClock = 4.2.ghz;
  /// final cycleTime = cpuClock.period;
  /// print(cycleTime.inNanoseconds); // Output: ~0.238
  /// ```
  Time get period {
    final hertz = getValue(FrequencyUnit.hertz);
    if (hertz == 0) {
      throw UnsupportedError('Cannot calculate period for zero frequency.');
    }
    return Time(1.0 / hertz, TimeUnit.second);
  }

  // --- Boilerplate ---

  /// Converts this frequency's value to the specified [targetUnit].
  @override
  double getValue(FrequencyUnit targetUnit) {
    if (targetUnit == unit) return value;
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [Frequency] instance with the value converted to the [targetUnit].
  @override
  Frequency convertTo(FrequencyUnit targetUnit) {
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return Frequency(newValue, targetUnit);
  }

  @override
  int compareTo(Quantity<FrequencyUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this frequency to another.
  Frequency operator +(Frequency other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Frequency(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another frequency from this one.
  Frequency operator -(Frequency other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Frequency(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this frequency by a scalar.
  Frequency operator *(double scalar) {
    return Frequency(value * scalar, unit);
  }

  /// Divides this frequency by a scalar.
  Frequency operator /(double scalar) {
    if (scalar == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return Frequency(value / scalar, unit);
  }
}
