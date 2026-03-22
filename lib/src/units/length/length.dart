import 'package:meta/meta.dart';

import '../../core/linear_quantity.dart';
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
class Length extends LinearQuantity<LengthUnit, Length> {
  /// Creates a new [Length] quantity with the given numerical[value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final distance = Length(1500.0, LengthUnit.meter);
  /// final height = Length(6.0, LengthUnit.foot);
  /// ```
  const Length(super._value, super._unit);

  @override
  @protected
  Length create(double value, LengthUnit unit) => Length(value, unit);

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
}
