import 'package:meta/meta.dart';

import '../../../quantify.dart' show QuantityParseException;
import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parse_exception.dart' show QuantityParseException;
import '../../core/quantity_parser.dart';
import 'area_unit.dart';

/// Represents a quantity of area.
///
/// Area is a derived quantity representing the extent of a two-dimensional
/// surface or shape. The SI derived unit is the Square Meter (m²).
@immutable
class Area extends LinearQuantity<AreaUnit, Area> {
  /// Creates a new `Area` quantity with the given numerical [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final roomArea = Area(20.0, AreaUnit.squareMeter);
  /// final landArea = Area(2.5, AreaUnit.hectare);
  /// ```
  const Area(super._value, super._unit);

  @override
  @protected
  Area create(double value, AreaUnit unit) => Area(value, unit);

  /// The parser instance used to convert strings into [Area] objects.
  ///
  /// The parser supports all standard units including symbols and full names.
  static final QuantityParser<AreaUnit, Area> parser = QuantityParser<AreaUnit, Area>(
    symbolAliases: AreaUnit.symbolAliases,
    nameAliases: AreaUnit.nameAliases,
    factory: Area.new,
  );

  /// Parses a string representation of an area into an [Area] object.
  ///
  /// The [input] string should follow the format `"<number> <unit>"`, where the
  /// space between the number and unit is optional.
  ///
  /// By default, [formats] uses `[QuantityFormat.invariant]`.
  ///
  /// Throws [QuantityParseException] if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// final a1 = Area.parse('100 m²');   // 100 square meters
  /// final a2 = Area.parse('2.5 ha');   // 2.5 hectares
  /// final a3 = Area.parse('500 sq ft'); // 500 square feet
  /// ```
  static Area parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Attempts to parse a string representation of area. Returns `null` if parsing fails.
  ///
  /// See [parse] for format details.
  ///
  /// Example:
  /// ```dart
  /// final valid = Area.tryParse('25 m²');   // Area(25.0, AreaUnit.squareMeter)
  /// final invalid = Area.tryParse('invalid'); // null
  /// ```
  static Area? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }
}
