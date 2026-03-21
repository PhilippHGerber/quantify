import 'package:meta/meta.dart';

import '../../../quantify.dart' show QuantityParseException;
import '../../core/quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parse_exception.dart' show QuantityParseException;
import '../../core/quantity_parser.dart';
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
  const Time(super._value, super._unit);

  /// The parser instance used to convert strings into [Time] objects.
  ///
  /// The parser supports all standard units and handles both case-sensitive SI
  /// symbols (like `Ms` vs `ms`) and case-insensitive unit names.
  ///
  /// Create isolated parser variants to support custom or localized aliases:
  /// ```dart
  /// final customParser = Time.parser.copyWithAliases(
  ///   extraNameAliases: {'hora': TimeUnit.hour},
  /// );
  /// final custom = customParser.parse('2 hora');
  /// ```
  static final QuantityParser<TimeUnit, Time> parser = QuantityParser<TimeUnit, Time>(
    symbolAliases: TimeUnit.symbolAliases,
    nameAliases: TimeUnit.nameAliases,
    factory: Time.new,
  );

  /// Parses a string representation of a time duration into a [Time] object.
  ///
  /// The [input] string should follow the format `"<number> <unit>"`, where the
  /// space between the number and unit is optional.
  ///
  /// - **SI Prefixes**: Strictly case-sensitive (`10 ms` is milliseconds,
  ///   `10 Ms` is megaseconds).
  /// - **Common Units**: Case-insensitive (`1 hour`, `1 HOUR`, and `1 Hour`
  ///   all parse correctly).
  ///
  /// By default, [formats] uses `[QuantityFormat.invariant]` which accepts
  /// period as decimal separator and ignores visual grouping separators
  /// (space, NBSP, apostrophe). To parse locale-specific formats, provide
  /// custom [QuantityFormat] instances.
  ///
  /// Throws [QuantityParseException] if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// final t1 = Time.parse('30 min');   // 30 minutes
  /// final t2 = Time.parse('1.5 h');    // 1.5 hours
  /// final t3 = Time.parse('100ms');    // 100 milliseconds (no space)
  /// ```
  static Time parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Attempts to parse a string representation of time. Returns `null` if parsing fails.
  ///
  /// See [parse] for format details.
  ///
  /// Example:
  /// ```dart
  /// final valid = Time.tryParse('2 hours');   // Time(2.0, TimeUnit.hour)
  /// final invalid = Time.tryParse('invalid'); // null
  /// ```
  static Time? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }

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
  /// For an accurate comparison, this time's value is converted to the unit
  /// of the [other] time before their numerical values are compared.
  ///
  /// Returns:
  /// - A negative integer if this duration is less than [other].
  /// - Zero if this duration is equal in magnitude to [other].
  /// - A positive integer if this duration is greater than [other].
  ///
  /// Example:
  /// ```dart
  /// final t1 = Time(1.0, TimeUnit.minute);   // 60 s
  /// final t2 = Time(60.0, TimeUnit.second);  // 60 s
  /// final t3 = Time(30.0, TimeUnit.second);
  ///
  /// print(t1.compareTo(t2)); // 0 (equal magnitude)
  /// print(t1.compareTo(t3)); // 1 (t1 > t3)
  /// print(t3.compareTo(t1)); // -1 (t3 < t1)
  /// ```
  @override
  int compareTo(Quantity<TimeUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  // --- Arithmetic Operators ---

  /// Adds this time duration to another time duration.
  /// The [other] time is converted to the unit of this time before addition.
  /// Returns a new [Time] instance with the result in the unit of this time.
  Time operator +(Time other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Time(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another time duration from this time duration.
  /// The [other] time is converted to the unit of this time before subtraction.
  /// Returns a new [Time] instance with the result in the unit of this time.
  Time operator -(Time other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Time(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this time duration by a scalar value.
  /// Returns a new [Time] instance with the scaled value in the original unit.
  Time operator *(double scalar) {
    return Time(value * scalar, unit);
  }

  /// Divides this time duration by a scalar value.
  /// Returns a new [Time] instance with the scaled value in the original unit.
  /// Throws [ArgumentError] if scalar is zero.
  Time operator /(double scalar) {
    if (scalar == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return Time(value / scalar, unit);
  }
}
