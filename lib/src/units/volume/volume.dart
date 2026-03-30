import 'package:meta/meta.dart';

import '../../../quantify.dart' show QuantityParseException;
import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parse_exception.dart' show QuantityParseException;
import '../../core/quantity_parser.dart';
import '../area/area.dart';
import '../area/area_extensions.dart';
import '../area/area_unit.dart';
import '../length/length.dart';
import '../length/length_extensions.dart';
import '../length/length_unit.dart';
import 'volume_unit.dart';

/// Represents a quantity of volume.
///
/// Volume is a derived quantity representing the amount of three-dimensional
/// space occupied by a substance. The SI derived unit is the Cubic Meter (m³).
@immutable
final class Volume extends LinearQuantity<VolumeUnit, Volume> {
  /// Creates a new `Volume` quantity with the given numerical [value] and [unit].
  const Volume(super._value, super._unit);

  /// Creates a [Volume] from three [Length] values (V = l × w × h).
  ///
  /// The result's unit is the cubic counterpart of [l]'s unit when one exists
  /// (e.g. `foot` → `cubicFoot`). If no counterpart exists the result is in
  /// [VolumeUnit.cubicMeter]. [w] and [h] are converted to [l]'s unit before
  /// multiplying, so mixed-unit inputs work correctly.
  ///
  /// ```dart
  /// Volume.from(2.m, 3.m, 4.m);        // 24.0 m³
  /// Volume.from(2.ft, 3.ft, 4.ft);     // 24.0 ft³
  /// Volume.from(2.ft, 3.ft, 1.yard);   // 6.0 ft³ (1 yd = 3 ft)
  /// ```
  factory Volume.from(Length l, Length w, Length h) {
    final target = _correspondingVolumeUnit(l.unit);
    if (target != null) {
      return Volume(l.value * w.getValue(l.unit) * h.getValue(l.unit), target);
    }
    return Volume(l.inM * w.inM * h.inM, VolumeUnit.cubicMeter);
  }

  /// Creates a [Volume] by extending an [Area] by a [Length] depth (V = A × d).
  ///
  /// The result's unit is the cubic counterpart of [area]'s unit when one exists
  /// (e.g. `squareFoot` → `cubicFoot`). If no counterpart exists the result is in
  /// [VolumeUnit.cubicMeter]. [depth] is converted to the matching linear unit
  /// automatically.
  ///
  /// ```dart
  /// Volume.fromArea(Area.from(5.m, 4.m), 2.5.m);     // 50.0 m³
  /// Volume.fromArea(Area.from(5.ft, 4.ft), 2.5.ft);  // 50.0 ft³
  /// ```
  factory Volume.fromArea(Area area, Length depth) {
    final target = _correspondingVolumeUnitFromArea(area.unit);
    final linearUnit = _correspondingLengthUnitFromArea(area.unit);
    if (target != null && linearUnit != null) {
      return Volume(area.value * depth.getValue(linearUnit), target);
    }
    return Volume(area.inSquareMeters * depth.inM, VolumeUnit.cubicMeter);
  }

  /// Maps a [LengthUnit] to its corresponding cubic [VolumeUnit], or `null` when none exists.
  static VolumeUnit? _correspondingVolumeUnit(LengthUnit u) => switch (u) {
        LengthUnit.kilometer => VolumeUnit.cubicKilometer,
        LengthUnit.hectometer => VolumeUnit.cubicHectometer,
        LengthUnit.decameter => VolumeUnit.cubicDecameter,
        LengthUnit.meter => VolumeUnit.cubicMeter,
        LengthUnit.decimeter => VolumeUnit.cubicDecimeter,
        LengthUnit.centimeter => VolumeUnit.cubicCentimeter,
        LengthUnit.millimeter => VolumeUnit.cubicMillimeter,
        LengthUnit.inch => VolumeUnit.cubicInch,
        LengthUnit.foot => VolumeUnit.cubicFoot,
        LengthUnit.mile => VolumeUnit.cubicMile,
        _ => null, // yard, nauticalMile, micrometer, megameter, etc.
      };

  /// Maps an [AreaUnit] to its corresponding cubic [VolumeUnit], or `null` when none exists.
  static VolumeUnit? _correspondingVolumeUnitFromArea(AreaUnit u) => switch (u) {
        AreaUnit.squareKilometer => VolumeUnit.cubicKilometer,
        AreaUnit.squareMeter => VolumeUnit.cubicMeter,
        AreaUnit.squareDecimeter => VolumeUnit.cubicDecimeter,
        AreaUnit.squareCentimeter => VolumeUnit.cubicCentimeter,
        AreaUnit.squareMillimeter => VolumeUnit.cubicMillimeter,
        AreaUnit.squareInch => VolumeUnit.cubicInch,
        AreaUnit.squareFoot => VolumeUnit.cubicFoot,
        AreaUnit.squareMile => VolumeUnit.cubicMile,
        _ => null, // hectare, acre, squareYard, etc.
      };

  /// Maps an [AreaUnit] to the [LengthUnit] needed to convert depth for [Volume.fromArea].
  static LengthUnit? _correspondingLengthUnitFromArea(AreaUnit u) => switch (u) {
        AreaUnit.squareKilometer => LengthUnit.kilometer,
        AreaUnit.squareMeter => LengthUnit.meter,
        AreaUnit.squareDecimeter => LengthUnit.decimeter,
        AreaUnit.squareCentimeter => LengthUnit.centimeter,
        AreaUnit.squareMillimeter => LengthUnit.millimeter,
        AreaUnit.squareInch => LengthUnit.inch,
        AreaUnit.squareFoot => LengthUnit.foot,
        AreaUnit.squareMile => LengthUnit.mile,
        _ => null,
      };

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
