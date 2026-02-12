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
  const Frequency(super._value, super._unit);

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
  ///
  /// This method uses pre-calculated direct conversion factors from the `FrequencyUnit`
  /// enum for efficiency, typically involving a single multiplication.
  ///
  /// Example:
  /// ```dart
  /// final f = Frequency(1.0, FrequencyUnit.kilohertz);
  /// final inHertz = f.getValue(FrequencyUnit.hertz); // 1000.0
  ///
  /// final f2 = Frequency(1000.0, FrequencyUnit.hertz);
  /// final inKilohertz = f2.getValue(FrequencyUnit.kilohertz); // 1.0
  /// ```
  @override
  double getValue(FrequencyUnit targetUnit) {
    // If the target unit is the same as the current unit, no conversion is needed.
    if (targetUnit == unit) return value;
    // Otherwise, multiply by the direct conversion factor.
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new [Frequency] instance with the value converted to the [targetUnit].
  ///
  /// This is useful for obtaining a new `Frequency` object in a different unit
  /// while preserving type safety and the immutability of `Quantity` objects.
  ///
  /// Example:
  /// ```dart
  /// final f = Frequency(1000.0, FrequencyUnit.hertz);
  /// final inKilohertz = f.convertTo(FrequencyUnit.kilohertz);
  /// // inKilohertz is Frequency(1.0, FrequencyUnit.kilohertz)
  /// print(inKilohertz); // Output: "1.0 kHz" (depending on toString formatting)
  /// ```
  @override
  Frequency convertTo(FrequencyUnit targetUnit) {
    // If the target unit is the same, return this instance (immutable optimization).
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return Frequency(newValue, targetUnit);
  }

  /// Compares this [Frequency] object to another [Quantity<FrequencyUnit>].
  ///
  /// Comparison is based on the physical magnitude of the frequencies.
  /// For an accurate comparison, this frequency's value is converted to the unit
  /// of the [other] frequency before their numerical values are compared.
  ///
  /// Returns:
  /// - A negative integer if this frequency is less than [other].
  /// - Zero if this frequency is equal in magnitude to [other].
  /// - A positive integer if this frequency is greater than [other].
  ///
  /// Example:
  /// ```dart
  /// final f1 = Frequency(1.0, FrequencyUnit.kilohertz);  // 1000 Hz
  /// final f2 = Frequency(1000.0, FrequencyUnit.hertz);   // 1000 Hz
  /// final f3 = Frequency(500.0, FrequencyUnit.hertz);
  ///
  /// print(f1.compareTo(f2)); // 0 (equal magnitude)
  /// print(f1.compareTo(f3)); // 1 (f1 > f3)
  /// print(f3.compareTo(f1)); // -1 (f3 < f1)
  /// ```
  @override
  int compareTo(Quantity<FrequencyUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this frequency to another.
  ///
  /// The [other] frequency is converted to the unit of this frequency before addition.
  /// The result is a new [Frequency] instance with the sum, expressed in the unit of this frequency.
  ///
  /// Example:
  /// ```dart
  /// final f1 = Frequency(500.0, FrequencyUnit.hertz);
  /// final f2 = Frequency(1.0, FrequencyUnit.kilohertz); // 1000 Hz
  /// final total = f1 + f2; // Result: Frequency(1500.0, FrequencyUnit.hertz)
  /// ```
  Frequency operator +(Frequency other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Frequency(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another frequency from this frequency.
  ///
  /// The [other] frequency is converted to the unit of this frequency before subtraction.
  /// The result is a new [Frequency] instance with the difference, expressed in the unit of this frequency.
  ///
  /// Example:
  /// ```dart
  /// final f1 = Frequency(1500.0, FrequencyUnit.hertz);
  /// final f2 = Frequency(1.0, FrequencyUnit.kilohertz); // 1000 Hz
  /// final diff = f1 - f2; // Result: Frequency(500.0, FrequencyUnit.hertz)
  /// ```
  Frequency operator -(Frequency other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Frequency(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this frequency by a scalar value (a dimensionless number).
  ///
  /// Returns a new [Frequency] instance with the scaled value, in the original unit of this frequency.
  ///
  /// Example:
  /// ```dart
  /// final f = Frequency(440.0, FrequencyUnit.hertz); // concert A
  /// final doubled = f * 2.0; // Result: Frequency(880.0, FrequencyUnit.hertz)
  /// ```
  Frequency operator *(double scalar) {
    return Frequency(value * scalar, unit);
  }

  /// Divides this frequency by a scalar value (a dimensionless number).
  ///
  /// Returns a new [Frequency] instance with the scaled value, in the original unit of this frequency.
  /// Throws [ArgumentError] if the [scalar] is zero.
  ///
  /// Example:
  /// ```dart
  /// final f = Frequency(880.0, FrequencyUnit.hertz);
  /// final halved = f / 2.0; // Result: Frequency(440.0, FrequencyUnit.hertz)
  /// ```
  Frequency operator /(double scalar) {
    if (scalar == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return Frequency(value / scalar, unit);
  }
}
