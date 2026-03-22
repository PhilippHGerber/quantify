import 'package:meta/meta.dart';

import '../../../quantify.dart' show QuantityParseException;
import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parse_exception.dart' show QuantityParseException;
import '../../core/quantity_parser.dart';
import '../area/area.dart';
import '../area/area_extensions.dart';
import '../length/length.dart';
import '../length/length_extensions.dart';
import 'volume_unit.dart';

/// Represents a quantity of volume.
///
/// Volume is a derived quantity representing the amount of three-dimensional
/// space occupied by a substance. The SI derived unit is the Cubic Meter (m³).
@immutable
class Volume extends LinearQuantity<VolumeUnit, Volume> {
  /// Creates a new `Volume` quantity with the given numerical [value] and [unit].
  const Volume(super._value, super._unit);

  /// Creates a [Volume] from three [Length] values (V = l × w × h).
  ///
  /// All lengths are converted to meters before multiplying, so mixed units
  /// work correctly. The result is in cubic meters.
  ///
  /// ```dart
  /// final box = Volume.from(2.m, 3.m, 4.m);       // 24.0 m³
  /// final pool = Volume.from(25.m, 10.m, 2.m);    // 500.0 m³
  /// ```
  factory Volume.from(Length l, Length w, Length h) =>
      Volume(l.inM * w.inM * h.inM, VolumeUnit.cubicMeter);

  /// Creates a [Volume] by extending an [Area] by a [Length] depth (V = A × d).
  ///
  /// Useful when you already have a cross-sectional [Area] and want to extrude
  /// it by a depth. Mixed units are handled automatically.
  ///
  /// ```dart
  /// final floor = Area.from(5.m, 4.m);            // 20 m²
  /// final room  = Volume.fromArea(floor, 2.5.m);  // 50.0 m³
  /// ```
  factory Volume.fromArea(Area area, Length depth) =>
      Volume(area.inSquareMeters * depth.inM, VolumeUnit.cubicMeter);

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
