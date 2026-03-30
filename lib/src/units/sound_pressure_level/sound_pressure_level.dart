import 'dart:math' as math;

import 'package:meta/meta.dart';

import '../../core/logarithmic_quantity.dart';
import '../../core/math_utils.dart';
import '../../core/quantity_format.dart';
import '../../core/quantity_parser.dart';
import '../level_ratio/level_ratio.dart';
import '../level_ratio/level_ratio_extensions.dart';
import '../level_ratio/level_ratio_unit.dart';
import '../pressure/pressure.dart';
import '../pressure/pressure_extensions.dart';
import '../pressure/pressure_unit.dart';
import 'sound_pressure_level_unit.dart';

/// Represents an absolute sound pressure level.
///
/// [SoundPressureLevel] is a logarithmic quantity bridged to linear [Pressure]
/// via the ISO 1683 reference pressure of 20 µPa.
@immutable
final class SoundPressureLevel
    extends LogarithmicQuantity<SoundPressureLevelUnit, SoundPressureLevel> {
  /// Creates a new [SoundPressureLevel] with the given [value] and [unit].
  const SoundPressureLevel(super._value, super._unit);

  /// Creates a [SoundPressureLevel] from a linear [Pressure].
  factory SoundPressureLevel.fromPressure(Pressure pressure) {
    final pascal = pressure.inPa;
    final dbSpl = 20.0 * log10(pascal / referencePressurePa);
    return SoundPressureLevel(dbSpl, SoundPressureLevelUnit.decibelSpl);
  }

  /// Reference pressure in pascals for 0 dB SPL.
  static const double referencePressurePa = 20e-6;

  @override
  @protected
  SoundPressureLevel create(double value, SoundPressureLevelUnit unit) {
    return SoundPressureLevel(value, unit);
  }

  /// The parser instance used to convert strings into [SoundPressureLevel].
  static final QuantityParser<SoundPressureLevelUnit, SoundPressureLevel> parser =
      QuantityParser<SoundPressureLevelUnit, SoundPressureLevel>(
    symbolAliases: SoundPressureLevelUnit.symbolAliases,
    nameAliases: SoundPressureLevelUnit.nameAliases,
    factory: SoundPressureLevel.new,
  );

  /// Parses a string representation of sound pressure level into a quantity.
  static SoundPressureLevel parse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.parse(input, formats: formats);
  }

  /// Parses a string representation of sound pressure level, returning `null` on failure.
  static SoundPressureLevel? tryParse(
    String input, {
    List<QuantityFormat> formats = const [QuantityFormat.invariant],
  }) {
    return parser.tryParse(input, formats: formats);
  }

  /// Converts this sound pressure level to [targetUnit].
  @override
  double getValue(SoundPressureLevelUnit targetUnit) {
    if (targetUnit == unit) return value;
    return switch (targetUnit) {
      SoundPressureLevelUnit.decibelSpl => value,
    };
  }

  /// Bridges this logarithmic level back to linear [Pressure].
  Pressure toPressure() {
    final pascal = referencePressurePa * math.pow(10.0, value / 20.0);
    return Pressure(pascal, PressureUnit.pascal);
  }

  /// Adds a relative gain or attenuation to this absolute level.
  SoundPressureLevel operator +(LevelRatio gain) {
    return SoundPressureLevel(value + gain.inDecibel, unit);
  }

  /// Subtracts [other] from this absolute level and returns a relative
  /// [LevelRatio].
  LevelRatio operator -(SoundPressureLevel other) {
    return LevelRatio(value - other.value, LevelRatioUnit.decibel);
  }

  /// Subtracts a relative gain or attenuation from this absolute level.
  SoundPressureLevel subtract(LevelRatio attenuation) {
    return SoundPressureLevel(value - attenuation.inDecibel, unit);
  }
}
