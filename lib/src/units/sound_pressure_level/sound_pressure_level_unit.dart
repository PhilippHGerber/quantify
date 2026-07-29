import 'package:meta/meta.dart';

import '../../core/unit.dart';

/// Represents units of sound pressure level.
enum SoundPressureLevelUnit implements Unit<SoundPressureLevelUnit> {
  /// Decibels relative to 20 µPa.
  decibelSpl('dB SPL');

  /// Constant constructor for enum members.
  const SoundPressureLevelUnit(this.symbol);

  /// The display symbol for this sound pressure level unit.
  @override
  final String symbol;

  /// Logarithmic decibel-based sound pressure levels are not SI units, so
  /// this always returns `false`.
  @override
  bool get isSI => false;

  /// Returns `false` for all units, since logarithmic ratio units are not
  /// tied to any unit system.
  @override
  bool get isMetric => false;

  /// Unit symbols matched strictly case-sensitive.
  @internal
  static const Map<String, SoundPressureLevelUnit> symbolAliases = {
    'dB SPL': SoundPressureLevelUnit.decibelSpl,
    'dBSPL': SoundPressureLevelUnit.decibelSpl,
    'dB spl': SoundPressureLevelUnit.decibelSpl,
  };

  /// Full word-form names matched case-insensitively.
  @internal
  static const Map<String, SoundPressureLevelUnit> nameAliases = {
    'db spl': SoundPressureLevelUnit.decibelSpl,
    'dbspl': SoundPressureLevelUnit.decibelSpl,
    'decibel spl': SoundPressureLevelUnit.decibelSpl,
    'decibel sound pressure level': SoundPressureLevelUnit.decibelSpl,
    'sound pressure level': SoundPressureLevelUnit.decibelSpl,
  };
}
