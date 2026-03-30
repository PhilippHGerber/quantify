import 'package:meta/meta.dart';

import '../../core/linear_quantity.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parser.dart';
import 'level_ratio_unit.dart';

/// Represents a logarithmic level ratio such as gain or attenuation.
///
/// Unlike absolute logarithmic quantities like `dBm` or `dBV`, a [LevelRatio]
/// is a relative quantity and therefore remains linear with respect to
/// addition, subtraction, and scalar arithmetic.
///
/// The decibel values used here follow the amplitude convention, but the same
/// decibel delta still applies correctly to absolute power levels such as
/// `dBm` and `dBW`. A gain of `3 dB` represents the same underlying power
/// ratio regardless of whether the level originated from amplitude or power.
@immutable
final class LevelRatio extends LinearQuantity<LevelRatioUnit, LevelRatio> {
  /// Creates a new [LevelRatio] with the given [value] and [unit].
  const LevelRatio(super._value, super._unit);

  @override
  @protected
  LevelRatio create(double value, LevelRatioUnit unit) => LevelRatio(value, unit);

  /// The parser instance used to convert strings into [LevelRatio] objects.
  static final QuantityParser<LevelRatioUnit, LevelRatio> parser =
      QuantityParser<LevelRatioUnit, LevelRatio>(
    symbolAliases: LevelRatioUnit.symbolAliases,
    nameAliases: LevelRatioUnit.nameAliases,
    factory: LevelRatio.new,
  );

  /// Parses a string representation of a level ratio into a [LevelRatio].
  static LevelRatio parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Parses a string representation of a level ratio into a [LevelRatio],
  /// returning `null` when parsing fails.
  static LevelRatio? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }
}
