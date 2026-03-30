import 'package:meta/meta.dart';

import '../../core/unit.dart';

/// Represents units of absolute power level.
///
/// [PowerLevelUnit] models logarithmic power referenced either to one
/// milliwatt (`dBm`) or one watt (`dBW`).
enum PowerLevelUnit implements Unit<PowerLevelUnit> {
  /// Decibels referenced to one milliwatt.
  dBm('dBm'),

  /// Decibels referenced to one watt.
  dBW('dBW');

  /// Constant constructor for enum members.
  const PowerLevelUnit(this.symbol);

  /// The display symbol for this power level unit.
  @override
  final String symbol;

  /// Unit symbols matched strictly case-sensitive.
  @internal
  static const Map<String, PowerLevelUnit> symbolAliases = {
    'dBm': PowerLevelUnit.dBm,
    'dBW': PowerLevelUnit.dBW,
  };

  /// Full word-form names matched case-insensitively.
  @internal
  static const Map<String, PowerLevelUnit> nameAliases = {
    'dbm': PowerLevelUnit.dBm,
    'dbw': PowerLevelUnit.dBW,
    'decibel milliwatt': PowerLevelUnit.dBm,
    'decibel milliwatts': PowerLevelUnit.dBm,
    'decibel watt': PowerLevelUnit.dBW,
    'decibel watts': PowerLevelUnit.dBW,
  };
}
