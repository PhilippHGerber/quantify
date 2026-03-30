import 'package:meta/meta.dart';

import '../../../quantify.dart' show QuantityParseException;
import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parse_exception.dart' show QuantityParseException;
import '../../core/quantity_parser.dart';
import '../length/length.dart';
import '../length/length_extensions.dart';
import '../length/length_unit.dart';
import 'area_unit.dart';

/// Represents a quantity of area.
///
/// Area is a derived quantity representing the extent of a two-dimensional
/// surface or shape. The SI derived unit is the Square Meter (m²).
@immutable
final class Area extends LinearQuantity<AreaUnit, Area> {
  /// Creates a new `Area` quantity with the given numerical [value] and [unit].
  ///
  /// Example:
  /// ```dart
  /// final roomArea = Area(20.0, AreaUnit.squareMeter);
  /// final landArea = Area(2.5, AreaUnit.hectare);
  /// ```
  const Area(super._value, super._unit);

  /// Creates an [Area] from two [Length] values representing width and height (A = l × w).
  ///
  /// The result's unit is the squared counterpart of [l]'s unit when one exists
  /// (e.g. `inch` → `squareInch`). If no counterpart exists the result is in
  /// [AreaUnit.squareMeter]. [w] is converted to [l]'s unit before multiplying,
  /// so mixed-unit inputs work correctly.
  ///
  /// ```dart
  /// Area.from(5.m, 4.m);       // 20.0 m²
  /// Area.from(9.inch, 9.inch); // 81.0 in²
  /// Area.from(1.km, 500.m);    // 0.5 km²
  /// ```
  factory Area.from(Length l, Length w) {
    final targetUnit = _correspondingAreaUnit(l.unit);
    if (targetUnit != null) return Area(l.value * w.getValue(l.unit), targetUnit);
    return Area(l.inM * w.inM, AreaUnit.squareMeter);
  }

  /// Maps a [LengthUnit] to its corresponding [AreaUnit], or `null` when none exists.
  static AreaUnit? _correspondingAreaUnit(LengthUnit u) => switch (u) {
        LengthUnit.megameter => AreaUnit.squareMegameter,
        LengthUnit.kilometer => AreaUnit.squareKilometer,
        LengthUnit.hectometer => AreaUnit.squareHectometer,
        LengthUnit.decameter => AreaUnit.squareDecameter,
        LengthUnit.meter => AreaUnit.squareMeter,
        LengthUnit.decimeter => AreaUnit.squareDecimeter,
        LengthUnit.centimeter => AreaUnit.squareCentimeter,
        LengthUnit.millimeter => AreaUnit.squareMillimeter,
        LengthUnit.micrometer => AreaUnit.squareMicrometer,
        LengthUnit.inch => AreaUnit.squareInch,
        LengthUnit.foot => AreaUnit.squareFoot,
        LengthUnit.yard => AreaUnit.squareYard,
        LengthUnit.mile => AreaUnit.squareMile,
        _ => null, // gigameter, nanometer, nauticalMile, astronomical, etc.
      };

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
