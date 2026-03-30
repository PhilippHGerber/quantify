import 'package:meta/meta.dart';

import '../../core/unit.dart';
import 'level_ratio_factors.dart';

/// Represents units of logarithmic level ratio.
///
/// [LevelRatioUnit] models relative gain or attenuation, not an absolute level.
/// The base unit for internal conversion is decibel (dB).
enum LevelRatioUnit implements LinearUnit<LevelRatioUnit> {
  /// Decibel (dB), the base unit for level ratio conversions.
  decibel(1, 'dB'),

  /// Neper (Np), using the amplitude convention.
  neper(LevelRatioFactors.decibelsPerNeper, 'Np');

  /// Constant constructor for enum members.
  const LevelRatioUnit(double toDecibelFactor, this.symbol)
      : _factorToDecibel = toDecibelFactor / 1.0,
        _factorToNeper = toDecibelFactor / LevelRatioFactors.decibelsPerNeper;

  /// The display symbol for this level ratio unit.
  @override
  final String symbol;

  final double _factorToDecibel;
  final double _factorToNeper;

  /// SI and unit symbols matched strictly case-sensitive.
  @internal
  static const Map<String, LevelRatioUnit> symbolAliases = {
    'dB': LevelRatioUnit.decibel,
    'Np': LevelRatioUnit.neper,
  };

  /// Full word-form names matched case-insensitively.
  @internal
  static const Map<String, LevelRatioUnit> nameAliases = {
    'decibel': LevelRatioUnit.decibel,
    'decibels': LevelRatioUnit.decibel,
    'neper': LevelRatioUnit.neper,
    'nepers': LevelRatioUnit.neper,
  };

  /// Returns the direct conversion factor from this unit to [targetUnit].
  @override
  @internal
  double factorTo(LevelRatioUnit targetUnit) {
    switch (targetUnit) {
      case LevelRatioUnit.decibel:
        return _factorToDecibel;
      case LevelRatioUnit.neper:
        return _factorToNeper;
    }
  }
}
