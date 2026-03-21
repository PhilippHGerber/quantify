import 'package:meta/meta.dart';

import '../../core/quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parser.dart';
import 'length_unit.dart';

/// Represents a physical quantity of length.
///
/// Length is a fundamental physical quantity representing the distance between
/// two points. The SI base unit is the Meter (m).
///
/// This class provides a type-safe way to handle length values, convert between
/// different units (e.g., meters, feet, miles), and perform arithmetic operations.
@immutable
class Length extends Quantity<LengthUnit> {
  /// Creates a new [Length] quantity with the given numerical[value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final distance = Length(1500.0, LengthUnit.meter);
  /// final height = Length(6.0, LengthUnit.foot);
  /// ```
  const Length(super._value, super._unit);

  /// The parser instance used to convert strings into [Length] objects.
  ///
  /// The parser supports all standard units and handles both case-sensitive SI
  /// symbols (like `Mm` vs `mm`) and case-insensitive unit names.
  ///
  /// Create isolated parser variants to support custom or localized aliases:
  /// ```dart
  /// final customParser = Length.parser.copyWithAliases(
  ///   extraNameAliases: {'pulgada': LengthUnit.inch},
  /// );
  /// final custom = customParser.parse('50 pulgada');
  /// ```
  static final QuantityParser<LengthUnit, Length> parser = QuantityParser<LengthUnit, Length>(
    symbolAliases: LengthUnit.symbolAliases,
    nameAliases: LengthUnit.nameAliases,
    factory: Length.new,
  );

  /// Converts this length's value to the specified [targetUnit].
  ///
  /// This method uses pre-calculated direct conversion factors from the [LengthUnit]
  /// enum for optimal efficiency.
  ///
  /// Example:
  /// ```dart
  /// final dist = Length(2.5, LengthUnit.kilometer);
  /// final meters = dist.getValue(LengthUnit.meter); // 2500.0
  /// ```
  @override
  double getValue(LengthUnit targetUnit) {
    if (targetUnit == unit) return value;
    return value * unit.factorTo(targetUnit);
  }

  /// Creates a new[Length] instance with the value converted to the [targetUnit].
  ///
  /// This is useful for obtaining a new `Length` object in a different unit
  /// without losing type information or immutability.
  ///
  /// Example:
  /// ```dart
  /// final oneFoot = Length(1.0, LengthUnit.foot);
  /// final inInches = oneFoot.convertTo(LengthUnit.inch); // Length(12.0, LengthUnit.inch)
  /// ```
  @override
  Length convertTo(LengthUnit targetUnit) {
    if (targetUnit == unit) return this;
    final newValue = getValue(targetUnit);
    return Length(newValue, targetUnit);
  }

  /// Compares this [Length] object to another [Quantity<LengthUnit>].
  ///
  /// Comparison is based on the true physical magnitude of the lengths,
  /// automatically handling unit conversions internally.
  ///
  /// Returns:
  /// - A negative integer if this length is less than [other].
  /// - Zero if this length is physically equal to [other].
  /// - A positive integer if this length is greater than [other].
  @override
  int compareTo(Quantity<LengthUnit> other) {
    final thisValueInOtherUnit = getValue(other.unit);
    return thisValueInOtherUnit.compareTo(other.value);
  }

  /// Parses a string representation of a length into a [Length] object.
  ///
  /// The [input] string should follow the format `"<number> <unit>"`, where the
  /// space between the number and unit is optional.
  ///
  /// - **SI Prefixes**: Strictly case-sensitive (`10 mm` is millimeters,
  ///   `10 Mm` is megameters).
  /// - **Imperial/US Units**: Case-insensitive (`6 ft`, `6 FT`, and `6 Ft`
  ///   all parse correctly).
  ///
  /// The [formats] list controls how the numeric portion is interpreted. Formats
  /// are tried in order; the first that successfully parses the number wins.
  /// Defaults to [QuantityFormat.invariant] (Dart-native dot-decimal parsing).
  ///
  /// Throws a [FormatException] if no format can parse the input.
  ///
  /// Example:
  /// ```dart
  /// final dist = Length.parse('10.5 km');
  /// final de = Length.parse('1.234,56 m', formats: [QuantityFormat.de]);
  /// ```
  static Length parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) =>
      parser.parse(input, formats: formats);

  /// Parses a string representation of a length into a [Length] object,
  /// returning `null` if the string cannot be parsed.
  ///
  /// The [input] string should follow the format `"<number> <unit>"`.
  /// See [parse] for details on [formats].
  ///
  /// Example:
  /// ```dart
  /// final dist = Length.tryParse('10.5 km'); // Length(10.5, ...)
  /// final bad = Length.tryParse('not a length'); // null
  /// ```
  static Length? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) =>
      parser.tryParse(input, formats: formats);

  // --- Arithmetic Operators ---

  /// Adds this length to another length.
  ///
  /// The [other] length is converted to the unit of this length before addition.
  /// Returns a new [Length] instance.
  Length operator +(Length other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Length(value + otherValueInThisUnit, unit);
  }

  /// Subtracts another length from this length.
  ///
  /// The [other] length is converted to the unit of this length before subtraction.
  /// Returns a new [Length] instance.
  Length operator -(Length other) {
    final otherValueInThisUnit = other.getValue(unit);
    return Length(value - otherValueInThisUnit, unit);
  }

  /// Multiplies this length by a dimensionless scalar value.
  ///
  /// Returns a new [Length] instance with the scaled value in the original unit.
  Length operator *(double scalar) {
    return Length(value * scalar, unit);
  }

  /// Divides this length by a dimensionless scalar value.
  ///
  /// Returns a new [Length] instance with the scaled value in the original unit.
  /// Throws an [ArgumentError] if the scalar is zero.
  Length operator /(double scalar) {
    if (scalar == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return Length(value / scalar, unit);
  }
}
