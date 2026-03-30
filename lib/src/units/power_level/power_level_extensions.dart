import '../power/power.dart';
import '../power/power_unit.dart';
import 'power_level.dart';
import 'power_level_unit.dart';

/// Provides convenient access to [PowerLevel] values in specific units.
extension PowerLevelValueGetters on PowerLevel {
  /// Returns the power level value in dBm.
  double get inDbm => getValue(PowerLevelUnit.dBm);

  /// Returns the power level value in dBW.
  double get inDbW => getValue(PowerLevelUnit.dBW);

  /// Returns a [PowerLevel] converted to dBm.
  PowerLevel get asDbm => convertTo(PowerLevelUnit.dBm);

  /// Returns a [PowerLevel] converted to dBW.
  PowerLevel get asDbW => convertTo(PowerLevelUnit.dBW);
}

/// Provides convenient factory methods for creating [PowerLevel] instances.
extension PowerLevelCreation on num {
  /// Creates a [PowerLevel] in dBm.
  PowerLevel get dBm => PowerLevel(toDouble(), PowerLevelUnit.dBm);

  /// Creates a [PowerLevel] in dBW.
  PowerLevel get dBW => PowerLevel(toDouble(), PowerLevelUnit.dBW);
}

/// Provides bridge helpers between [Power] and [PowerLevel].
extension PowerPowerLevelBridge on Power {
  /// Converts this power to a logarithmic [PowerLevel] using [targetUnit]'s reference.
  PowerLevel toPowerLevel(PowerLevelUnit targetUnit) {
    return PowerLevel.fromPower(this, unit: targetUnit);
  }

  /// Alias for [toPowerLevel].
  PowerLevel asPowerLevel(PowerLevelUnit targetUnit) => toPowerLevel(targetUnit);
}

/// Provides bridge helpers from [PowerLevel] back to [Power].
extension PowerLevelPowerBridge on PowerLevel {
  /// Converts this power level to linear [Power] in [targetUnit].
  Power asPower({PowerUnit targetUnit = PowerUnit.watt}) => toPower(targetUnit: targetUnit);

  /// Returns the equivalent power value in watts.
  double get inWatts => toPower().value;

  /// Converts this power level to [Power] in [targetUnit].
  Power asPowerIn(PowerUnit targetUnit) => toPower(targetUnit: targetUnit);
}
