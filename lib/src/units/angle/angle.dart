import 'package:meta/meta.dart';

import '../../../quantify.dart' show QuantityParseException;
import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parse_exception.dart' show QuantityParseException;
import '../../core/quantity_parser.dart';
import 'angle_unit.dart';

/// Represents a quantity of a plane angle.
///
/// Although angle is a dimensionless quantity in the SI system, it is treated
/// as a distinct quantity type for type safety and clarity. This class provides a
/// way to handle angle values and conversions between different units like
/// degrees, radians, and revolutions.
@immutable
final class Angle extends LinearQuantity<AngleUnit, Angle> {
  /// Creates a new `Angle` quantity with the given numerical [value] and [unit].
  const Angle(super._value, super._unit);

  @override
  @protected
  Angle create(double value, AngleUnit unit) => Angle(value, unit);

  /// The parser instance used to convert strings into [Angle] objects.
  ///
  /// The parser supports all standard units including symbols and full names.
  static final QuantityParser<AngleUnit, Angle> parser = QuantityParser<AngleUnit, Angle>(
    symbolAliases: AngleUnit.symbolAliases,
    nameAliases: AngleUnit.nameAliases,
    factory: Angle.new,
  );

  /// Parses a string representation of an angle into an [Angle] object.
  ///
  /// The [input] string should follow the format `"<number> <unit>"`, where the
  /// space between the number and unit is optional.
  ///
  /// By default, [formats] uses `[QuantityFormat.invariant]` which accepts
  /// period as decimal separator and ignores visual grouping separators.
  ///
  /// Throws [QuantityParseException] if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// final a1 = Angle.parse('90 deg');    // 90 degrees
  /// final a2 = Angle.parse('3.14 rad');  // 3.14 radians
  /// final a3 = Angle.parse('180°');      // 180 degrees (no space)
  /// ```
  static Angle parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Attempts to parse a string representation of angle. Returns `null` if parsing fails.
  ///
  /// See [parse] for format details.
  ///
  /// Example:
  /// ```dart
  /// final valid = Angle.tryParse('45 degrees');   // Angle(45.0, AngleUnit.degree)
  /// final invalid = Angle.tryParse('invalid');    // null
  /// ```
  static Angle? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }
}
