import 'dart:math' as math;

import 'package:meta/meta.dart';

import '../../core/logarithmic_quantity.dart';
import '../../core/math_utils.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parser.dart';
import '../level_ratio/level_ratio.dart';
import '../level_ratio/level_ratio_extensions.dart';
import '../level_ratio/level_ratio_unit.dart';
import '../voltage/voltage.dart';
import '../voltage/voltage_extensions.dart';
import '../voltage/voltage_unit.dart';
import 'voltage_level_unit.dart';

/// Represents an absolute logarithmic voltage level.
///
/// [VoltageLevel] is logarithmic because it models an absolute level in dBV/dBu.
/// Valid arithmetic is limited to adding a relative [LevelRatio], subtracting
/// another [VoltageLevel] to produce a [LevelRatio], and calling [subtract] for
/// level attenuation.
@immutable
final class VoltageLevel extends LogarithmicQuantity<VoltageLevelUnit, VoltageLevel> {
  /// Creates a new [VoltageLevel] with the given [value] and [unit].
  const VoltageLevel(super._value, super._unit);

  /// Creates a [VoltageLevel] from linear [Voltage] using an explicit reference unit.
  /// Note: Passing zero voltage yields [double.negativeInfinity]. Passing negative voltage yields [double.nan].
  factory VoltageLevel.fromVoltage(
    Voltage voltage, {
    required VoltageLevelUnit unit,
  }) {
    final volts = voltage.inVolts;
    final referenceVolts = switch (unit) {
      VoltageLevelUnit.dBV => 1.0,
      VoltageLevelUnit.dBu => math.sqrt(0.6),
    };
    final level = 20.0 * log10(volts / referenceVolts);
    return VoltageLevel(level, unit);
  }

  /// Offset between dBu and dBV.
  ///
  /// Exact derivation: 0 dBu = sqrt(0.6) volts.
  static final double dBuOffsetFromDbV = 20.0 * log10(1.0 / math.sqrt(0.6));

  @override
  @protected
  VoltageLevel create(double value, VoltageLevelUnit unit) => VoltageLevel(value, unit);

  /// The parser instance used to convert strings into [VoltageLevel] objects.
  static final QuantityParser<VoltageLevelUnit, VoltageLevel> parser =
      QuantityParser<VoltageLevelUnit, VoltageLevel>(
    symbolAliases: VoltageLevelUnit.symbolAliases,
    nameAliases: VoltageLevelUnit.nameAliases,
    factory: VoltageLevel.new,
  );

  /// Parses a string representation of a voltage level into a [VoltageLevel].
  static VoltageLevel parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Parses a string representation of a voltage level into a [VoltageLevel],
  /// returning `null` when parsing fails.
  static VoltageLevel? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }

  /// Converts this voltage level to [targetUnit].
  @override
  double getValue(VoltageLevelUnit targetUnit) {
    if (targetUnit == unit) return value;

    final inDbV = switch (unit) {
      VoltageLevelUnit.dBV => value,
      VoltageLevelUnit.dBu => value - dBuOffsetFromDbV,
    };

    return switch (targetUnit) {
      VoltageLevelUnit.dBV => inDbV,
      VoltageLevelUnit.dBu => inDbV + dBuOffsetFromDbV,
    };
  }

  /// Bridges this logarithmic level back to linear [Voltage].
  Voltage toVoltage({VoltageUnit targetUnit = VoltageUnit.volt}) {
    final referenceVolts = switch (unit) {
      VoltageLevelUnit.dBV => 1.0,
      VoltageLevelUnit.dBu => math.sqrt(0.6),
    };
    final volts = referenceVolts * math.pow(10.0, value / 20.0);
    return Voltage(volts, VoltageUnit.volt).convertTo(targetUnit);
  }

  /// Adds a relative gain or attenuation to this absolute voltage level.
  VoltageLevel operator +(LevelRatio gain) {
    return VoltageLevel(value + gain.inDecibel, unit);
  }

  /// Subtracts [other] from this absolute voltage level and returns a relative
  /// [LevelRatio].
  LevelRatio operator -(VoltageLevel other) {
    return LevelRatio(
      getValue(VoltageLevelUnit.dBV) - other.getValue(VoltageLevelUnit.dBV),
      LevelRatioUnit.decibel,
    );
  }

  /// Subtracts a relative gain or attenuation from this absolute voltage level.
  VoltageLevel subtract(LevelRatio attenuation) {
    return VoltageLevel(value - attenuation.inDecibel, unit);
  }
}
