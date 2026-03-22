import 'package:meta/meta.dart';

import '../../../quantify.dart' show QuantityParseException;
import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parse_exception.dart' show QuantityParseException;
import '../../core/quantity_parser.dart';
import 'volume_unit.dart';

/// Represents a quantity of volume.
///
/// Volume is a derived quantity representing the amount of three-dimensional
/// space occupied by a substance. The SI derived unit is the Cubic Meter (m³).
@immutable
class Volume extends LinearQuantity<VolumeUnit, Volume> {
  /// Creates a new `Volume` quantity with the given numerical [value] and [unit].
  const Volume(super._value, super._unit);

  @override
  @protected
  Volume create(double value, VolumeUnit unit) => Volume(value, unit);

  /// The parser instance used to convert strings into [Volume] objects.
  ///
  /// The parser supports all standard units including symbols and full names.
  static final QuantityParser<VolumeUnit, Volume> parser = QuantityParser<VolumeUnit, Volume>(
    symbolAliases: VolumeUnit.symbolAliases,
    nameAliases: VolumeUnit.nameAliases,
    factory: Volume.new,
  );

  /// Parses a string representation of a volume into a [Volume] object.
  ///
  /// Throws [QuantityParseException] if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// final v1 = Volume.parse('1 L');     // 1 liter
  /// final v2 = Volume.parse('500 mL');  // 500 milliliters
  /// final v3 = Volume.parse('2.5 gal'); // 2.5 gallons
  /// ```
  static Volume parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Attempts to parse a string representation of volume. Returns `null` if parsing fails.
  ///
  /// Example:
  /// ```dart
  /// final valid = Volume.tryParse('1 liter');  // Volume(1.0, VolumeUnit.litre)
  /// final invalid = Volume.tryParse('invalid'); // null
  /// ```
  static Volume? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }
}
