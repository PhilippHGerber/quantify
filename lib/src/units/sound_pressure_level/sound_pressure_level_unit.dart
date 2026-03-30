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
