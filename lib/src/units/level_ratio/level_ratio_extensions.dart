import 'level_ratio.dart';
import 'level_ratio_unit.dart';

// Unit symbol getters intentionally preserve domain notation.
// ignore_for_file: non_constant_identifier_names

/// Provides convenient access to [LevelRatio] values in specific units.
extension LevelRatioValueGetters on LevelRatio {
  /// Returns the level ratio value in decibels (dB).
  double get inDecibel => getValue(LevelRatioUnit.decibel);

  /// Alias for [inDecibel].
  double get inDecibels => inDecibel;

  /// Short alias for [inDecibel].
  double get inDb => inDecibel;

  /// Returns the level ratio value in nepers (Np).
  double get inNeper => getValue(LevelRatioUnit.neper);

  /// Alias for [inNeper].
  double get inNepers => inNeper;

  /// Returns a [LevelRatio] converted to decibels.
  LevelRatio get asDecibel => convertTo(LevelRatioUnit.decibel);

  /// Alias for [asDecibel].
  LevelRatio get asDecibels => asDecibel;

  /// Short alias for [asDecibel].
  LevelRatio get asDb => asDecibel;

  /// Returns a [LevelRatio] converted to nepers.
  LevelRatio get asNeper => convertTo(LevelRatioUnit.neper);

  /// Alias for [asNeper].
  LevelRatio get asNepers => asNeper;
}

/// Provides convenient factory methods for creating [LevelRatio] instances.
extension LevelRatioCreation on num {
  /// Creates a [LevelRatio] in decibels (dB).
  LevelRatio get dB => LevelRatio(toDouble(), LevelRatioUnit.decibel);

  /// Creates a [LevelRatio] in decibels (dB).
  LevelRatio get decibel => LevelRatio(toDouble(), LevelRatioUnit.decibel);

  /// Alias for [decibel].
  LevelRatio get decibels => LevelRatio(toDouble(), LevelRatioUnit.decibel);

  /// Creates a [LevelRatio] in nepers (Np).
  LevelRatio get Np => LevelRatio(toDouble(), LevelRatioUnit.neper);

  /// Creates a [LevelRatio] in nepers (Np).
  LevelRatio get neper => LevelRatio(toDouble(), LevelRatioUnit.neper);

  /// Alias for [neper].
  LevelRatio get nepers => LevelRatio(toDouble(), LevelRatioUnit.neper);
}
