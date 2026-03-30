import 'package:meta/meta.dart';

import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parser.dart';
import 'solid_angle_unit.dart';

/// Represents a quantity of solid angle.
///
/// A solid angle is the two-dimensional angle in three-dimensional space that
/// an object subtends at a point. It is a measure of how large the object appears
/// to an observer looking from that point. The SI derived unit is the Steradian (sr).
@immutable
final class SolidAngle extends LinearQuantity<SolidAngleUnit, SolidAngle> {
  /// Creates a new `SolidAngle` with a given [value] and [unit].
  const SolidAngle(super._value, super._unit);

  @override
  @protected
  SolidAngle create(double value, SolidAngleUnit unit) => SolidAngle(value, unit);

  /// The parser instance used to convert strings into [SolidAngle] objects.
  ///
  /// The parser supports both strict symbol aliases and case-insensitive name
  /// aliases configured in [SolidAngleUnit].
  static final QuantityParser<SolidAngleUnit, SolidAngle> parser =
      QuantityParser<SolidAngleUnit, SolidAngle>(
    symbolAliases: SolidAngleUnit.symbolAliases,
    nameAliases: SolidAngleUnit.nameAliases,
    factory: SolidAngle.new,
  );

  /// Parses a string representation of solid angle into a [SolidAngle] object.
  ///
  /// The [formats] list controls how the numeric portion is interpreted.
  static SolidAngle parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Parses a string representation of solid angle into a [SolidAngle] object,
  /// returning `null` when parsing fails.
  ///
  /// See [parse] for formatting and matching behavior.
  static SolidAngle? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }
}
