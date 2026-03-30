import 'dart:math' as math;

import 'package:meta/meta.dart';

import '../../core/logarithmic_quantity.dart';
import '../../core/math_utils.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parser.dart';
import '../level_ratio/level_ratio.dart';
import '../level_ratio/level_ratio_extensions.dart';
import '../level_ratio/level_ratio_unit.dart';
import '../power/power.dart';
import '../power/power_extensions.dart';
import '../power/power_unit.dart';
import 'power_level_unit.dart';

/// Represents an absolute logarithmic power level.
///
/// [PowerLevel] is logarithmic because it models an absolute level in dBm/dBW.
/// Valid arithmetic is limited to adding a relative [LevelRatio], subtracting
/// another [PowerLevel] to produce a [LevelRatio], and calling [subtract] for
/// level attenuation.
@immutable
final class PowerLevel extends LogarithmicQuantity<PowerLevelUnit, PowerLevel> {
  /// Creates a new [PowerLevel] with the given [value] and [unit].
  const PowerLevel(super._value, super._unit);

  /// Creates a [PowerLevel] from linear [Power] using an explicit reference unit.
  /// Note: Passing zero power yields [double.negativeInfinity]. Passing negative power yields [double.nan].
  factory PowerLevel.fromPower(
    Power power, {
    required PowerLevelUnit unit,
  }) {
    final watts = power.inWatts;
    final referenceWatts = switch (unit) {
      PowerLevelUnit.dBm => 1e-3,
      PowerLevelUnit.dBW => 1.0,
    };
    final level = 10.0 * log10(watts / referenceWatts);
    return PowerLevel(level, unit);
  }

  @override
  @protected
  PowerLevel create(double value, PowerLevelUnit unit) => PowerLevel(value, unit);

  /// The parser instance used to convert strings into [PowerLevel] objects.
  static final QuantityParser<PowerLevelUnit, PowerLevel> parser =
      QuantityParser<PowerLevelUnit, PowerLevel>(
    symbolAliases: PowerLevelUnit.symbolAliases,
    nameAliases: PowerLevelUnit.nameAliases,
    factory: PowerLevel.new,
  );

  /// Parses a string representation of a power level into a [PowerLevel].
  static PowerLevel parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Parses a string representation of a power level into a [PowerLevel],
  /// returning `null` when parsing fails.
  static PowerLevel? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }

  /// Converts this power level to [targetUnit].
  @override
  double getValue(PowerLevelUnit targetUnit) {
    if (targetUnit == unit) return value;

    final inDbW = switch (unit) {
      PowerLevelUnit.dBW => value,
      PowerLevelUnit.dBm => value - 30.0,
    };

    return switch (targetUnit) {
      PowerLevelUnit.dBW => inDbW,
      PowerLevelUnit.dBm => inDbW + 30.0,
    };
  }

  /// Bridges this logarithmic level back to linear [Power].
  Power toPower({PowerUnit targetUnit = PowerUnit.watt}) {
    final referenceWatts = switch (unit) {
      PowerLevelUnit.dBm => 1e-3,
      PowerLevelUnit.dBW => 1.0,
    };
    final watts = referenceWatts * math.pow(10.0, value / 10.0);
    return Power(watts, PowerUnit.watt).convertTo(targetUnit);
  }

  /// Adds a relative gain or attenuation to this absolute power level.
  PowerLevel operator +(LevelRatio gain) {
    return PowerLevel(value + gain.inDecibel, unit);
  }

  /// Subtracts [other] from this absolute power level and returns a relative
  /// [LevelRatio].
  LevelRatio operator -(PowerLevel other) {
    return LevelRatio(
      getValue(PowerLevelUnit.dBm) - other.getValue(PowerLevelUnit.dBm),
      LevelRatioUnit.decibel,
    );
  }

  /// Subtracts a relative gain or attenuation from this absolute power level.
  PowerLevel subtract(LevelRatio attenuation) {
    return PowerLevel(value - attenuation.inDecibel, unit);
  }
}
