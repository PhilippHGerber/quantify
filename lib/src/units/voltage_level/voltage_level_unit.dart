import 'package:meta/meta.dart';

import '../../core/unit.dart';

/// Represents units of absolute logarithmic voltage level.
enum VoltageLevelUnit implements Unit<VoltageLevelUnit> {
  /// Decibels referenced to one volt.
  dBV('dBV'),

  /// Decibels referenced to 0.7746 volts.
  dBu('dBu');

  /// Constant constructor for enum members.
  const VoltageLevelUnit(this.symbol);

  /// The display symbol for this voltage level unit.
  @override
  final String symbol;

  /// Unit symbols matched strictly case-sensitive.
  @internal
  static const Map<String, VoltageLevelUnit> symbolAliases = {
    'dBV': VoltageLevelUnit.dBV,
    'dBv': VoltageLevelUnit.dBV,
    'dBu': VoltageLevelUnit.dBu,
  };

  /// Full word-form names matched case-insensitively.
  @internal
  static const Map<String, VoltageLevelUnit> nameAliases = {
    'dbv': VoltageLevelUnit.dBV,
    'dbu': VoltageLevelUnit.dBu,
    'decibel volt': VoltageLevelUnit.dBV,
    'decibel volts': VoltageLevelUnit.dBV,
    'decibel unloaded': VoltageLevelUnit.dBu,
  };
}
